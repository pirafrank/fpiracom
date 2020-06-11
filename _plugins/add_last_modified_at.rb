
# inspired by https://github.com/logista/btsite/blob/master/_plugins/recentdate.rb
# edited by pirafrank

module Jekyll
  class RecentDate < Generator
    def generate(site)
    # This plugin adds a new 'last_update' attribute to every post.
    # It is set to the 'last_modified_at' if it exists in front-matter, or the 'date' if the former is missing. 
    # And it makes that a string, because liquid.
      site.posts.docs.each do |doc|
        doc.data['last_update'] = (doc.data['last_modified_at'] || doc.data['date']).to_s
      end
    end
  end
end
