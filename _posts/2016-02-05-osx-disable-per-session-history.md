---
layout: post
title: Disable per-session history file in OS X El Capitan
categories: ['Guides']
description: How to disable per-session history in Terminal in OS X El Capitan
tags: ['macOS','Bash']
---

With the release of OS X El Capitan [Apple has made a subtle change](https://www.reddit.com/r/osx/comments/397uep/changes_to_bash_sessions_and_terminal_in_el/) in how the bash history file works.

History is a handy feature to recall commands you gave in the past, especially if used together with `grep`.

I’ve been noticing this new (weird) way right after the installation of the latest major release. But I’ve never cared that much about until today, when I stumbled across the solution while playing with bash.

### Solution

As stated in [this StackOverflow answer](http://stackoverflow.com/questions/32418438/how-can-i-disable-bash-sessions-in-os-x-el-capitan), bash runs a check every time a new  session in started. Disabling the per-session history is as easy as:

```sh
touch .bash_sessions_disable
```

You may need to restart your sessions to apply the setting.

### Fix 2.0

Now we may go a bit further and be sure history is written to `~/.bash_history`.

Open your `.bash_profile` with nano

```sh
nano ~/.bash_profile
```

and add the line below at the very end of the file

```sh
export HISTFILE="$HOME/.bash_history"
```

Of course you can change the path to the one you like the most. Just be sure you have `write` permission there. That’s all!

Thanks for reading.
