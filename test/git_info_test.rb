require "fileutils"
require "minitest/autorun"
require "tmpdir"

module Jekyll
  module Hooks
    class << self
      attr_reader :registered_hooks

      def register(scope, event, &block)
        @registered_hooks ||= {}
        @registered_hooks[[scope, event]] = block
      end
    end
  end
end

require_relative "../_plugins/git_info"

class GitInfoTest < Minitest::Test
  Payload = Struct.new(:site)
  Site = Struct.new(:data)
  Author = Struct.new(:name, :email, :date)
  Commit = Struct.new(:author)
  DateValue = Struct.new(:formatted) do
    def strftime(format)
      raise "unexpected date format: #{format}" unless format == "%Y-%m-%dT%H:%M:%S%z"

      formatted
    end
  end

  class FakeGit
    attr_reader :calls

    def initialize(commit)
      @commit = commit
      @calls = []
    end

    def gcommit(ref)
      @calls << [:gcommit, ref]
      @commit
    end

    def revparse(ref)
      @calls << [:revparse, ref]
      "0123456789abcdef"
    end

    def current_branch
      @calls << [:current_branch]
      "main"
    end

    def describe(*args)
      @calls << [:describe, args]
      "v1.2.3"
    end
  end

  def setup
    @tmpdir = Dir.mktmpdir("git-info-")
    @hook = Jekyll::Hooks.registered_hooks.fetch([:site, :pre_render])
    @payload = Payload.new(Site.new({ "existing" => "value" }))
  end

  def teardown
    FileUtils.rm_rf(@tmpdir)
  end

  def test_leaves_data_untouched_when_git_data_file_exists
    write_file("_data/git.json", '{"author_name":"Generated elsewhere"}')

    with_git_open(->(*) { flunk("Git.open should not be called") }) do
      in_repo { @hook.call(Object.new, @payload) }
    end

    assert_equal({ "existing" => "value" }, @payload.site.data)
  end

  def test_populates_site_data_from_repository
    write_file(".git/keep", "")
    commit = Commit.new(Author.new("Test Author", "author@example.com", DateValue.new("2026-07-29T12:34:56+0200")))
    git = FakeGit.new(commit)

    with_git_open(git) do
      in_repo { @hook.call(Object.new, @payload) }
    end

    assert_equal(
      {
        "existing" => "value",
        "git" => {
          "author_name" => "Test Author",
          "author_email" => "author@example.com",
          "commit_hash" => "0123456789abcdef",
          "commit_date" => "2026-07-29T12:34:56+0200",
          "branch" => "main",
          "tags" => "v1.2.3"
        }
      },
      @payload.site.data
    )
    assert_equal(
      [
        [:gcommit, "HEAD"],
        [:revparse, "HEAD"],
        [:current_branch],
        [:describe, ["HEAD", { all: false, tags: true, always: true }]]
      ],
      git.calls
    )
  end

  def test_raises_when_neither_git_data_file_nor_repository_exists
    error = assert_raises(RuntimeError) do
      in_repo { @hook.call(Object.new, @payload) }
    end

    assert_equal "_data/git.json does not exist and dir is not a git working copy.", error.message
    assert_equal({ "existing" => "value" }, @payload.site.data)
  end

  private

  def in_repo(&block)
    Dir.chdir(@tmpdir, &block)
  end

  def write_file(path, contents)
    full_path = File.join(@tmpdir, path)
    FileUtils.mkdir_p(File.dirname(full_path))
    File.write(full_path, contents)
  end

  def with_git_open(value)
    singleton = Git.singleton_class
    original = singleton.instance_method(:open)
    singleton.define_method(:open) { |*args| value.respond_to?(:call) ? value.call(*args) : value }
    yield
  ensure
    singleton.define_method(:open, original)
  end
end
