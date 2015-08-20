---
layout: post
title: Getting git bash completion to work on Linux and OS X
categories: git
---

Admit it, bash completion is cool and having it also in git is even cooler. But when you install git from source it often doesn't work. Here's how to fix it. 

In short, you need to have git-completion loaded in your bash. It is best for git-completion.bash to match the version of your installed git. Download it using the command after changing *0.0.0* with your installed git version.

```sh
wget -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/v0.0.0/contrib/completion/git-completion.bash
```

Now you need to load it by default in your bash. Add the line below to ```~/.bashrc``` on Linux, to ```~/.bash_profile``` on OS X:

```sh
source "$HOME/.git-completion.bash"
```

Then do:

```sh
source ~/.bashrc
```
if you're running Linux or ```source ~/.bash_profile``` if OS X is your OS.

Test it and enjoy!

#### More

If you want to, you can read more about this [in the official git doc](https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks#Auto-Completion).