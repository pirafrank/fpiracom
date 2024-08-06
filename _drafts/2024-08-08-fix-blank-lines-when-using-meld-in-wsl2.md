---
title: "Fix blank lines when using Meld in WSL2"
subtitle: "Meld may show a blank content when running on Ubuntu on WSL2 (WSLg)"
description: "How to fix Meld showing blank content when running on Ubuntu on WSL2 (WSLg)"
category: [ "How-tos" ]
tags: [ "Linux", "WSL", "terminal setup" ]
seoimage: ""
---

![default caption](https://fpira.com/static/postimages/3007/30013-meld-on-wslg.jpg)

WSL (Windows Subsystem for Linux) is a compatibility layer in Windows that allows you to run native Linux environments directly on Windows. It has gained traction becoming a must for many developers whose employer provides Windows machines. And as part of improvements in Windows 11, WSL2 includes [_WSLg_](https://github.com/microsoft/wslg), which enables running graphic applications on WSL and have them sit aside native Windows apps. WSLg on Windows 11 is enabled by default, just install some X11 app and test yourself. For example:

```bash
sudo apt update
sudo apt install x11-apps
xclock
```

So far, so good.

### Using Meld on WSLg

I have installed Meld on WSLg to automate some diff between a couple of repositories I have to check. My bash scripts have lines like this:

```bash
nohup meld ~/code/prj1/somedir ~/code/prj1/someotherdir &
```

Which it worked, but it showed a `meld` window with blank lines.

### Debugging it

So I rerun the command without `nohup` and checked the logs in the shell output. I noticed one of the (many) error lines in the CLI was:

```text
gtk-icon-theme-error-quark: Icon 'folder' not present in theme Yaru
```

### A quick fix actually

The error was about Meld missing system icons to show inline in the diff UI. [Adwaita](https://gitlab.gnome.org/GNOME/adwaita-icon-theme) is the needed theme to install.

```bash
sudo apt update
sudo apt install adwaita-icon-theme-full
```

Rerun it, and no more blank lines. Yay!

Side notes: My WSL distro is Ubuntu 20.04.5 LTS (Focal Fossa), but it should work for other Ubuntu versions / Gnome distros as well.

I hope it helps. Thanks for reading.

