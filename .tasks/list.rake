desc "list tags, categories, etc (E.g. rake list what=tags)"
task :list do
  what = ENV['what'] || ENV['w']
  if what.nil?
    puts "\nPlease specify what to list: tags, categories, etc."
    puts "Usage: rake list what=tags"
    puts "Usage: rake list what=categories format=json"
    puts "Check github.com/pirafrank/jekyll-listme for a full list of what is possible to list and in which format.\n\n"
    return
  end
  format = ENV['format'] || ENV['f'] || "csv"
  sh "bundle exec jekyll list #{what} --output #{format}"
end
