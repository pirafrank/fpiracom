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
