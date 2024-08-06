---
title: "Oh my! Terminals are dropping from above"
subtitle: "A look at quake-mode for terminal applications"
description: "A look at quake-mode and terminals supporting it"
category: [ "Posts" ]
tags: [ "terminal setup", "Linux", "Windows", "Tools" ]
seoimage: ""
---

![default caption](https://fpira.com/static/postimages/3006/32659-quake-mode.jpg)

As a developer, your terminal is an essential tool and often the first piece of software you customize. It's where you run commands, code, connect to servers, interact with CLI tools, and so much more. For many of us, it’s our working home. Thus having a quick access to our terminal can save precious seconds that add up until the end of the day (night?).

### What is quake-mode?

Inspired by the famous classic FPS game Quake, where pressing the tilde key dropped down a console from the top of the screen, _quake-mode_ refers to a terminal window that can be toggled on and off quickly (usually by a hotkey) and drops down from the top of the screen (or slides from any other side). This allows for an instant access to the terminal without disrupting your current workflow. So your command line always within reach, just a key press away.

### A couple of benefits

1. **Quick access**: No need to switch windows or open a new application. Your terminal is always ready.
2. **Distraction-free**: The drop-down design means you can use the terminal without cluttering your workspace with multiple windows, especially if you’re not using a tiling window manager.
3. **Efficient multitasking**: Quickly run commands, check logs, or execute scripts while keeping your main focus intact.
4. **Customizable**: Most quake mode terminals are highly customizable, allowing you to set up hotkeys, themes, and other preferences to match your workflow.

### Terminals supporting it

While there are many terminal applications out there, not all support quake-mode, and some are even quake-mode only.

For Linux:

1. **Guake**
	- A terminal emulator for GNOME that smoothly drops down from the top of the screen.
	- **OS**: Linux (GNOME)
	- **Quake-mode only:** yes
2. **Yakuake**
	- A drop-down terminal emulator for KDE, highly configurable and easy to use.
	- **OS**: Linux (KDE)
	- **Quake-mode only:** yes
3. **Tilda**
	- A lightweight terminal inspired by the Quake console.
	- **OS**: Linux
	- **Quake-mode only:** yes
4. **Terminator**
	- Offers multiple panes and tabs, and quake-mode support.
	- **OS**: Linux, BSD
	- **Quake-mode only:** no
	- **How:** [here](https://forums.bunsenlabs.org/viewtopic.php?id=4651).

For macOS:

1. **iTerm2**
	- A powerful terminal emulator with a "Visor" feature similar to quake-mode.
	- **OS**: macOS
	- **Quake-mode only:** no
	- **How**: [here](https://dev.to/vikbert/drop-down-iterm2-in-macos-2od).

For Windows:

1. **Windows Terminal**
	- Surprise! Microsoft's modern terminal introduced quake-mode in version 1.9.
	- **OS**: Windows
	- **Quake-mode only:** no
	- **How**: [here](https://learn.microsoft.com/en-us/windows/terminal/tips-and-tricks#quake-mode).
2. **ConEmu**
	- A versatile terminal emulator with quake mode and customizable hotkeys.
	- **OS**: Windows
	- **Quake-mode only:** no
	- **How**: [here](https://conemu.github.io/en/SettingsQuake.html).
3. **Cmder**
	- A software package built on ConEmu, offering a full-featured terminal experience.
	- **OS**: Windows
	- **Quake-mode only:** no
	- **How**: [here](https://medium.com/@nuno.caneco/cmder-quake-style-e57601d1c07b).

Cross-platform:

1. **Tabby**
	- Formerly Terminus, it is a configurable terminal emulator, SSH and serial client implemented as a web app running in Electron, and extensible via plugins.
	- **OS**: Linux, macOS, Windows
	- **Quake-mode only:** no
		- Note: while supporting it OOTB, it is reported to [have](https://github.com/Eugeny/tabby/issues/6114) [some](https://github.com/Eugeny/tabby/issues/6939) [issues](https://github.com/Eugeny/tabby/issues/5171).
	- **How**: [here](https://github.com/Eugeny/tabby/discussions/4830).
2. **Hyper**
	- Extensible terminal by the awesome team at Vercel, it is built on web technologies and supports quake-mode via plugins.
	- **OS**: Linux, macOS, Windows
	- **Quake-mode only:** no
	- How: [here](https://www.npmjs.com/package/hyperterm-summon).
		- Note: I have not listed [CWSpear/hyperterm-visor](https://github.com/CWSpear/hyperterm-visor) because it is unmaintained and its developer has archived the repository.

### Additional notes

- I have not tested all the _How_ links above, as I do not have all possible setup combinations. So YMMV.
- [WezTerm](https://github.com/wez/wezterm) and [Alacritty](https://github.com/alacritty/alacritty) are my favorite terminal apps, unfortunately they do not support quake-mode. However, it looks like some people got it working with Alacritty somehow. For example [on macOS](https://gist.github.com/truebit/31396bb2f48c75285d724c9e9e037bcd) via Hammerspoon, and on Linux (with windowing by X Window System) via [custom scripting](https://github.com/cy4n1c/alacritty-dropdown). But I have tested none of them. I will update this blog post if I test any, and in case I found my way to get at least one of the two working.

### Conclusion

As a developer, optimizing your tools for efficiency is crucial. Quake mode terminals provide a seamless and efficient way to keep your terminal always within reach. Whether you’re using Linux, macOS, or Windows, there’s a terminal with quake-mode that fits your needs. Explore these options and integrate one into your workflow to experience a significant boost in productivity.

I hope it helps. Thanks for reading.

