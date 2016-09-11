---
layout: post
title: "My Jekyll workflow: Part 1"
subtitle: The first post of a series on my workflow with a Jekyll-based blog
category: ['Tutorials']
description: The first post of a series on my blogging workflow
tags: ['Jekyll','Blogging']
---

My website is hosted on a VPS, served by nginx and based on [Jekyll-Blue](https://github.com/pirafrank/Jekyll-Blue), an heavily customised fork of [Jekyll Now](https://github.com/barryclark/jekyll-now) which in turn is based on [Jekyll](https://jekyllrb.com/), a full-featured (and maybe the most popular) static site generator in town.

I like blogging and pushing Jekyll to its limits with new features I backport to my Jekyll-Blue project. It's my tinkering, at keyboard-level.

### Basic setup

I need Jekyll to build the website thus the best option is to do it on the server. This is also compatible in case you use GitHub Pages to host your website.

I publish posts (not pages) by committing and pushing to *master* branch. On server, a [bash script](https://gist.github.com/pirafrank/1533d1aa708faa7e98b0414da5034a1c) run by `cron` publishes the (stable) website daily at 3.00 PM.

The bash script builds in one folder and then uses `rsync` to copy files to the web dir (something like `/var/www/mywebsite.com`) for a couple of reasons:

- reducing the risk of broken files
- being SEO friendly by not modifying the date of unchanged files.

Following Git best practices, there is also a *develop* branch which is deployed for testing purposes to another path on server (e.g. `/var/www/unstable.mywebsite.com`). I use the `t` parameter in the above script to do that. If I am on my computer, I run [this other script](https://gist.github.com/pirafrank/3b72b2e851611569a7af03281a8d9c3d) to upload pre-built files on server via SSH using rsync. This way I can deploy other branches, too.

### Posting from mobile

Posting on the go is cool and handy. [Working Copy](https://workingcopyapp.com/) let me achieve that. It is *the* git client for iOS. If you are on Android, there are many options.

On mobile I usually don't do deep changes and just write posts, so the only branch I care to deploy is `master`. I access to the server via [Serverauditor](https://serverauditor.com/) app.

### Scheduled posts

Post scheduling is nice to have. When I have some spare time to dedicate to my blog, I plan future posts but manually publishing on time it's boring.

Jekyll ([since version 3.0](https://jekyllrb.com/docs/upgrading/2-to-3/)) doesn't publish by default posts with future dates, so I just name the post file with the date I want it to be published then I commit and push to master. The daily *cron* script will do the rest on the right date. The positive side effect is it will publish any other post pushed to master but not deployed.

See you on the next post of the series.

Thanks for reading.