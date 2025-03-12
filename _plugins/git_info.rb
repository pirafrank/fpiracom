# powered by ruby-git (https://github.com/ruby-git/ruby-git)
# https://rubydoc.info/gems/git/Git.html?ref=https://githubhelp.com
#
# author: @pirafrank
#

require 'git'

Jekyll::Hooks.register :site, :pre_render do |site, payload|
    date_format = "%Y-%m-%dT%H:%M:%S%z"

    # checking for _data/git.json file to exist, if not create it
    git_data = File.join('_data','git.json')
    if(File.file?(git_data))
        puts "\t#{git_data} exists, site.data.git will read from it"
    elsif(File.directory?('.git'))
        puts "\t#{git_data} does not exists, attempting to read repo info git to populate site.data.git"
        g = Git.open('.', {})
        current_commit = g.gcommit('HEAD')

        author_name = current_commit.author.name
        author_email = current_commit.author.email
        commit_hash = g.revparse('HEAD')
        commit_date = current_commit.author.date.strftime(date_format)
        branch = g.current_branch
        tag = g.describe('HEAD', {:all => false, :tags => true, :always => true})

        payload.site.data['git'] = {}
        payload.site.data['git']['author_name'] = author_name
        payload.site.data['git']['author_email'] = author_email
        payload.site.data['git']['commit_hash'] = commit_hash
        payload.site.data['git']['commit_date'] = commit_date
        payload.site.data['git']['branch'] = branch
        payload.site.data['git']['tags'] = tag

        puts "\tsite.data.git populated with data from repo."
    else
      raise "#{git_data} does not exist and dir is not a git working copy."
    end
end
