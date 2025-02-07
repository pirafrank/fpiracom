def generate_website()
  require 'jekyll'

  # Set up Jekyll configuration
  config = Jekyll.configuration({
    'source' => '.', # Assumes the task is run from the root of your Jekyll project
    'destination' => '_site',
    'show_drafts' => true,
    'serving' => false
  })

  # Create the site object
  site = Jekyll::Site.new(config)

  # Process the site to gather categories
  site.reset
  site.read
  site
end

def get_categories(site)
  categories = site.categories.keys
  categories.sort
end

def get_tags(site)
  tags = site.tags.keys
  tags.sort
end

def format_list_as_yaml(items)
  formatted = items.sort.map { |i| "\"#{i}\"" }.join(", ")
  "[#{formatted}]"
end
