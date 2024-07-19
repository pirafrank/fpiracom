---
title: "Leveraging Alacritty Terminal on Windows for a Seamless Experience in Both PowerShell and WSL2"
subtitle: "A Windows terminal setup to bridge PowerShell and WSL out of Windows Terminal"
description: "Find out how to quickstart a new terminal experience in both PowerShell and WSL2 by using Alacritty on Windows"
category: [ "How-tos" ]
tags: [ "Windows", "Windows 10", "terminal setup", "Alacritty" ]
seoimage: "3005/19650-d65cf697-84e1-4a00-8f16-16bcc334044f001.jpg"
---

# Leveraging Alacritty Terminal on Windows for a Seamless Experience in Both PowerShell and WSL2

[Alacritty](https://github.com/alacritty/alacritty) is a Rust-coded high-performance terminal emulator known for its speed and efficiency. It stands out because of its OpenGL ES-based GPU acceleration, multi-window support, and cross-platform capabilities as it runs on Linux, BSD, macOS as well as Windows.. This makes it a flexible terminal and one of the best out there.

## Setting Up Alacritty on Windows

Windows has not been a good platform for terminals for decades and left users to the likes of the default Prompt and apps like ConEmu, but since the [introduction of ConPTY](https://devblogs.microsoft.com/commandline/windows-command-line-introducing-the-windows-pseudo-console-conpty/) (available in Windows 10 version 1809 and above) a lot has changed and terminals like Alacritty are finally a possibility on Windows, too. Even Microsoft now has [its take on it](https://github.com/microsoft/terminal).

If you find yourself in the need for a terminal or wanting to replace the default choice on Windows, you can give Alacritty a chance. Installing it on the host is good to use it both with PowerShell and with the multitude of WSL2 distros you may have installed.

Coming from a Linux world I prefer installing most of my apps in userspace. `scoop` command-line installer makes it easier:

```text
scoop install alacritty
```

## Configuration

The main configuration file is `alacritty.yml` and allows substantial customization. For a sample configuration check the default one. For a more cross-platform setup with shared settings, refer to my [dotfiles repository](https://github.com/pirafrank/dotfiles/tree/main/terminals/alacritty).

## Using Alacritty with PowerShell

Configuring Alacritty to work with PowerShell can be done via the YAML config file.

An alternative is to create a shortcut in Windows and start Alacritty by passing a different configuration to it. Create the shortcut, then in _Properties_ set `target` to:

```text
C:\Users\francesco\scoop\apps\alacritty\current\alacritty.exe --config-file "C:\Users\francesco\dotfiles\gui_terminals\alacritty\alacritty_pwsh.yml" --working-directory "C:\Users\francesco"
```

and `start in` to:

```text
C:\Users\francesco\scoop\apps\alacritty\current
```

You need to adapt paths to your username and config files.

Now you can now move it to Desktop, Start Menu (`C:\ProgramData\Microsoft\Windows\Start Menu`), or even to the StartUp apps folder (`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`).

## Using Alacritty with WSL2

To open WSL2 sessions seamlessly with Alacritty, you can make it run `wsl.exe` . In this case ensure it is configured correctly to launch your preferred distro running your favorite shell (in my case, `zsh`). Alternatively, like above, it is possible to create a Windows shortcut to streamline this process and make it work with different WSL2 distro setups.

Create the shortcut, then in _Properties_ set `target` to:

```text
C:\\Users\\francesco\\scoop\\apps\\alacritty\\current\\alacritty.exe --working-directory "%USERPROFILE%" -e wsl -d <WSL_DISTRO_NAME> zsh
```

and `start in` to:

```text
C:\Users\francesco\scoop\apps\alacritty\current
```

Substitute `<WSL_DISTRO_NAME>` with your specific WSL distribution name. For more details on zsh configurations, check the zsh dir in my dotfiles repo.

## Conclusion

I use Alacritty for both Linux and PowerShell environments on Windows as it brings big performance and usability benefits. Its choice not to support splits and tabs alike removes a variable from the equation and lets you focus on your task or run your multiplexer of choice. It has been my go-to choice for some time and I like how it allows for various degrees of customizations to create a setup that best meets your workflow needs.

Thanks for reading. I hope it helps.

