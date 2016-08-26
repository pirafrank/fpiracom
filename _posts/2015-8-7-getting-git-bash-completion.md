---
layout: post
title: Get Git completion to work on Linux and OS X
categories: ['Development']
description: A guide to setup Git completion on Linux and OS X
keywords: git,git completion,osx,OS X,linux
tags: ['Git','macOS','Linux']
---

Admit it, bash completion is cool and having it also in git is even cooler. But when you install git from source it often doesn't work. Here's how to fix it. 

In short, you need to have git-completion loaded in your bash. It is best for git-completion.bash to match the version of your installed git. 

Download it using the command after changing *0.0.0* with your installed git version.

```sh
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/v0.0.0/contrib/completion/git-completion.bash
```

Now you need to load it by default in your bash. Add the line below to ```~/.bashrc``` on Linux, to ```~/.bash_profile``` on OS X:

```sh
# adding git completion
if [ -f ~/.git-completion.bash ]; then
. ~/.git-completion.bash
fi
```

Then do:

```sh
source ~/.bashrc
```

if you're running Linux or 

```sh
source ~/.bash_profile
```

if OS X is your OS.

*Done!*

### More

If you want to, you can read more about this [in the official git doc](https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks#Auto-Completion).

### UPDATE

If it is not working for you, you have to set up bash completion. Check it [here]({{ site.baseurl }}/blog/2015/10/getting-bash-completion/).

Thanks for reading.
