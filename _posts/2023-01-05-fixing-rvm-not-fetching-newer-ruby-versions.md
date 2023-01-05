---
title: "Fixing rvm not fetching newer Ruby versions"
subtitle: "'rvm list known' may not known about latest Ruby versions. Here's how to fix."
description: "'rvm list known' may not known about latest Ruby versions. Here's how to fix."
category: ["How-tos"]
tags: ["rvm", "Ruby"]
seoimage: "2023-01-05/001.png"
---

Being back at Ruby after a while, I have found `rvm` lists of known Ruby versions to be stuck in the past. Running `rvm list known` the latest known versions were still 2.7.2 and 3.0.0. But those were [time ago](https://www.ruby-lang.org/en/downloads/releases/).

To fetch versions from the `stable` [branch](https://github.com/rvm/rvm/tree/stable) I have always run:

```
rvm get stable
```

But as of today, it looks like that branch is not actively updated anymore. Last commit is January 2021, marking for almost a two year hiatus. So I moved to the `master` [branch](https://github.com/rvm/rvm/tree/master).

```
rvm get master
```

Then running `rvm list known` again showed a refreshed list of Ruby versions, as you can see in the picture below.

![List of Ruby versions]({{ site.baseurl }}/static/postimages/2023-01-05/001.png)

Hope it helps, thanks for reading.
