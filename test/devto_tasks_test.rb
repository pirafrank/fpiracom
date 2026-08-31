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

  def test_published_articles_requests_all_pages
    first_page = Array.new(DevtoTasks::PAGE_SIZE) { |index| { "canonical_url" => "https://fpira.com/blog/#{index}/" } }
    second_page = [{ "canonical_url" => "https://fpira.com/blog/last/" }]
    responses = [JSON.generate(first_page), JSON.generate(second_page)]
    calls = []
    original_capture3 = Open3.method(:capture3)
    Open3.define_singleton_method(:capture3) do |*command|
      calls << command
      [responses.shift, "", Status.new(true)]
    end

    articles = DevtoTasks.published_articles("secret")

    assert_equal DevtoTasks::PAGE_SIZE + 1, articles.length
    assert_equal 2, calls.length
    assert_includes calls.first, "https://dev.to/api/articles/me/published?page=1&per_page=1000"
    assert_includes calls.last, "https://dev.to/api/articles/me/published?page=2&per_page=1000"
  ensure
    Open3.define_singleton_method(:capture3, original_capture3) if original_capture3
  end
end
