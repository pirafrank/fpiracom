require 'date'
require 'tzinfo'
require_relative 'lib-shared'

module Jekyll

  # This plugin adds metadata to every 'post' object.
  # It adds:
  # - a new 'id' attribute,
  # - a new 'seo_image_url' attribute,
  # - a new 'most_recent_edit' attribute,
  # - a new 'most_recent_update' attribute,
  class PostMetadata < Generator
    safe true
    priority :low

    def generate(site)
      site.posts.docs.each do |post|

        # Add the post ID to the post data
        creation_date = post.date.strftime('%Y-%m-%d')
        post.data['uid'] = to_safe_name("#{creation_date}-#{post.data['slug']}")

        # Add a SEO image to the post data
        seoimage = ''
        if post.data['seoimage']
          seoimage = "#{site.config['url']}#{site.config['baseurl']}/static/postimages/#{post.data['seoimage']}"
        else
          seoimage = "#{site.config['url']}#{site.config['baseurl']}/assets/images/og_image.png"
        end
        post.data['seo_image_url'] = seoimage

        # Add most_recent_edit and most_recent_update dates to the post data.
        # It sets most_recent_update to the most recent 'updates.date' if it exists in front-matter,
        # or to 'post.date' if the former is missing.
        updates = post.data['updates']
        if updates && updates.is_a?(Array) && updates.length > 0
          # sort the updates by date. if there are multiple updates on the same day, sort them by order of appearance
          # considering that you go appending updates to the end of the array in post front-matter.
          # note: ordering now because it's a lot harder to do it in liquid.
          updates.sort_by! { |u| [u['date'], updates.index(u)] }
          # convert all dates to time objects
          updates.each { |u| u['date'] = to_time(u['date'], site) }
          # set to the most recent one
          latest_update = to_time(updates.last['date'], site)
          post.data['most_recent_edit'] = latest_update
          # also, to ease the display of the most recent update in the post,
          # add the most recent update to the front-matter
          post.data['most_recent_update'] = latest_update
        else
          # if there are no updates, use the creation date of the post
          post.data['most_recent_edit'] = post.data['date']
          # and initialize the updates array
          post.data['updates'] = []
        end
      end
    end

  end
end
