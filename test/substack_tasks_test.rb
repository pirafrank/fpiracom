require "json"
require "minitest/autorun"
require "open3"
require "rake"

load File.expand_path("../.tasks/substack.rake", __dir__)

class SubstackTasksTest < Minitest::Test
  Status = Struct.new(:success?)

  def test_format_cookie
    assert_equal "", SubstackTasks.format_cookie("")
    assert_equal "connect.sid=xyz123", SubstackTasks.format_cookie("xyz123")
    assert_equal "connect.sid=xyz123; substack.sid=abc456", SubstackTasks.format_cookie("connect.sid=xyz123; substack.sid=abc456")
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

  def test_all_drafts_requests_subdomain_endpoint
    mock_drafts = [{ "draft_title" => "Sample", "id" => "123" }]
    calls = []
    original_capture3 = Open3.method(:capture3)
    Open3.define_singleton_method(:capture3) do |*command|
      calls << command
      [JSON.generate(mock_drafts), "", Status.new(true)]
    end

    drafts = SubstackTasks.all_drafts("mycookie", "customsub")

    assert_equal 1, drafts.length
    assert_equal "Sample", drafts.first["draft_title"]
    assert_includes calls.first, "https://customsub.substack.com/api/v1/drafts"
    assert_includes calls.first, "Cookie: connect.sid=mycookie"
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
    original_system = Kernel.instance_method(:system)
    original_cookie = ENV["SUBSTACK_COOKIE"]
    post_called = false

    SubstackTasks.define_singleton_method(:all_drafts) do |_cookie, _sub = nil|
      [{
        "draft_title" => "My 2 cents guide for a safe upgrade to El Capitan",
        "canonical_url" => "https://fpira.com/blog/2015/10/my-2-cents-guide-for-a-safe-upgrade-to-el-capitan/",
        "published" => false
      }]
    end
    Kernel.send(:define_method, :system) do |*_command|
      post_called = true
      true
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
    Kernel.send(:define_method, :system, original_system) if original_system
    ENV["SUBSTACK_COOKIE"] = original_cookie
  end

  def test_send_posts_new_draft_when_not_duplicate
    task = Rake::Task["substack:send"]
    task.reenable
    original_drafts = SubstackTasks.method(:all_drafts)
    original_system = Kernel.instance_method(:system)
    original_cookie = ENV["SUBSTACK_COOKIE"]
    system_calls = []

    SubstackTasks.define_singleton_method(:all_drafts) do |_cookie, _sub = nil|
      []
    end
    Kernel.send(:define_method, :system) do |*command|
      system_calls << command
      true
    end
    ENV["SUBSTACK_COOKIE"] = "secret"

    task.invoke("2015-10-10-my-2-cents-guide-for-a-safe-upgrade-to-el-capitan.json")

    assert_equal 1, system_calls.length
    assert_includes system_calls.first, "https://pirafrank.substack.com/api/v1/drafts"
    assert_includes system_calls.first, "Cookie: connect.sid=secret"
  ensure
    SubstackTasks.define_singleton_method(:all_drafts, original_drafts) if original_drafts
    Kernel.send(:define_method, :system, original_system) if original_system
    ENV["SUBSTACK_COOKIE"] = original_cookie
  end
end
