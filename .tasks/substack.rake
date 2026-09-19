require "base64"
require "json"
require "open3"

module SubstackTasks
  DEFAULT_SUBDOMAIN = "pirafrank"
  USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

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

  def format_cookie(raw_cookie, lli = ENV["SUBSTACK_LLI"])
    cookie = raw_cookie.to_s.strip
    return "" if cookie.empty?

    if cookie.include?("=")
      parts = cookie.split(";").map(&:strip).reject(&:empty?)
      cookies_hash = parts.each_with_object({}) do |part, h|
        k, v = part.split("=", 2)
        h[k] = v if k && v
      end

      sid = cookies_hash["substack.sid"] || cookies_hash["connect.sid"]
      if sid
        cookies_hash["substack.sid"] ||= sid
        cookies_hash["connect.sid"] ||= sid
      end

      cookies_hash["substack.lli"] ||= lli if lli && !lli.empty?

      cookies_hash.map { |k, v| "#{k}=#{v}" }.join("; ")
    else
      sid = cookie
      result = ["substack.sid=#{sid}", "connect.sid=#{sid}"]
      result << "substack.lli=#{lli}" if lli && !lli.empty?
      result.join("; ")
    end
  end

  def current_user_id(cookie, sub = subdomain)
    return ENV["SUBSTACK_USER_ID"].to_i if ENV["SUBSTACK_USER_ID"] && !ENV["SUBSTACK_USER_ID"].empty?

    cookie_str = cookie.to_s
    jwt_match = cookie_str[/substack\.lli=([A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+)/, 1] ||
                cookie_str[/([A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+)/, 1]
    if jwt_match
      begin
        payload_b64 = jwt_match.split(".")[1]
        payload_b64 += "=" * ((4 - payload_b64.length % 4) % 4)
        jwt_data = JSON.parse(Base64.urlsafe_decode64(payload_b64))
        return jwt_data["userId"].to_i if jwt_data["userId"]
      rescue StandardError
        # ignore and fallback to API
      end
    end

    cookie_header = format_cookie(cookie)
    stdout, _stderr, status = Open3.capture3(
      "curl", "--fail", "--silent", "--show-error",
      "-H", "Cookie: #{cookie_header}",
      "-H", "Accept: application/json",
      "-H", "User-Agent: #{USER_AGENT}",
      "https://substack.com/api/v1/user/profile/self"
    )
    if status.success?
      begin
        profile = JSON.parse(stdout)
        return profile["id"].to_i if profile["id"]
      rescue JSON::ParserError
        # ignore
      end
    end

    nil
  end

  def parse_drafts_response(parsed)
    if parsed.is_a?(Array)
      parsed
    elsif parsed.is_a?(Hash)
      parsed["drafts"] || parsed["posts"] || parsed["results"] || parsed["data"] ||
        parsed.values.find { |v| v.is_a?(Array) } || []
    else
      []
    end
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

    unless status.success?
      stdout, stderr, status = Open3.capture3(
        "curl", "--fail", "--silent", "--show-error",
        "-H", "Cookie: #{cookie_header}",
        "-H", "Accept: application/json",
        "-H", "User-Agent: #{USER_AGENT}",
        "#{api_url(sub)}/posts?status=draft"
      )
    end

    unless status.success?
      if stderr.include?("403") || stderr.include?("401") || stderr.include?("Not authorized")
        raise "Substack authentication failed (HTTP 401/403). Please verify that SUBSTACK_COOKIE contains your valid 'substack.sid' and 'substack.lli' cookies."
      end
      raise "Substack duplicate check failed: #{stderr.strip}"
    end

    parsed = JSON.parse(stdout)
    parse_drafts_response(parsed)
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
    abort "SUBSTACK_COOKIE or SUBSTACK_SID is required (e.g. SUBSTACK_COOKIE=\"substack.sid=s%3A...; substack.lli=...\")" if cookie.to_s.empty?

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

    user_id = SubstackTasks.current_user_id(cookie)

    request_data = {
      "draft_title" => payload["draft_title"].to_s,
      "draft_body" => payload["draft_body"].to_s,
      "type" => payload["type"] || "newsletter"
    }
    request_data["draft_subtitle"] = payload["draft_subtitle"].to_s if payload["draft_subtitle"] && !payload["draft_subtitle"].empty?
    request_data["draft_bylines"] = user_id ? [{ "id" => user_id, "is_guest" => false }] : []
    request_payload = JSON.generate(request_data)

    cookie_header = SubstackTasks.format_cookie(cookie)
    stdout, stderr, status = Open3.capture3(
      "curl", "--silent", "--show-error", "-w", "\nHTTP_STATUS:%{http_code}",
      "-X", "POST", "#{SubstackTasks.api_url}/drafts",
      "-H", "Cookie: #{cookie_header}",
      "-H", "Content-Type: application/json",
      "-H", "Accept: application/json",
      "-H", "User-Agent: #{SubstackTasks::USER_AGENT}",
      "-d", request_payload
    )

    http_code = stdout[/HTTP_STATUS:(\d+)/, 1] || (status.success? ? "200" : "500")
    response_body = stdout.sub(/\nHTTP_STATUS:\d+/, "").strip

    unless status.success? && http_code.to_i >= 200 && http_code.to_i < 300
      error_msg = response_body.empty? ? stderr.strip : response_body
      abort "Substack draft creation failed (HTTP #{http_code || 'error'}): #{error_msg}"
    end

    begin
      resp = JSON.parse(response_body)
      draft_id = resp["id"] || resp.dig("draft", "id")
      draft_url = "https://#{SubstackTasks.subdomain}.substack.com/publish/post/#{draft_id}" if draft_id
      puts "Successfully created Substack draft: #{title}#{draft_url ? " -> #{draft_url}" : ""}"
    rescue JSON::ParserError
      puts "Successfully created Substack draft: #{title}"
    end
  end

  desc "Send a generated JSON article to Substack as a draft (alias for substack:send)"
  task :draft, [:filename] => [:send]
end
