# powered by ruby-git (https://github.com/ruby-git/ruby-git)
# https://rubydoc.info/gems/git/Git.html?ref=https://githubhelp.com
#
# author: pirafrank < dev at fpira dot com >
#

require 'git'

module Jekyll
  class RepoDetailsTag < Liquid::Tag
    def initialize(tag_name, markup, options)
      super
      date_format = "%Y-%m-%dT%H:%M:%S%z"
      @input = markup.strip
      @today_date = Time.now.strftime(date_format)
      # working_dir set to current dir ('.')
      g = Git.open('.', {})
      current_commit = g.gcommit('HEAD')
      @author_name = current_commit.author.name
      @author_email = current_commit.author.email
      @commit_hash = g.revparse('HEAD')
      @commit_date = current_commit.author.date.strftime(date_format)
      @branch = g.current_branch
      @tag = g.describe('HEAD', {:all => false, :tags => true})
    end

    def render(context)
      %Q[
        "lastCommit": {
          "author": {
            "name": "#{@author_name}",
            "email": "#{@author_email}"
          },
          "hash": "#{@commit_hash}",
          "dateTime": "#{@commit_date}",
          "branch": "#{@branch}",
          "tag": "#{@tag}"
        }
      ]
    end
  end
end

Liquid::Template.register_tag("repodetails", Jekyll::RepoDetailsTag)
