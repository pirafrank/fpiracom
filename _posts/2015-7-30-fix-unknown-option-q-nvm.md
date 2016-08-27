---
layout: post
title: Fix "unknown option '-q'" nvm install error
categories: ['Web Development']
description: A solution to unknown option -q error during nvm installation
tags: ['node.js']
---

Today I’ve stumbled upon a strange error installing nvm.

```text
unknown option '-q'
```

It turned out it was not related to nvm, but more to my bash settings. A dummy alias was causing the error and trying to give me a bad day. I luckily find the solution.

You simply need to remove all ```sha1``` aliases.

Check [this issue](https://github.com/creationix/nvm/issues/536) on github to know more.

Thanks for reading.