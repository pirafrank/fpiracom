---
layout: post
title: Getting bash completion on OS X and Linux
categories: ['How-tos']
description: A guide to setup bash completion on Linux and OS X
tags: ['Bash','macOS','Linux']
---

1. Install bash-completion

on OS X:

```sh
sudo port install bash-completion
```

on Linux:

```sh
sudo apt-get install bash-completion
```

2. Paste this in your .bashrc / .bash_profile

on OS X:

```sh
# MacPorts Bash shell command completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
```

or for MacPorts since version 2.1.2 on Mountain Lion:

```sh
# MacPorts Bash shell command completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi
```

or for MacPorts with newer versions of git:

```sh
if [ -f /opt/local/share/git-core/git-prompt.sh ]; then
    . /opt/local/share/git-core/git-prompt.sh
fi
```

**Note:** Bash 4.1 or higher is required by bash\_completion.sh. If completion doesn't work try ```echo $BASH_VERSION``` to see if that's the issue. If so, enter MacPorts bash by typing bash and try git completion again.

On Linux:

```sh
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
```

Thanks for reading.

---

Sources:

- https://superuser.com/questions/31744/how-to-get-git-completion-bash-to-work-on-mac-os-x

- https://askubuntu.com/questions/33440/tab-completion-doesnt-work-for-commands
