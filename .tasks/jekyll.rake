desc "remove _site dir and its contents"
task :clean do
  sh "rm -rf _site"
end

desc "live website server with livereload, drafts, and future posts"
task :serve do
  sh "bundle exec jekyll serve --livereload --future --drafts"
end

desc "remove _site dir, then build website"
task :build => :clean do
  args = ARGV
  puts "Args: #{args}"
  if !args.empty? && args[1] == '--all'
    sh "bundle exec jekyll build --future --drafts"
  else
    sh "bundle exec jekyll build"
  end
end

desc "remove _site dir, then build website for production"
task :release => :clean do
  ENV['JEKYLL_ENV'] = 'production'
  sh 'printf "\n *** Building for production (content will be minified!) ***\n\n"'
  sh 'bundle exec jekyll build --trace'
end

desc "Run Algolia reindex"
task :algolia do
  sh 'bundle exec jekyll algolia'
end

desc "Update data about AI-gen related posts"
task :related do
  sh "bundle exec jekyll related"
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

    json_directory = File.expand_path("_devto/json")
    path = File.expand_path(filename)
    path = File.expand_path(filename, json_directory) unless path.start_with?("#{json_directory}/")
    abort "JSON file must be inside _devto/json: #{filename}" unless path.start_with?("#{json_directory}/")
    abort "JSON file not found: #{path}" unless File.file?(path)

    api_key = ENV["DEVTO_API_KEY"].to_s
    abort "DEVTO_API_KEY is required" if api_key.empty?

    success = system(
      "curl", "-X", "POST", "https://dev.to/api/articles",
      "-H", "api-key: #{api_key}",
      "-H", "Content-Type: application/json",
      "--data-binary", "@#{path}"
    )
    abort "curl failed" unless success
  end
end

# Generate git data from current repo info.
# Useful in environments where the git repo is not available
# (eg: Vercel with shallow clones or copied source files).
desc "Generate _data/git.json with required git info"
task :git do
  sh "rm -f _data/git.json"
  sh ".github/actions/git-info/git_info.sh > _data/git.json"
end
