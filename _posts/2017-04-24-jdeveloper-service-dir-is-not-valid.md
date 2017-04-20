---
title: Sorving *Service directory is not valid* in JDeveloper 12.2
category: ['How-tos']
tags: ['Oracle','JDeveloper']
---

![Service directory is not valid error]({{ site.baseurl }}/static/postimages/2017-04-24/001.PNG)

We know Java doesn't like spaces in classpaths, but anyway this is a strange bug introduced with Oracle JDeveloper 12.2 as it worked fine in JDeveloper 12.1 and 11g.

`Service directory is not valid` error shows up when you try to create a new adapter and there's a space in your application/project file path.

To solve this issue, perform the simple actions below:

1. close your OSB application
2. move its folder to some dir without spaces in its path
3. reopen your OSB app.

I hope it helps. Thanks for reading.
