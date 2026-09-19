require "json"
require "minitest/autorun"
require "open3"
require "rake"

load File.expand_path("../.tasks/substack.rake", __dir__)

class SubstackTasksTest < Minitest::Test
  Status = Struct.new(:success?)

  def test_format_cookie
    assert_equal "", SubstackTasks.format_cookie("")
    assert_includes SubstackTasks.format_cookie("xyz123"), "substack.sid=xyz123"
    assert_includes SubstackTasks.format_cookie("xyz123"), "connect.sid=xyz123"

    formatted = SubstackTasks.format_cookie("connect.sid=xyz123", "jwt456")
    assert_includes formatted, "substack.sid=xyz123"
    assert_includes formatted, "connect.sid=xyz123"
    assert_includes formatted, "substack.lli=jwt456"

    full_cookie = "substack.sid=sid1; substack.lli=jwt2"
    assert_includes SubstackTasks.format_cookie(full_cookie), "substack.sid=sid1"
    assert_includes SubstackTasks.format_cookie(full_cookie), "substack.lli=jwt2"
  end

  def test_current_user_id_extracts_from_jwt
    jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE4MTA4MzA2LCJpYXQiOjE3ODgyNjE5NjcsImV4cCI6MTc5MDg1Mzk2NywiYXVkIjoibGlrZWx5LWxvZ2dlZC1pbiJ9.vSFZ0Wl98JxFRAV2YdgD-Ai42J-3St-FsI2Hpcpvdwk"
    assert_equal 18108306, SubstackTasks.current_user_id("substack.lli=#{jwt}")
  end

  def test_parse_drafts_response
    assert_equal [{ "id" => 1 }], SubstackTasks.parse_drafts_response([{ "id" => 1 }])
    assert_equal [{ "id" => 2 }], SubstackTasks.parse_drafts_response({ "drafts" => [{ "id" => 2 }] })
    assert_equal [{ "id" => 3 }], SubstackTasks.parse_drafts_response({ "posts" => [{ "id" => 3 }] })
    assert_equal [], SubstackTasks.parse_drafts_response({})
    assert_equal [], SubstackTasks.parse_drafts_response(nil)
  end

  def test_duplicate_draft_matches_title_or_canonical_url
    drafts = [
      { "draft_title" => "Existing Post", "canonical_url" => "https://fpira.com/blog/existing/", "published" => true },
      { "title" => "Other Draft", "canonical_url" => "https://fpira.com/blog/other/", "published" => false }
    ]

    assert_equal drafts.first, SubstackTasks.duplicate_draft(drafts, "Existing Post", nil)
    assert_equal drafts.first, SubstackTasks.duplicate_draft(drafts, "Non existent", "https://fpira.com/blog/existing/")
    assert_equal drafts.last, SubstackTasks.duplicate_draft(drafts, "Other Draft", nil)
    assert_nil SubstackTasks.duplicate_draft(drafts, "Brand New Post", "https://fpira.com/blog/brand-new/")
  end

  def test_all_drafts_requests_subdomain_endpoint_and_handles_hashes
    mock_response = { "drafts" => [{ "draft_title" => "Sample", "id" => "123" }] }
    calls = []
    original_capture3 = Open3.method(:capture3)
    Open3.define_singleton_method(:capture3) do |*command|
      calls << command
      [JSON.generate(mock_response), "", Status.new(true)]
    end

    drafts = SubstackTasks.all_drafts("mycookie", "customsub")

    assert_equal 1, drafts.length
    assert_equal "Sample", drafts.first["draft_title"]
    assert_includes calls.first, "https://customsub.substack.com/api/v1/drafts"
    assert_includes calls.first, "Cookie: substack.sid=mycookie; connect.sid=mycookie"
  ensure
    Open3.define_singleton_method(:capture3, original_capture3) if original_capture3
  end

  def test_draft_status_reports_published_state
    assert_equal "published", SubstackTasks.draft_status("is_published" => true)
    assert_equal "published", SubstackTasks.draft_status("published" => true)
    assert_equal "draft", SubstackTasks.draft_status("published" => false)
  end

  def test_send_reports_existing_draft_without_posting
    task = Rake::Task["substack:send"]
    task.reenable
    original_drafts = SubstackTasks.method(:all_drafts)
    original_capture3 = Open3.method(:capture3)
    original_cookie = ENV["SUBSTACK_COOKIE"]
    post_called = false

    SubstackTasks.define_singleton_method(:all_drafts) do |_cookie, _sub = nil|
      [{
        "draft_title" => "My 2 cents guide for a safe upgrade to El Capitan",
        "canonical_url" => "https://fpira.com/blog/2015/10/my-2-cents-guide-for-a-safe-upgrade-to-el-capitan/",
        "published" => false
      }]
    end
    Open3.define_singleton_method(:capture3) do |*command|
      post_called = true if command.include?("POST")
      ["{}", "", Status.new(true)]
    end
    ENV["SUBSTACK_COOKIE"] = "secret"

    output, = capture_io do
      task.invoke("2015-10-10-my-2-cents-guide-for-a-safe-upgrade-to-el-capitan.json")
    end

    assert_includes output, "already sent"
    assert_includes output, "status: draft"
    refute post_called
  ensure
    SubstackTasks.define_singleton_method(:all_drafts, original_drafts) if original_drafts
    Open3.define_singleton_method(:capture3, original_capture3) if original_capture3
    ENV["SUBSTACK_COOKIE"] = original_cookie
  end

  def test_send_posts_new_draft_when_not_duplicate
    task = Rake::Task["substack:send"]
    task.reenable
    original_drafts = SubstackTasks.method(:all_drafts)
    original_capture3 = Open3.method(:capture3)
    original_cookie = ENV["SUBSTACK_COOKIE"]
    post_calls = []

    SubstackTasks.define_singleton_method(:all_drafts) do |_cookie, _sub = nil|
      []
    end
    Open3.define_singleton_method(:capture3) do |*command|
      post_calls << command if command.include?("POST")
      [JSON.generate({ "id" => 456 }), "", Status.new(true)]
    end
    ENV["SUBSTACK_COOKIE"] = "secret"

    output, = capture_io do
      task.invoke("2015-10-10-my-2-cents-guide-for-a-safe-upgrade-to-el-capitan.json")
    end

    assert_equal 1, post_calls.length
    assert_includes post_calls.first, "https://pirafrank.substack.com/api/v1/drafts"
    assert_includes output, "Successfully created Substack draft"
    assert_includes output, "https://pirafrank.substack.com/publish/post/456"
  ensure
    SubstackTasks.define_singleton_method(:all_drafts, original_drafts) if original_drafts
    Open3.define_singleton_method(:capture3, original_capture3) if original_capture3
    ENV["SUBSTACK_COOKIE"] = original_cookie
  end
end
