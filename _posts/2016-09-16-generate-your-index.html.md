---
layout: post
title: Generate your index and keep directory listing off
subtitle: An easy way to access files in a folder on your webserver while keeping directory listing off
category: ['How-tos']
description: An easy way to access files in a folder on your webserver while keeping directory listing off
tags: ['nginx','Apache','Security','Python']
---

Directory listing is a useful feature available in many common web server, it shows the content of a directory (without any html index file) in browser as it would be a file manager.

While it comes handy to make some files easily available publicly, it could lead to information leaks. A misconfigured server could have overlapping directory listing rules which leave some folders with sensible information reachable by moving among dir-listed folders.

It's much simpler (and [recommended as security best practice](https://www.owasp.org/index.php/OWASP_Periodic_Table_of_Vulnerabilities_-_Directory_Indexing)) to disable directory listing completely and generate an index.html for each directory. In this case, the index should have relative links to all files in the folder you want to share (look at the example picture below).

![Directory listing example]({{ site.baseurl }}/static/postimages/gen_index/001.png)

But doing it by hand it's a terrible job, so I've written a Python script for that. You can find the script embedded at the end of this post. I've added comments in the code to make it easier to understand, but it's quite simple and most of all it doesn't require any modules to download. Python 2.x is all you need.

And although the generated page it's raw html, the script makes it responsive. Also, re-running it overwrites the previous `index.html`, so you don't have to delete the old one before updating the web page with new content.

Thanks for reading.

{% gist 970cbdb7542dab942da50cab408100d0 %}

