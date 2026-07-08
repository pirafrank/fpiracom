# Print the effective Jekyll/Vercel build mode at the start of every build.
Jekyll::Hooks.register :site, :pre_render do |site|
  jekyll_env = Jekyll.env
  vercel_env = ENV['VERCEL_ENV']
  production_build = jekyll_env == 'production' || vercel_env == 'production'
  future_posts = site.config['future'] == true
  drafts = site.config['show_drafts'] == true

  puts "\n"
  puts "\tBuild diagnostics:"
  puts "\t*** Production build  : #{production_build ? 'yes' : 'no'}"
  puts "\t*** Jekyll environment: #{jekyll_env}"
  puts "\t*** Vercel environment: #{vercel_env || 'not set'}"
  puts "\t*** Future posts      : #{future_posts ? 'enabled' : 'disabled'}"
  puts "\t*** Drafts            : #{drafts ? 'enabled' : 'disabled'}"
  puts "\n"
end
