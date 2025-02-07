desc "list tags, categories, etc (Eg `rake list tags` or `rake list tags --format=json`)"
task :list do
  what = ENV['what'] || ENV['w']
  if what.nil?
    puts "Please specify what to list: tags, categories, etc"
    puts "Usage: rake list what=tags"
    return
  end
  format = ENV['format'] || ENV['f'] || "csv"
  sh "bundle exec jekyll list #{what} --output #{format}"
end
