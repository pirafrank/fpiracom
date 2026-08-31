require "json"
require "minitest/autorun"
require "open3"
require "rake"

load File.expand_path("../.tasks/devto.rake", __dir__)

class DevtoTasksTest < Minitest::Test
  Status = Struct.new(:success?)

  def test_duplicate_article_requires_an_exact_canonical_url_match
    articles = [
      { "canonical_url" => "https://fpira.com/blog/existing/", "url" => "https://dev.to/example/existing" },
      { "canonical_url" => "https://fpira.com/blog/other/", "url" => "https://dev.to/example/other" }
    ]

    assert_equal articles.first, DevtoTasks.duplicate_article(articles, "https://fpira.com/blog/existing/")
    assert_nil DevtoTasks.duplicate_article(articles, "https://fpira.com/blog/existing")
  end

  def test_all_articles_requests_all_pages
    first_page = Array.new(DevtoTasks::PAGE_SIZE) { |index| { "canonical_url" => "https://fpira.com/blog/#{index}/", "published" => true } }
    second_page = [{ "canonical_url" => "https://fpira.com/blog/last/", "published" => false }]
    responses = [JSON.generate(first_page), JSON.generate(second_page)]
    calls = []
    original_capture3 = Open3.method(:capture3)
    Open3.define_singleton_method(:capture3) do |*command|
      calls << command
      [responses.shift, "", Status.new(true)]
    end

    articles = DevtoTasks.all_articles("secret")

    assert_equal DevtoTasks::PAGE_SIZE + 1, articles.length
    assert_equal 2, calls.length
    assert_includes calls.first, "https://dev.to/api/articles/me/all?page=1&per_page=1000"
    assert_includes calls.last, "https://dev.to/api/articles/me/all?page=2&per_page=1000"
  ensure
    Open3.define_singleton_method(:capture3, original_capture3) if original_capture3
  end

  def test_article_status_reports_published_state
    assert_equal "published", DevtoTasks.article_status("published" => true)
    assert_equal "unpublished", DevtoTasks.article_status("published" => false)
  end

  def test_send_reports_existing_unpublished_article_without_posting
    task = Rake::Task["devto:send"]
    task.reenable
    original_articles = DevtoTasks.method(:all_articles)
    original_system = Kernel.instance_method(:system)
    original_api_key = ENV["DEVTO_API_KEY"]
    post_called = false

    DevtoTasks.define_singleton_method(:all_articles) do |_api_key|
      [{
        "canonical_url" => "https://fpira.com/blog/2015/10/my-2-cents-guide-for-a-safe-upgrade-to-el-capitan/",
        "published" => false,
        "url" => "https://dev.to/example/existing"
      }]
    end
    Kernel.send(:define_method, :system) do |*_command|
      post_called = true
      true
    end
    ENV["DEVTO_API_KEY"] = "secret"

    output, = capture_io do
      task.invoke("2015-10-10-my-2-cents-guide-for-a-safe-upgrade-to-el-capitan.json")
    end

    assert_includes output, "already sent"
    assert_includes output, "status: unpublished"
    refute post_called
  ensure
    DevtoTasks.define_singleton_method(:all_articles, original_articles) if original_articles
    Kernel.send(:define_method, :system, original_system) if original_system
    ENV["DEVTO_API_KEY"] = original_api_key
  end
end
