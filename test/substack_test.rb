require "minitest/autorun"
require "json"
require "tmpdir"
require "fileutils"

module Jekyll
  class Command
    def self.add_build_options(_command); end
  end unless const_defined?(:Command)
end

require_relative "../plugins/jekyll-substack/lib/jekyll/substack"

class SubstackConverterTest < Minitest::Test
  Post = Struct.new(:path, :url, :data)

  def setup
    @post = Post.new(
      "_posts/2026-08-31-example.md",
      "/blog/2026/08/example/",
      {
        "title" => "An example",
        "subtitle" => "An example subtitle",
        "description" => "A description",
        "tags" => ["Ruby", "Jekyll", "A tag", "Four"],
        "seoimage" => "3020/cover.png"
      }
    )
    @converter = Jekyll::Substack::Converter.new(
      posts: { "2026-08-31-example" => @post.url }
    )
  end

  def test_converts_front_matter_images_and_cta
    source = <<~MARKDOWN
      ---
      title: An example
      subtitle: An example subtitle
      ---
      {% include image.html
      url="/static/postimages/example.png"
      desc="An example image"
      %}

      ![Relative image](/static/postimages/inline.png)

      Inline $x^2$ and:

      $$
      x^2 + y^2
      $$
    MARKDOWN

    result = @converter.convert(@post, source)

    assert_match(/\A---[\s\S]*?---\n\n\*This post was originally published on \[fpira\.com\]\(https:\/\/fpira\.com\/blog\/2026\/08\/example\/\)\.\*/, result)
    assert_includes result, "draft: true"
    assert_includes result, "subtitle: \"An example subtitle\""
    assert_includes result, "tags: Ruby, Jekyll, A tag, Four"
    assert_includes result, "cover_image: https://fpira.com/static/postimages/3020/cover.png"
    assert_includes result, "![An example image](https://fpira.com/static/postimages/example.png)"
    assert_includes result, "![Relative image](https://fpira.com/static/postimages/inline.png)"
    assert_includes result, "Inline $x^2$"
    assert_includes result, "$$\nx^2 + y^2\n$$"
    assert_includes result, "Thanks for reading! If you enjoyed this post, consider subscribing to the newsletter or visiting [fpira.com](https://fpira.com) for more articles."
  end

  def test_generates_curl_ready_json_draft_payload
    payload = JSON.parse(@converter.convert_json(@post, "---\ntitle: An example\n---\nContent\n"))

    assert_equal "An example", payload["draft_title"]
    assert_equal "An example subtitle", payload["draft_subtitle"]
    assert_equal true, payload["draft"]
    assert_equal "newsletter", payload["type"]
    assert_equal ["Ruby", "Jekyll", "A tag", "Four"], payload["tags"]
    assert_equal "A description", payload["description"]
    assert_equal "https://fpira.com/blog/2026/08/example/", payload["canonical_url"]
    assert_equal "https://fpira.com/static/postimages/3020/cover.png", payload["cover_image"]
    assert_includes payload["body_markdown"], "*This post was originally published on [fpira.com](https://fpira.com/blog/2026/08/example/).*"
    assert_includes payload["body_markdown"], "Thanks for reading! If you enjoyed this post"
    assert_includes payload["draft_body"], "<p><em>This post was originally published on"
  end

  def test_converts_seoimage_using_site_url_and_baseurl
    converter = Jekyll::Substack::Converter.new(site_url: "https://example.com", baseurl: "/blog")
    post = Post.new("_posts/2026-08-31-example.md", "/blog/example/", { "title" => "An example", "seoimage" => "/assets/cover.png" })

    result = converter.convert(post, "---\ntitle: An example\n---\nContent\n")

    assert_includes result, "cover_image: https://example.com/blog/assets/cover.png"
    assert_includes result, "visiting [fpira.com](https://example.com) for more articles."
  end

  def test_converts_post_urls_youtube_and_gist
    source = <<~MARKDOWN
      ---
      title: An example
      ---
      See {% post_url 2026-08-31-example %}, {% youtube abc123 %}, and {% gist pirafrank/456 %}.
    MARKDOWN

    result = @converter.convert(@post, source)

    assert_includes result, "https://fpira.com/blog/2026/08/example/"
    assert_includes result, "https://www.youtube.com/watch?v=abc123"
    assert_includes result, "https://gist.github.com/pirafrank/456"
  end

  def test_rejects_unresolved_liquid
    source = <<~MARKDOWN
      ---
      title: An example
      ---
      {{ site.data.unknown }}
    MARKDOWN

    error = assert_raises(Jekyll::Substack::ConversionError) { @converter.convert(@post, source) }
    assert_match(/unsupported Liquid/, error.message)
  end

  def test_command_reads_posts_including_future_but_not_drafts
    source_dir = Dir.mktmpdir("substack-test-")
    posts_dir = File.join(source_dir, "_posts")
    drafts_dir = File.join(source_dir, "_drafts")
    FileUtils.mkdir_p([posts_dir, drafts_dir])

    published_path = File.join(posts_dir, "2026-01-01-published.md")
    future_path = File.join(posts_dir, "2027-01-01-future.md")
    draft_path = File.join(drafts_dir, "draft.md")
    [published_path, future_path, draft_path].each do |path|
      File.write(path, "---\ntitle: Test\n---\nContent\n")
    end

    post_class = Struct.new(:path, :url, :data)
    posts = [
      post_class.new(published_path, "/blog/published/", { "title" => "Published" }),
      post_class.new(future_path, "/blog/future/", { "title" => "Future" }),
      post_class.new(draft_path, "/blog/draft/", { "title" => "Draft" })
    ]
    fake_site_class = Class.new do
      attr_reader :config, :source, :posts, :data

      define_method(:initialize) do |config|
        @config = config
        self.class.instance_variable_set(:@last_config, config)
        @source = config["source"]
        @posts = Struct.new(:docs).new([])
        @data = {}
      end

      define_method(:read) do
        discovered = self.class.posts_for_site
        discovered -= [self.class.draft_post] unless @config["show_drafts"]
        @posts.docs.concat(discovered)
      end
    end
    fake_site_class.define_singleton_method(:last_config) { @last_config }
    fake_site_class.define_singleton_method(:draft_post) { posts.last }
    fake_site_class.define_singleton_method(:posts_for_site) do
      posts
    end

    original_site = Jekyll.const_get(:Site) if Jekyll.const_defined?(:Site, false)
    original_configuration = Jekyll.method(:configuration) if Jekyll.respond_to?(:configuration)
    original_logger = Jekyll.method(:logger) if Jekyll.respond_to?(:logger)
    Jekyll.send(:remove_const, :Site) if original_site
    Jekyll.const_set(:Site, fake_site_class)
    Jekyll.define_singleton_method(:configuration) { |options| options.merge("url" => "https://fpira.com") }
    Jekyll.define_singleton_method(:logger) do
      Class.new { def info(*) = nil }.new
    end

    Jekyll::Substack::Command.process("source" => source_dir, "show_drafts" => true)

    generated = Dir.glob(File.join(source_dir, "_substack", "md", "*.md")).map { |path| File.basename(path) }
    assert_equal ["2026-01-01-published.md", "2027-01-01-future.md"], generated.sort
    generated_json = Dir.glob(File.join(source_dir, "_substack", "json", "*.json")).map { |path| File.basename(path) }
    assert_equal ["2026-01-01-published.json", "2027-01-01-future.json"], generated_json.sort
    assert_equal true, fake_site_class.last_config["future"]
    assert_equal false, fake_site_class.last_config["show_drafts"]
    assert_equal false, fake_site_class.last_config["unpublished"]
  ensure
    FileUtils.remove_entry(source_dir) if source_dir && File.directory?(source_dir)
    Jekyll.send(:remove_const, :Site) if Jekyll.const_defined?(:Site, false)
    Jekyll.const_set(:Site, original_site) if original_site
    Jekyll.define_singleton_method(:configuration, original_configuration) if original_configuration
    Jekyll.define_singleton_method(:logger, original_logger) if original_logger
    Jekyll.singleton_class.send(:remove_method, :configuration) unless original_configuration
    Jekyll.singleton_class.send(:remove_method, :logger) unless original_logger
  end
end
