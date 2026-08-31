# frozen_string_literal: true

require "fileutils"
require "date"
require "json"
require "tmpdir"
require "yaml"

module Jekyll
  module Devto
    OUTPUT_DIR = "_devto"
    MARKDOWN_OUTPUT_DIR = File.join(OUTPUT_DIR, "md")
    JSON_OUTPUT_DIR = File.join(OUTPUT_DIR, "json")
    SITE_URL = "https://fpira.com"

    class ConversionError < StandardError; end

    class Converter
      JEKYLL_TAG = /\{%\s*(?<name>[a-z_]+)(?<args>.*?)%\}/m
      LIQUID_OUTPUT = /\{\{.*?\}\}/m
      DEVTO_TAGS = %w[cta embed endkatex gist katex raw endraw].freeze

      def initialize(site_url: SITE_URL, baseurl: "", posts: {}, liquid_data: {})
        @site_url = site_url.sub(%r{/$}, "")
        @baseurl = baseurl.to_s
        @posts = posts
        @liquid_data = liquid_data
      end

      def convert(post, source)
        data, converted = converted_post(post, source)

        "#{devto_front_matter(data, post)}\n\n#{devto_body(post, converted)}\n"
      end

      def convert_json(post, source)
        data, converted = converted_post(post, source)
        JSON.pretty_generate("article" => article_payload(data, post, converted)) + "\n"
      end

      private

      def split_front_matter(source)
        return [{}, source] unless source.start_with?("---")

        match = source.match(/\A---\s*\n(.*?)\n---\s*\n/m)
        return [{}, source] unless match

        [YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true) || {}, source[match.end(0)..]]
      end

      def converted_post(post, source)
        front_matter, body = split_front_matter(source)
        data = post.respond_to?(:data) ? post.data : front_matter
        converted = convert_body(body, data)
        unprotected = converted
          .gsub(/```[^\n]*\n[\s\S]*?^```\s*$/m, "")
          .gsub(/\{%\s*raw\s*%\}[\s\S]*?\{%\s*endraw\s*%\}/m, "")
        unresolved = unprotected.scan(JEKYLL_TAG).map { |match| match.first }.reject { |name| DEVTO_TAGS.include?(name) }.uniq
        unresolved += unprotected.scan(LIQUID_OUTPUT).uniq
        unless unresolved.empty?
          raise ConversionError, "#{post_path(post)} contains unsupported Liquid: #{unresolved.join(', ')}"
        end

        [data, converted]
      end

      def devto_front_matter(data, post)
        lines = ["---"]
        lines << "title: #{data.fetch('title').to_s.inspect}"
        lines << "published: false"
        lines << "description: #{data['description'].to_s.inspect}" if data["description"]

        tags = normalized_tags(data)
        lines << "tags: #{tags.join(', ')}" unless tags.empty?

        lines << "series: #{data['series'].to_s.inspect}" if data["series"]
        lines << "cover_image: #{absolute_image_url(data['seoimage'])}" if data["seoimage"]
        lines << "canonical_url: #{@site_url}#{post_url(post)}"
        lines << "---"
        lines.join("\n")
      end

      def normalized_tags(data)
        Array(data["tags"] || data["tag"]).flatten
          .map { |tag| tag.to_s.downcase.gsub(/[^a-z0-9]/, "") }
          .reject(&:empty?).uniq.first(4)
      end

      def article_payload(data, post, converted)
        payload = {
          "title" => data.fetch("title").to_s,
          "body_markdown" => devto_body(post, converted),
          "published" => false,
          "tags" => normalized_tags(data),
          "canonical_url" => "#{@site_url}#{post_url(post)}"
        }
        payload["description"] = data["description"].to_s if data["description"]
        payload["series"] = data["series"].to_s if data["series"]
        payload["main_image"] = absolute_image_url(data["seoimage"]) if data["seoimage"]
        payload
      end

      def devto_body(post, converted)
        "#{original_source_note(post)}\n\n#{converted.rstrip}\n\n#{cta}"
      end

      def convert_body(body, data)
        body = replace_images(body)
        body = replace_post_urls(body)
        body = replace_youtube(body)
        body = body.gsub(/\{\{\s*page\.postimages\s*\}\}/, data["postimages"].to_s)
        body = replace_site_data(body)
        body = body.gsub(/\{\{\s*site\.baseurl\s*\}\}/, "")
        convert_math(body)
      end

      def replace_site_data(body)
        body.gsub(/\{\{\s*site\.data\.([^}]+?)\s*\}\}/) do
          original = Regexp.last_match[0]
          value = @liquid_data
          Regexp.last_match(1).split(".").each do |key|
            value = value.is_a?(Hash) ? value[key] || value[key.to_sym] : nil
          end

          value.nil? ? original : value.to_s
        end
      end

      def replace_images(body)
        body.gsub(/\{%\s*include\s+image\.html(?<args>.*?)%\}/m) do
          args = Regexp.last_match[:args]
          values = {}
          args.scan(/(url|alt|desc|credits|link)=("(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|[^\s]+)/m) do |key, value|
            values[key] = value[1...-1] if value.start_with?("\"") || value.start_with?("'")
            values[key] ||= value
          end
          raise ConversionError, "image include is missing url" unless values["url"]

          alt = values["alt"] || values["desc"] || ""
          "![#{alt.gsub(/[\[\]]/, '')}](#{absolute_image_url(values['url'])})"
        end
      end

      def replace_post_urls(body)
        body.gsub(/\{%\s*post_url\s+([^\s%]+)\s*%\}/) do
          slug = Regexp.last_match(1)
          "#{@site_url}#{@posts.fetch(slug) { "/blog/#{slug}/" }}"
        end
      rescue KeyError => e
        raise ConversionError, "unknown post_url target #{e.key}"
      end

      def replace_youtube(body)
        body.gsub(/\{%\s*youtube\s+([^\s%]+)\s*%\}/) do
          "{% embed https://www.youtube.com/watch?v=#{Regexp.last_match(1)} %}"
        end
      end

      def convert_math(body)
        chunks = body.split(/(```[^\n]*\n[\s\S]*?^```\s*$|^(?:    |\t).*(?:\n|$))/, -1)
        chunks.each_with_index.map { |chunk, index| index.odd? ? chunk : convert_math_text(chunk) }.join
      end

      def convert_math_text(text)
        text = text.gsub(/(?<!\\)\$\$([\s\S]*?)(?<!\\)\$\$/) do
          "{% katex %}#{Regexp.last_match(1)}{% endkatex %}"
        end
        text.gsub(/(?<![\\$])\$([^$\n]+?)(?<!\\)\$(?!\$)/) do
          "{% katex inline %}#{Regexp.last_match(1)}{% endkatex %}"
        end
      end

      def absolute_image_url(path)
        value = path.to_s
        return value if value.start_with?("http")

        if value.start_with?("/")
          "#{@site_url}#{@baseurl}#{value}"
        else
          "#{@site_url}#{@baseurl}/static/postimages/#{value}"
        end
      end

      def post_url(post)
        post.respond_to?(:url) ? post.url : "/blog/#{post_slug(post)}/"
      end

      def original_source_note(post)
        "*This post was originally published on [fpira.com](#{@site_url}#{post_url(post)}).*"
      end

      def post_slug(post)
        File.basename(post_path(post), ".md").sub(/^\d{4}-\d{1,2}-\d{1,2}-/, "")
      end

      def post_path(post)
        post.respond_to?(:path) ? post.path : post.to_s
      end

      def cta
        "{% cta #{@site_url}/blog %} Read more at fpira.com {% endcta %}"
      end
    end

    class Command < Jekyll::Command
      class << self
        def init_with_program(prog)
          prog.command(:devto) do |command|
            command.syntax "devto [options]"
            command.description "Generate Dev.to-compatible Markdown for every post"
            Jekyll::Command.add_build_options(command)
            command.action do |_, options|
              process_with_graceful_fail(command, options, self)
            end
          end
        end

        def process(options)
          config = Jekyll.configuration(options.merge(
            "future" => true,
            "show_drafts" => false,
            "unpublished" => false
          ))
          site = Jekyll::Site.new(config)
          site.read
          posts = site.posts.docs
          post_urls = posts.each_with_object({}) do |post, result|
            result[File.basename(post.path, ".md")] = post.url
          end
          converter = Converter.new(
            site_url: site.config["url"] || SITE_URL,
            baseurl: site.config["baseurl"],
            posts: post_urls,
            liquid_data: site.data
          )
          output = Dir.mktmpdir("devto-")
          FileUtils.mkdir_p([File.join(output, "md"), File.join(output, "json")])

          posts.each do |post|
            source = File.read(post.path)
            basename = File.basename(post.path, ".md")
            File.write(File.join(output, "md", "#{basename}.md"), converter.convert(post, source))
            File.write(File.join(output, "json", "#{basename}.json"), converter.convert_json(post, source))
          end

          replace_output(output, site.source)
        ensure
          FileUtils.remove_entry(output) if output && File.directory?(output)
        end

        private

        def replace_output(output, source)
          legacy_destination = File.join(source, OUTPUT_DIR)
          markdown_destination = File.join(source, MARKDOWN_OUTPUT_DIR)
          json_destination = File.join(source, JSON_OUTPUT_DIR)
          FileUtils.mkdir_p([markdown_destination, json_destination])
          Dir.glob(File.join(legacy_destination, "*.md")).each { |file| File.delete(file) }
          Dir.glob(File.join(markdown_destination, "*.md")).each { |file| File.delete(file) }
          Dir.glob(File.join(json_destination, "*.json")).each { |file| File.delete(file) }
          Dir.glob(File.join(output, "md", "*.md")).each { |file| FileUtils.cp(file, markdown_destination) }
          Dir.glob(File.join(output, "json", "*.json")).each { |file| FileUtils.cp(file, json_destination) }
          count = Dir.glob(File.join(output, "md", "*.md")).length
          Jekyll.logger.info "Dev.to:", "generated #{count} posts in #{MARKDOWN_OUTPUT_DIR}/ and #{JSON_OUTPUT_DIR}/"
        end
      end
    end
  end
end
