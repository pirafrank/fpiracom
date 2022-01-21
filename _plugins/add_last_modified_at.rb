# powered by ruby-git (https://github.com/ruby-git/ruby-git)
# https://rubydoc.info/gems/git/Git.html?ref=https://githubhelp.com
#
# author: pirafrank < dev at fpira dot com >
#

require 'git'

module Jekyll
  class RecentDate < Generator
    def generate(site)
    # This plugin adds a new 'last_update' attribute to every post.
    # It is set to the 'last_edit_at' if it exists in front-matter, or the 'date' if the former is missing.
    # And it makes that a string, because liquid.
      date_format = "%Y-%m-%dT%H:%M:%S%z"

      # working_dir set to current dir ('.')
      g = Git.open('.', {})

      # doc.path as in https://github.com/jekyll/jekyll/blob/master/lib/jekyll/page.rb
      site.pages.each do |doc|
        page_path = (doc.path).to_s
        doc.data['path_is'] = page_path
        g.worktree(page_path)
      end

      site.posts.docs.each do |doc|
        doc.data['last_update'] = (doc.data['last_edit_at'] || doc.data['date']).to_s

        page_path = (doc.path).to_s
        doc.data['path_is'] = page_path
      end
    end
  end
end
