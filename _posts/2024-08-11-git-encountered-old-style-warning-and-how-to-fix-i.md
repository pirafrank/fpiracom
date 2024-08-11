---
title: "How to fix ‘git encountered old-style’ warning"
subtitle: "A quick fix for this warning in git CLI"
description: "A quick fix for 'old-style' warning in git"
category: [ "How-tos" ]
tags: [ "Git" ]
seoimage: ""
---

Git is a very powerful piece of software, capable of tracking thousands of files. Still, sometimes it has its own quicks.

### Problem

If you are reading this, you may have encountered an error like the one below:

```text
warning: encountered old-style '/Users/francesco/dotfiles/git/hooks'
that should be '%(prefix)//Users/francesco/dotfiles/git/hooks’
```

### Solution

1. go to your `.gitconfig` in `$HOME`
2. edit to prepend `%(prefix)` to settings like `hooksPath`.
3. save file, and try your `git` command again.

### Why?

Curious about why it happens? Read more [here](https://git-scm.com/docs/git-config#Documentation/git-config.txt-pathname).

I hope it helps. Thanks for reading.
