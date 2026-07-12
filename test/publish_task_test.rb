require "fileutils"
require "minitest/autorun"
require "open3"
require "rake"
require "time"
require "tmpdir"

PUBLISH_TASK_PATH = File.expand_path("../.tasks/publish.rake", __dir__)

load PUBLISH_TASK_PATH if File.exist?(PUBLISH_TASK_PATH)

class PublishTaskTest < Minitest::Test
  def setup
    @tmpdir = Dir.mktmpdir("publish-draft-")
    git!("init", "-q")
    FileUtils.mkdir_p(File.join(@tmpdir, "_drafts"))
    FileUtils.mkdir_p(File.join(@tmpdir, "_posts"))
  end

  def teardown
    FileUtils.rm_rf(@tmpdir)
  end

  def test_publishes_most_recent_visible_top_level_markdown_by_commit_date
    commit_file("_drafts/older.md", "older draft\n", at: "2024-01-01T00:00:00Z")
    commit_file("_drafts/newer.md", "newer draft\n", at: "2024-02-01T00:00:00Z")
    commit_file("_drafts/nested/ignored.md", "ignored draft\n", at: "2024-03-01T00:00:00Z")
    commit_file("_drafts/.hidden.md", "hidden draft\n", at: "2024-04-01T00:00:00Z")
    commit_file("_drafts/note.txt", "plain text draft\n", at: "2024-05-01T00:00:00Z")

    in_repo do
      PublishDraft.call(date: "2026-07-12")
    end

    in_repo do
      refute File.exist?("_drafts/newer.md")
      assert_equal "newer draft\n", File.read("_posts/2026-07-12-newer.md")
      assert File.exist?("_drafts/older.md")
      assert File.exist?("_drafts/nested/ignored.md")
      assert File.exist?("_drafts/.hidden.md")
      assert File.exist?("_drafts/note.txt")
    end
  end

  def test_publishes_most_recent_visible_top_level_markdown_by_mtime_when_uncommitted
    write_file("_drafts/older.md", "older draft\n")
    write_file("_drafts/newer.md", "newer draft\n")
    write_file("_drafts/.hidden.md", "hidden draft\n")
    write_file("_drafts/note.txt", "plain text draft\n")
    write_file("_drafts/nested/ignored.md", "ignored draft\n")

    set_mtime("_drafts/older.md", "2024-01-01T00:00:00Z")
    set_mtime("_drafts/newer.md", "2024-02-01T00:00:00Z")
    set_mtime("_drafts/.hidden.md", "2024-03-01T00:00:00Z")
    set_mtime("_drafts/note.txt", "2024-04-01T00:00:00Z")
    set_mtime("_drafts/nested/ignored.md", "2024-05-01T00:00:00Z")

    in_repo do
      PublishDraft.call(date: "2026-07-12")
    end

    in_repo do
      refute File.exist?("_drafts/newer.md")
      assert_equal "newer draft\n", File.read("_posts/2026-07-12-newer.md")
      assert File.exist?("_drafts/older.md")
      assert File.exist?("_drafts/.hidden.md")
      assert File.exist?("_drafts/note.txt")
      assert File.exist?("_drafts/nested/ignored.md")
    end
  end

  def test_publishes_most_recent_visible_top_level_markdown_across_commit_and_mtime
    commit_file("_drafts/committed.md", "committed draft\n", at: "2024-01-01T00:00:00Z")
    write_file("_drafts/untracked.md", "untracked draft\n")
    set_mtime("_drafts/untracked.md", "2024-02-01T00:00:00Z")

    in_repo do
      PublishDraft.call(date: "2026-07-12")
    end

    in_repo do
      refute File.exist?("_drafts/untracked.md")
      assert_equal "untracked draft\n", File.read("_posts/2026-07-12-untracked.md")
      assert File.exist?("_drafts/committed.md")
    end
  end

  def test_rejects_missing_or_invalid_dates_without_moving_files
    commit_file("_drafts/example.md", "draft\n", at: "2024-01-01T00:00:00Z")

    [
      [nil, /date is required/],
      ["2026\/07\/12", /date must be in YYYY-MM-DD format/],
      ["2026-02-30", /date must be a valid calendar date/]
    ].each do |date, message|
      error = assert_raises(ArgumentError) do
        in_repo do
          PublishDraft.call(date: date)
        end
      end

      assert_match message, error.message

      in_repo do
        assert File.exist?("_drafts/example.md")
        assert_empty Dir.children("_posts")
      end
    end
  end

  def test_raises_when_no_visible_top_level_markdown_drafts_exist
    write_file("_drafts/.hidden.md", "draft\n")
    write_file("_drafts/note.txt", "draft\n")
    commit_file("_drafts/nested/ignored.md", "ignored draft\n", at: "2024-03-01T00:00:00Z")

    error = assert_raises(RuntimeError) do
      in_repo do
        PublishDraft.call(date: "2026-07-12")
      end
    end

    assert_match(/No eligible top-level markdown drafts found/, error.message)

    in_repo do
      assert File.exist?("_drafts/.hidden.md")
      assert File.exist?("_drafts/note.txt")
      assert File.exist?("_drafts/nested/ignored.md")
      assert_empty Dir.children("_posts")
    end
  end

  def test_raises_when_destination_post_already_exists
    commit_file("_drafts/example.md", "draft\n", at: "2024-01-01T00:00:00Z")
    write_file("_posts/2026-07-12-example.md", "existing\n")

    error = assert_raises(RuntimeError) do
      in_repo do
        PublishDraft.call(date: "2026-07-12")
      end
    end

    assert_match(/Destination already exists/, error.message)

    in_repo do
      assert_equal "draft\n", File.read("_drafts/example.md")
      assert_equal "existing\n", File.read("_posts/2026-07-12-example.md")
    end
  end

  private

  def in_repo(&block)
    Dir.chdir(@tmpdir, &block)
  end

  def commit_file(path, contents, at:)
    write_file(path, contents)
    git!("add", path)
    git!("commit", "-q", "-m", "Update #{path}", env: git_env(at))
  end

  def write_file(path, contents)
    full_path = File.join(@tmpdir, path)
    FileUtils.mkdir_p(File.dirname(full_path))
    File.write(full_path, contents)
  end

  def set_mtime(path, timestamp)
    time = Time.iso8601(timestamp)
    full_path = File.join(@tmpdir, path)
    File.utime(time, time, full_path)
  end

  def git!(*args, env: {})
    stdout, stderr, status = Open3.capture3(
      default_git_env.merge(env),
      "git",
      *args,
      chdir: @tmpdir
    )

    return stdout if status.success?

    flunk("git #{args.join(' ')} failed: #{stderr.strip.empty? ? stdout.strip : stderr.strip}")
  end

  def git_env(timestamp)
    {
      "GIT_AUTHOR_DATE" => timestamp,
      "GIT_COMMITTER_DATE" => timestamp
    }
  end

  def default_git_env
    {
      "GIT_AUTHOR_NAME" => "Test Author",
      "GIT_AUTHOR_EMAIL" => "author@example.com",
      "GIT_COMMITTER_NAME" => "Test Committer",
      "GIT_COMMITTER_EMAIL" => "committer@example.com"
    }
  end
end
