require "json"
require "open3"

module DevtoTasks
  API_URL = "https://dev.to/api/articles"
  USER_AGENT = "fpiracom-devto-rake"
  PAGE_SIZE = 1_000

  module_function

  def json_path(filename)
    json_directory = File.expand_path("_devto/json")
    path = File.expand_path(filename)
    path = File.expand_path(filename, json_directory) unless path.start_with?("#{json_directory}/")
    raise "JSON file must be inside _devto/json: #{filename}" unless path.start_with?("#{json_directory}/")
    raise "JSON file not found: #{path}" unless File.file?(path)

    path
  end

  def published_articles(api_key)
    articles = []
    page = 1

    loop do
      stdout, stderr, status = Open3.capture3(
        "curl", "--fail", "--silent", "--show-error",
        "-H", "api-key: #{api_key}",
        "-H", "Accept: application/vnd.forem.api-v1+json",
        "-H", "User-Agent: #{USER_AGENT}",
        "#{API_URL}/me/published?page=#{page}&per_page=#{PAGE_SIZE}"
      )
      raise "DEV.to duplicate check failed: #{stderr.strip}" unless status.success?

      page_articles = JSON.parse(stdout)
      raise "DEV.to duplicate check returned an unexpected response" unless page_articles.is_a?(Array)

      articles.concat(page_articles)
      break if page_articles.length < PAGE_SIZE

      page += 1
    end

    articles
  rescue JSON::ParserError => e
    raise "DEV.to duplicate check returned invalid JSON: #{e.message}"
  end

  def duplicate_article(articles, canonical_url)
    articles.find { |article| article.is_a?(Hash) && article["canonical_url"] == canonical_url }
  end
end

namespace :devto do
  desc "Generate dev.to-compatible Markdown and JSON files for all posts"
  task :build do
    sh "bundle exec jekyll devto"
  end

  desc "Send a generated JSON article to DEV.to (usage: rake devto:send[filename])"
  task :send, [:filename] do |_task, args|
    filename = args[:filename].to_s
    abort "filename is required (usage: rake devto:send[filename])" if filename.empty?

    api_key = ENV["DEVTO_API_KEY"].to_s
    abort "DEVTO_API_KEY is required" if api_key.empty?

    begin
      path = DevtoTasks.json_path(filename)
      payload = JSON.parse(File.read(path))
      abort "JSON payload must contain an article object" unless payload.is_a?(Hash) && payload["article"].is_a?(Hash)

      canonical_url = payload.dig("article", "canonical_url").to_s
      abort "JSON payload must contain article.canonical_url" if canonical_url.empty?

      duplicate = DevtoTasks.duplicate_article(DevtoTasks.published_articles(api_key), canonical_url)
      if duplicate
        abort "article already published on DEV.to: #{duplicate["url"] || duplicate["title"] || canonical_url}"
      end
    rescue JSON::ParserError => e
      abort "JSON file is invalid: #{e.message}"
    rescue StandardError => e
      abort e.message
    end

    success = system(
      "curl", "--fail", "-X", "POST", DevtoTasks::API_URL,
      "-H", "api-key: #{api_key}",
      "-H", "Content-Type: application/json",
      "-H", "Accept: application/vnd.forem.api-v1+json",
      "-H", "User-Agent: #{DevtoTasks::USER_AGENT}",
      "--data-binary", "@#{path}"
    )
    abort "curl failed" unless success
  end
end
