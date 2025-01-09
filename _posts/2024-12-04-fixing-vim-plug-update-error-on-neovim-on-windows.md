---
title: "Fixing vim-plug update error on Neovim on Windows"
subtitle: "About PlugUpdate quitting on error because 'remote process closed or ended abnormally'"
description: 'A guide to fix `An unknown element \\"\\" was received` while upgrading plugins with vim-plug on Neovim on Windows'
category: [ "How-tos" ]
tags: [ "terminal setup", "Neovim" ]
seoimage: "3012/44053-untitled.png"
---

![default caption](https://fpira.com/static/postimages/3012/44053-untitled.png)

I’ve recently started transitioning to [Neovim](https://neovim.io/) and configuring it for development. Its native asynchronous support, Lua scripting, Language Server Protocol (LSP), and Debug Adapter Protocol (DAP) provide an IDE-like experience directly in the command line.

My configuration started as an overhaul of the one I use with Vim. I use _vim-plug_ as the plugin manager and everything was working flawlessly until I run `:PlugUpdate` to update Neovim plugins I had previously downloaded.

### The problem

The command worked for some plugins, but went on error for others with the following message:

```text
An unknown element "" was received.
This can happen if the remote process closed or ended abnormally.
```

Well, there were actually a lot of them.

### Understanding why

After a bit of searching and troubleshooting, it turns out that some plugins didn’t like I had set PowerShell as the default shell on Windows in [my vim config](https://github.com/pirafrank/dotfiles/blob/6962a0c074b91e4fbea654e60f57845f230c848f/vim/base.vimrc#L18).

```text
" choose shell
if has('win32')
    set shell=pwsh.exe
endif
```

You can check if yours is set to PowerShell as well by running:

```text
:set shell?
shell=pwsh.exe
```

But why does this cause issues?  The problem lies in the fact that these plugins rely on running scripts in Command Prompt (`cmd.exe`). Executing them in PowerShell makes them crash and quit on error. And since they are executed in a non-interactive shell, the shell errors are not visible and that makes the debug a bit tricky.

### Solution

If, like me, you’ve programmatically set PowerShell as your default shell in your configuration and don’t want to switch back to Command Prompt, there’s a simple workaround: temporarily unset the `shell` variable before updating your plugins.

```text
:set shell&
```

Then check the `shell` value. It should be reverted to `cmd.exe`.

```text
:set shell?
shell=cmd.exe
```

You can now update your plugins.

```text
:PlugUpdate
```

This setting is temporary and will reset the next time you load your configuration.

I hope it helps. Thanks for reading.
