---
layout: post
title: "My Jekyll workflow: Part 2"
subtitle: Improving my Jekyll publishing workflow
category: ['Tutorials']
description: Tips to improve your Jekyll publish workflow
tags: ['Jekyll','Pythonista','Blogging','Python']
---

In [part 1]({{ site.baseurl }}/blog/2016/09/my-jekyll-workflow-part1) I wrote about my basic workflow. It worked fine but the most important part, the writing experience, was not that great. So I decided to leave move on and leave the built-in Working Copy editor for another one which would have improved my blogging experience.

### A better editor: iA Writer

I really like [iA Writer](https://itunes.apple.com/app/id775737172?mt=8&uo=4&at=10l4LV&ct=w), it's well designed and makes you focus on what you type. I still use it for all my writing needs. 

What's more, their [new feature](https://ia.net/writer/templates) called *templates* lets you customise the markdown rendering in *Preview* mode. So I've build a template using the same CSS code from the blog to preview posts on desktop and mobile without committing and pushing.

It is [available as open-source](https://github.com/pirafrank/My-iA-Writer-templates) and you might want to start from it in case you decide to go for [Jekyll-Blue](https://github.com/pirafrank/Jekyll-Blue).

### Handling static resources

The downside effect of the above changes is I wasn't able to preview post images in iA Writer, because the path (starting `site.baseurl`) couldn't be rendered as a correct and publicly accessible url.

Therefore, I excluded static files from the website repo to be able to put them online without needing to commit and to make the repo much smaller. To upload resources, I do via SFTP. On desktop many options are available, from [Cyberduck](https://cyberduck.io/?l=en) to command line, on the go there are the free [Documents by Readdle](https://readdle.com/documents) on iOS and [ES File Manager](https://play.google.com/store/apps/details?id=com.estrongs.android.pop) on Android. With static files online and publicly accessible, I just have to write their url (e.g. `https://fpira.com/static/...`) in the blog post to get a working preview in iA Writer (provided an Internet connection, of course).

Then, I made another repo and enabled Git LFS on it. Both [BitBucket](https://blog.bitbucket.org/2016/07/18/git-large-file-storage-now-in-bitbucket-cloud/) and [GitHub](https://git-lfs.github.com) support large file storage.

### Improving static resources handling

While the above solution works fine, it doesn't fit in case you have to change your website domain or the `baseurl`. Although those aren't common actions and editing all the posts can be done in batch by a bash script, they break the Jekyll repo concept and best practises.

For this reason, replacing the domain (e.g. `https://mywebsite.com`) with `site.baseurl` variable is needed.

#### Option 1: the built-in one

Before exporting from iA Writer to Working Copy or committing on desktop, do a quick *Find & Replace* right in the text editor.

#### Option 2: a bit of automation

I wrote a little script for [Pythonista](https://omz-software.com/pythonista/), a cool iOS app which provides a full Python IDE and environment.

The script ([available here](https://gist.github.com/pirafrank/e0db410304d6543a78bdf713b1f5c118)) takes text shared to it as input, performs the substitutions and prompts you the share menu, ready to export text to Working Copy. Look at the video below.

{% youtube TWPjJLooGM8 %}

### Deploying without SSH-ing: jekyll-deployer

Deploying on the go using an ssh client is cool but typing the same commands over and over is not, so I decided to improve this using Pythonista once again. I wrote [jekyll-deployer](https://github.com/pirafrank/jekyll-deployer), a tiny flask app and a Python script to act as client on iOS.

The flask app handles a POST request made the script and notifies to me on the [Pushbullet](https://www.pushbullet.com) app. To make it dead-simple, there's no login and security is obtained using a randomly generated 20-chars-long alpha-numeric url. The url is actually a *location* in the nginx configuration (it acts as proxy to the app listening on port `5090`).

The POST contains the branch to deploy and a flag to tell the server if that branch is for production deploy. It helps not to put configuration for stable deploys straight into the Pythonista script, just because is much easier to break into our phone than on a good set up VPS. Configuration includes the target directory and the Jekyll command to run (e.g. `jekyll build` for stable, and `jekyll build --drafts --future`, for testing). Launching the script popups a native iOS menu to let you choose which branch to deploy. You can see it in action below.

{% youtube C8KvhIWRXJM %}

### Further improvements

The flask app in jekyll-deployer could be modified to handle POSTs from BitBucket/GitHub. That would work as a webhook waiting for pushes to *master* branch.

Furthermore static resources could be served by a CDN or stored on Amazon S3 with the LFS repo as backup. But this is a topic for another post.

Thanks for reading.

