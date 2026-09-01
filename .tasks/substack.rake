require "json"
require "open3"

module SubstackTasks
  DEFAULT_SUBDOMAIN = "pirafrank"
  USER_AGENT = "fpiracom-substack-rake"

  module_function

  def subdomain
    env_subdomain = ENV["SUBSTACK_SUBDOMAIN"].to_s.strip
    env_subdomain.empty? ? DEFAULT_SUBDOMAIN : env_subdomain
  end

  def api_url(sub = subdomain)
    "https://#{sub}.substack.com/api/v1"
  end

  def json_path(filename)
    json_directory = File.expand_path("_substack/json")
    path = File.expand_path(filename)
    path = File.expand_path(filename, json_directory) unless path.start_with?("#{json_directory}/")
    raise "JSON file must be inside _substack/json: #{filename}" unless path.start_with?("#{json_directory}/")
    raise "JSON file not found: #{path}" unless File.file?(path)

    path
  end

  def format_cookie(raw_cookie)
    cookie = raw_cookie.to_s.strip
    return "" if cookie.empty?
    return cookie if cookie.include?("=")

    "connect.sid=#{cookie}"
  end

  def all_drafts(cookie, sub = subdomain)
    cookie_header = format_cookie(cookie)
    stdout, stderr, status = Open3.capture3(
      "curl", "--fail", "--silent", "--show-error",
      "-H", "Cookie: #{cookie_header}",
      "-H", "Accept: application/json",
      "-H", "User-Agent: #{USER_AGENT}",
      "#{api_url(sub)}/drafts"
    )
    raise "Substack duplicate check failed: #{stderr.strip}" unless status.success?

    drafts = JSON.parse(stdout)
    raise "Substack duplicate check returned an unexpected response" unless drafts.is_a?(Array)

    drafts
  rescue JSON::ParserError => e
    raise "Substack duplicate check returned invalid JSON: #{e.message}"
  end

  def duplicate_draft(drafts, title, canonical_url = nil)
    drafts.find do |draft|
      next unless draft.is_a?(Hash)

      (title && (draft["draft_title"] == title || draft["title"] == title)) ||
        (canonical_url && !canonical_url.empty? && (draft["canonical_url"] == canonical_url || draft["body"]&.include?(canonical_url)))
    end
  end

  def draft_status(draft)
    draft["is_published"] || draft["published"] ? "published" : "draft"
  end
end

namespace :substack do
  desc "Generate Substack-compatible Markdown and JSON files for all posts"
  task :build do
    sh "bundle exec jekyll substack"
  end

  desc "Send a generated JSON article to Substack as a draft (usage: rake substack:send[filename])"
  task :send, [:filename] do |_task, args|
    filename = args[:filename].to_s
    abort "filename is required (usage: rake substack:send[filename])" if filename.empty?

    cookie = ENV["SUBSTACK_COOKIE"] || ENV["SUBSTACK_SID"]
    abort "SUBSTACK_COOKIE or SUBSTACK_SID is required" if cookie.to_s.empty?

    begin
      path = SubstackTasks.json_path(filename)
      payload = JSON.parse(File.read(path))
      abort "JSON payload must contain draft_title" unless payload.is_a?(Hash) && payload["draft_title"]

      title = payload["draft_title"].to_s
      canonical_url = payload["canonical_url"].to_s

      existing_drafts = SubstackTasks.all_drafts(cookie)
      duplicate = SubstackTasks.duplicate_draft(existing_drafts, title, canonical_url)
      if duplicate
        puts "already sent: #{duplicate["draft_title"] || duplicate["title"] || title} (status: #{SubstackTasks.draft_status(duplicate)})"
        next
      end
    rescue JSON::ParserError => e
      abort "JSON file is invalid: #{e.message}"
    rescue StandardError => e
      abort e.message
    end

    request_payload = JSON.generate({
      "draft_title" => payload["draft_title"],
      "draft_subtitle" => payload["draft_subtitle"],
      "draft_body" => payload["draft_body"],
      "type" => payload["type"] || "newsletter"
    })

    cookie_header = SubstackTasks.format_cookie(cookie)
    success = system(
      "curl", "--fail", "-X", "POST", "#{SubstackTasks.api_url}/drafts",
      "-H", "Cookie: #{cookie_header}",
      "-H", "Content-Type: application/json",
      "-H", "Accept: application/json",
      "-H", "User-Agent: #{SubstackTasks::USER_AGENT}",
      "-d", request_payload
    )
    abort "curl failed" unless success
  end
end
