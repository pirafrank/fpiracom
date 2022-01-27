# powered by ruby-git (https://github.com/ruby-git/ruby-git)
# https://rubydoc.info/gems/git/Git.html?ref=https://githubhelp.com
#
# author: pirafrank < dev at fpira dot com >
#

require 'git'

module Jekyll
  class Repodetails < Generator
    def generate(site)
      date_format = "%Y-%m-%dT%H:%M:%S%z"

      # working_dir set to current dir ('.')
      g = Git.open('.', {})

      # do this only for pages with 'name: version' in front matter.
      # posts are not included in loop over pages.
      site.pages.each do |doc|
        if doc.data['name'] == 'version'
          current_commit = g.gcommit('HEAD')

          author_name = current_commit.author.name
          author_email = current_commit.author.email
          commit_hash = g.revparse('HEAD')
          commit_date = current_commit.author.date.strftime(date_format)
          branch = g.current_branch
          tag = g.describe('HEAD', {:all => false, :tags => true})

          doc.data['git_commit_author_name'] = author_name
          doc.data['git_commit_author_email'] = author_email
          doc.data['git_commit_hash'] = commit_hash
          doc.data['git_commit_date'] = commit_date
          doc.data['git_branch'] = branch
          doc.data['git_tag'] = tag
        end
      end

    end
  end
end
