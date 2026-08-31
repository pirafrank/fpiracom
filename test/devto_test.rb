require "minitest/autorun"
require "tmpdir"
require "fileutils"

module Jekyll
  class Command
    def self.add_build_options(_command); end
  end unless const_defined?(:Command)
end

require_relative "../plugins/jekyll-devto/lib/jekyll/devto"

class DevtoConverterTest < Minitest::Test
  Post = Struct.new(:path, :url, :data)

  def setup
    @post = Post.new(
      "_posts/2026-08-31-example.md",
      "/blog/2026/08/example/",
      {
        "title" => "An example",
        "description" => "A description",
        "tags" => ["Ruby", "Jekyll", "A tag", "Four", "Ignored"],
        "seoimage" => "3020/cover.png"
      }
    )
    @converter = Jekyll::Devto::Converter.new(
      posts: { "2026-08-31-example" => @post.url }
    )
  end

  def test_converts_front_matter_images_math_and_cta
    source = <<~MARKDOWN
      ---
      title: An example
      ---
      {% include image.html
      url="/static/postimages/example.png"
      desc="An example image"
      %}

      Inline $x^2$ and:

      $$
      x^2 + y^2
      $$
    MARKDOWN

    result = @converter.convert(@post, source)

    assert_match(/\A---[\s\S]*?---\n\n\*This post was originally published on \[fpira\.com\]\(https:\/\/fpira\.com\/blog\/2026\/08\/example\/\)\.\*/, result)
    assert_includes result, "published: false"
    assert_includes result, "tags: ruby, jekyll, atag, four"
    assert_includes result, "cover_image: https://fpira.com/static/postimages/3020/cover.png"
    assert_includes result, "![An example image](https://fpira.com/static/postimages/example.png)"
    assert_includes result, "{% katex inline %}x^2{% endkatex %}"
    assert_includes result, "{% katex %}\nx^2 + y^2\n{% endkatex %}"
    assert result.end_with?("{% cta https://fpira.com/blog %} Read more at fpira.com {% endcta %}\n")
  end

  def test_sanitizes_devto_tags_without_mutating_jekyll_tags
    original_tags = ["ci-cd", "CICD", "Ruby_3.3", "こんにちは", "!!!", "one", "two", "three", "four"]
    post = Post.new(@post.path, @post.url, @post.data.merge("tags" => original_tags))

    result = @converter.convert(post, "---\ntitle: An example\n---\nContent\n")

    assert_includes result, "tags: cicd, ruby33, one, two"
    refute_includes result, "こんにちは"
    refute_includes result, "!!!"
    assert_equal ["ci-cd", "CICD", "Ruby_3.3", "こんにちは", "!!!", "one", "two", "three", "four"], original_tags
    assert_equal original_tags, post.data["tags"]
  end

  def test_does_not_convert_dollars_inside_fenced_code
    source = <<~MARKDOWN
      ---
      title: An example
      ---
      ```bash
      echo "$HOME"
      echo '$value'
      ```
    MARKDOWN

    result = @converter.convert(@post, source)

    assert_includes result, 'echo "$HOME"'
    assert_includes result, "echo '$value'"
    refute_includes result, "katex"
  end

  def test_converts_seoimage_using_site_url_and_baseurl
    converter = Jekyll::Devto::Converter.new(site_url: "https://example.com", baseurl: "/blog")
    post = Post.new("_posts/2026-08-31-example.md", "/blog/example/", { "title" => "An example", "seoimage" => "/assets/cover.png" })

    result = converter.convert(post, "---\ntitle: An example\n---\nContent\n")

    assert_includes result, "cover_image: https://example.com/blog/assets/cover.png"
    assert_includes result, "{% cta https://example.com/blog %} Read more at fpira.com {% endcta %}"
  end

  def test_converts_post_urls_and_youtube
    source = <<~MARKDOWN
      ---
      title: An example
      ---
      See {% post_url 2026-08-31-example %} and {% youtube abc123 %}.
    MARKDOWN

    result = @converter.convert(@post, source)

    assert_includes result, "https://fpira.com/blog/2026/08/example/"
    assert_includes result, "{% embed https://www.youtube.com/watch?v=abc123 %}"
  end

  def test_rejects_unresolved_liquid
    source = <<~MARKDOWN
      ---
      title: An example
      ---
      {{ site.data.unknown }}
    MARKDOWN

    error = assert_raises(Jekyll::Devto::ConversionError) { @converter.convert(@post, source) }
    assert_match(/unsupported Liquid/, error.message)
  end

  def test_command_reads_posts_including_future_but_not_drafts
    source_dir = Dir.mktmpdir("devto-test-")
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

    Jekyll::Devto::Command.process("source" => source_dir, "show_drafts" => true)

    generated = Dir.glob(File.join(source_dir, "_devto", "*.md")).map { |path| File.basename(path) }
    assert_equal ["2026-01-01-published.md", "2027-01-01-future.md"], generated.sort
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
