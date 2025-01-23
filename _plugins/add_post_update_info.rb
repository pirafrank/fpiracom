
# inspired by https://github.com/logista/btsite/blob/master/_plugins/recentdate.rb
# edited by pirafrank

module Jekyll
  class RecentDate < Generator
    def generate(site)
    # This plugin adds a new 'most_recent_edit' attribute to every post.
    # It is set to the most recent 'updates.date' if it exists in front-matter, or to 'date' if the former is missing.
    # And it makes that a string, because liquid.
      site.posts.docs.each do |doc|
        updates = doc.data['updates']
        if updates && updates.is_a?(Array) && updates.length > 0
          # sort the updates by date. if there are multiple updates on the same day, sort them by order of appearance
          # considering that you go appending updates to the end of the array in post front-matter.
          # note: ordering now because it's a lot harder to do it in liquid.
          updates.sort_by! { |u| [u['date'], updates.index(u)] }
          # set to the most recent one
          latest_update = updates.last['date'].to_s
          doc.data['most_recent_edit'] = latest_update
          # also, to ease the display of the most recent update in the post,
          # add the most recent update to the front-matter
          doc.data['most_recent_update'] = latest_update
        else
          # if there are no updates, use the creation date of the post
          doc.data['most_recent_edit'] = doc.data['date'].to_s
          # and initialize the updates array
          doc.data['updates'] = []
        end
      end
    end
  end
end
