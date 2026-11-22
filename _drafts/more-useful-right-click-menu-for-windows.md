---
title: "A More Useful Windows Explorer Context Menu"
subtitle: "Launch editors, WSL, and file utilities from right-click actions"
description: "A practical walkthrough of configuring Custom Context Menu with JSON commands for files, folders, editors, WSL, and common utilities."
category: [ "How-tos" ]
tags: [ "Windows", "Windows 10", "WSL", "Tools" ]
---

Windows Explorer is where many file and project workflows begin, but its built-in context menu rarely has every action I want. The [Custom Context Menu](https://apps.microsoft.com/detail/9pc7bzz28g0x?hl=en-US&gl=IT) app lets me add commands that appear when I right-click a file or folder. In this setup, that means jumping straight into an editor, opening a Linux shell at a folder, or doing a quick file utility task without first navigating through another application.

The command definitions live as JSON files in `custom_commands`. Each one supplies a menu title, the program or script to run, an optional icon, and rules for whether it accepts files, folders, or multiple selections. The paths in these definitions point to this machine’s installed programs and dotfiles, so they need adjusting on another PC. The app ignores command files placed in subdirectories of `custom_commands`, so the active JSON files belong directly in that folder.

Every command name below links to its JSON file in the [`custom_commands` directory at commit `d00f91a`](https://github.com/pirafrank/dotfiles/tree/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands), so you can inspect the exact configuration.

## Quick file actions

### [Copy content to clipboard](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Copy%20file%20content.json)

This command is available for a single file. It runs a small batch script that checks that a path was supplied and that the file exists, then sends the file’s contents to the Windows clipboard with `clip`. It is handy for copying a configuration, source file, or short text document into a chat, issue, or editor without opening it first. Keeping the action in Explorer makes the common “open, select all, copy, close” sequence a single right-click operation.

### [Get file details](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Get%20file%20details.json)

This command runs the `file` utility on a selected file and prints the result in a terminal window. The utility identifies a file from its contents, which can help when the extension is missing or misleading. The script checks that `file` is installed and pauses after printing, so the result stays visible. This is a quick diagnostic for downloads, unfamiliar files, and format troubleshooting.

## Open folders and projects where work happens

### [Open in WSL](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20in%20WSL.json)

The WSL action accepts folders. Its batch script converts the selected Windows path with `wslpath`, changes to the corresponding Linux directory, and starts Zsh. The benefit is a shell already positioned at the folder selected in Explorer: no manual path conversion and no `cd` by hand. This is especially useful when Windows is used for browsing files but Linux tools handle the development workflow.

### [Open in New Window](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20In%20New%20Window.json)

This action opens a selected folder in Windows Explorer. It is a small convenience when navigating a deep directory tree: open the folder in a separate window and keep the original location available. The command is wired directly to `explorer.exe` and uses its built-in icon.

### [Open in Eden Explorer](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20in%20Eden%20Explorer.json)

This is another folder-opening option, pointed at the locally installed Eden Explorer. Having a second file manager in the context menu is useful when it offers a different layout or navigation style that suits a particular task. The entry is configured for directories, so it stays focused on browsing rather than trying to open individual files.

## Choose an editor from Explorer

The editor actions accept files and folders, letting the same menu entry open a project directory or a specific file. That saves time when switching between tools or when a particular editor is better suited to the task.

- [**Open in Cursor**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20in%20Cursor.json) opens the selection in Cursor. It is convenient for AI-assisted editing and project work where Cursor is the preferred environment.
- [**Open in VS Code**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20in%20VS%20Code.json) opens it in Visual Studio Code, a familiar general-purpose editor with a broad extension ecosystem.
- [**Open in Zed**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20in%20Zed.json) opens it in Zed. This entry also accepts multiple selected files, which can make it quicker to inspect or edit a small group together.
- [**Open with Vim**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20with%20Vim.json) launches the command-line Vim executable. It is useful for a keyboard-driven editing workflow and for making quick changes without leaving the terminal-oriented toolset.
- [**Open with gVim**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20with%20gVim.json) launches Vim’s graphical version, offering Vim editing behavior in a windowed interface.
- [**Open with neovim**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20with%20nvim.json) opens the selection in the Neovim executable installed under `Program Files`. It provides a modern Vim-style editor while keeping the familiar modal workflow.
- [**Open with neovim-qt**](https://github.com/pirafrank/dotfiles/blob/d00f91a5faa09d40a4c878d524810a0d9d39c262/Windows/CustomContextMenu/custom_commands/Open%20with%20nvim-qt.json) uses the Qt graphical front end for Neovim. It is a useful option when I want Neovim’s editing model in a standalone GUI.

Keeping several editors available is valuable because “open this folder” does not always mean the same thing: a lightweight edit, a larger project session, and a GUI-based review can call for different tools. Explorer becomes a launcher that follows the selected item, instead of requiring each editor to be opened first and navigated to the right path.

## Load the JSON configuration

1. Install **Custom Context Menu** from the [Microsoft Store](https://www.microsoft.com/store/productId/9PC7BZZ28G0X?ocid=pdpshare).
2. Open the app’s command folder at `%LOCALAPPDATA%\Packages\7061touchwp.CustomContextMenu_m9vp3t2f55f5t\LocalState\custom_commands`. Create `custom_commands` if it does not exist.
3. Copy the JSON files directly inside this repository’s `custom_commands` folder into that app folder. Copy only the files at the top level; the app ignores files in subfolders.
4. Review the JSON `exe`, `icon`, and script paths and change them if your programs or this dotfiles checkout live elsewhere. These paths currently refer to Francesco’s Windows profile and installed applications.
5. Restart or refresh Custom Context Menu if it is already running, then test an entry on a matching file or folder.

From this repository’s directory, `restore.ps1` provides a copy-based alternative: it copies the local `custom_commands` directory into the app’s `LocalState` folder. Existing files with matching names may be overwritten. To bring the app’s current configuration back into the repository instead, `backup.ps1` copies in the opposite direction and replaces the repository’s `custom_commands` directory, so use that when you intend to update the checked-in copy.

## A small menu that removes repeated steps

The advantage of these entries is not any single feature; it is the shorter path from finding an item to acting on it. A file can be inspected or copied immediately, a project can open in the editor that fits the moment, and a folder can become a ready-to-use WSL shell. Because the definitions are plain JSON and the helper actions are small scripts, the menu can be tailored to the tools already installed and the workflows that come up every day.
