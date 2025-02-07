require 'json'
require "nokogiri"
require 'feedparser'
require 'logutils'

def process_API_file(content)
  JSON.parse(content)
end

def process_JSON_file(content)
  JSON.parse(content)
end

def process_JSONP_file(content)
  json_content = content[content.index('[')..content.rindex(']')]
  JSON.parse(json_content)
end

def process_ICS_file(content)
  content.index('BEGIN:VCALENDAR') or raise "Missing BEGIN:VCALENDAR"
  content.index('END:VCALENDAR') or raise "Missing END:VCALENDAR"
  read_calendar(content)
end

def process_XML_file(content, schema_path = nil)
  # validate XML content against schema if provided
  if schema_path
    File.file?(schema_path) or raise "Schema file not found: #{schema_path}"
    schema = File.read(schema_path)
    xsd = Nokogiri::XML::Schema(schema)
    doc = Nokogiri::XML(content)
    validation_errors = xsd.validate(doc)
    validation_errors.each do |error|
      puts error.message
    end
    raise "Invalid XML content" if validation_errors.any?
  else
    doc = Nokogiri::XML(content)
    doc.errors.each do |error|
      puts error
    end
    raise "Invalid XML content" if doc.errors.any?
  end
end

def process_feed_file(content)
  # override log level to avoid debug messages to stdout from FeedParser
  LogUtils::Logger.root.level = :info
  # validate feed content by trying to parse it,
  # would raise an exception if content is invalid
  FeedParser::Parser.parse(content)
end

namespace :check do
  desc "run jekyll doctor"
  task :install do
    sh "bundle exec jekyll doctor"
  end

  desc "check href attributes in generated website for broken links (all)"
  task :urls => :build do
    check_urls('_site/', false)
  end

  desc "check href attributes in generated website for broken links (internal links only)"
  task :internal_urls => :build do
    check_urls('_site/', true)
  end

  desc "check static JSON files providing APIs to be valid"
  task :api => :build do
    api_path = "_site/api"
    regex = /index\.json$/
    api_files = get_files("API", api_path, regex)
    onError = process_files(api_files, :process_API_file)
    exit 1 if onError > 0
  end

  desc "check static JSONP files providing website metadata to be valid"
  task :jsonp => :build do
    jsonp_path = "_site/jsonp"
    regex = /\.jsonp$/
    jsonp_files = get_files("JSONP", jsonp_path, regex)
    onError = process_files(jsonp_files, :process_JSONP_file)
    exit 1 if onError > 0
  end

  desc "check static ICS files providing calendars to be valid"
  task :calendars => :build do
    ics_path = "_site/calendars"
    regex = /\.ics$/
    ics_files = get_files("ICS", ics_path, regex)
    onError = process_files(ics_files, :process_ICS_file)
    exit 1 if onError > 0
  end

  desc "check static website feed files to be valid"
  task :feeds => :build do
    feed_path = "_site/"
    regex = /(feed|atom)\.(xml|json)$/
    feed_files = get_files("Website feed", feed_path, regex)
    onError = process_files(feed_files, :process_feed_file)
    exit 1 if onError > 0
  end
end
