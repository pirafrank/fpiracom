require 'fileutils'
require 'json'
require 'jekyll/utils'
require_relative 'lib-shared'

module Jekyll
  module JekyllApi
    extend self

    # edit to set the api subdirectory in the repo root
    def api_subdir
      "api"
    end

    # edit to set the API version (this is a child dir in the api subdir)
    def api_version
      "v1"
    end

    def create_post_object(post, site)
      post_data = {
        "type" => "post",
        "id" => post.data['uid'],
        "postUrl" => site.config['url'] + site.config['baseurl'] + post.url,
        "title" => post.data['title'],
        "subtitle" => post.data['subtitle'] || "",
        "published" => post.date.iso8601,
        "lastUpdate" => post.data['most_recent_edit'].iso8601,
        "categories" => post.data['categories'],
        "tags" => post.data['tags'],
        "seoImageUrl" => post.data['seo_image_url'],
      }
      if post.data["description"]
        # Get the description and truncate it to 20 words
        description = truncate_words(post.data['description'], 20)
        # Escape any HTML in the truncated description
        description = CGI.escapeHTML(description)
        post_data["description"] = description
      else
        post_data["description"] = ""
      end
      updates = []
      post.data['updates'].each do |update|
        if !update["date"].nil?
          updates.push(to_time(update['date'], site).iso8601)
        end
      end
      post_data["updates"] = updates
      return post_data
    end

    def write_to_file(subdir_name, item_name, items_array, site)
        # convert name to be safe as URL subpath
        safe_name = to_safe_name(item_name)
        # Create the directory structure
        dir = File.join(site.dest, api_subdir, api_version, subdir_name, safe_name)
        FileUtils.mkdir_p(dir)

        # Write the JSON file
        File.open(File.join(dir, "index.json"), "w") do |file|
          file.write(JSON.pretty_generate(items_array))
        end
    end

  end
end

# IMPORTANT: use the :post_write to make sure that files are written
# to dir AFTER the site has been generated. This allow you to have
# files to be generated in the reposiotry root at dir /api/v1/tags.
Jekyll::Hooks.register :site, :post_write do |site|

  tags = site.tags.keys
  tags.each do |tag|
    posts_with_tag = []
    site.tags[tag].map do |post|
      post_data = Jekyll::JekyllApi.create_post_object(post, site)
      posts_with_tag.push(post_data)
    end
    Jekyll::JekyllApi.write_to_file("tags", tag, posts_with_tag, site)
  end

  categories = site.categories.keys
  categories.each do |category|
    posts_in_category = []
    site.categories[category].map do |post|
      post_data = Jekyll::JekyllApi.create_post_object(post, site)
      posts_in_category.push(post_data)
    end
    Jekyll::JekyllApi.write_to_file("categories", category, posts_in_category, site)
  end

end
