require "date"
require "fileutils"
require "open3"

class PublishDraft
  class << self
    def call(date:)
      publish_date = validate_date!(date)
      source = latest_top_level_draft
      destination = File.join("_posts", "#{publish_date}-#{File.basename(source)}")

      raise "Destination already exists: #{destination}" if File.exist?(destination)

      FileUtils.mv(source, destination)
      destination
    end

    private

    def validate_date!(date)
      raise ArgumentError, "date is required" if date.nil? || date.strip.empty?
      raise ArgumentError, "date must be in YYYY-MM-DD format" unless date.match?(/^\d{4}-\d{2}-\d{2}$/)

      Date.iso8601(date).strftime("%Y-%m-%d")
    rescue Date::Error
      raise ArgumentError, "date must be a valid calendar date"
    end

    def latest_top_level_draft
      raise "Drafts directory not found: _drafts" unless File.directory?("_drafts")

      candidates = Dir.children("_drafts").sort.filter_map do |entry|
        path = File.join("_drafts", entry)
        next unless eligible_draft?(path, entry)

        [candidate_timestamp(path), path]
      end

      raise "No eligible top-level markdown drafts found in _drafts" if candidates.empty?

      candidates.max_by { |timestamp, path| [timestamp, path] }.last
    end

    def eligible_draft?(path, entry)
      File.file?(path) && !entry.start_with?(".") && entry.end_with?(".md")
    end

    def candidate_timestamp(path)
      latest_commit_timestamp(path) || File.mtime(path).to_i
    end

    def latest_commit_timestamp(path)
      stdout, _stderr, status = Open3.capture3(
        "git",
        "log",
        "-1",
        "--format=%ct",
        "--",
        path
      )

      return nil unless status.success?

      output = stdout.strip
      return nil if output.empty?

      Integer(output, 10)
    end
  end
end

desc "publish the most recent top-level draft (eg: rake publish date=2026-07-12)"
task :publish do
  destination = PublishDraft.call(date: ENV["date"])
  puts "Published draft to #{destination}"
end
