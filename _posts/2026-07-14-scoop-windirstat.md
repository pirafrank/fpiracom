---
date: 2026-07-10
title: "Fix Scoop installation error when installing WinDirStat on Windows 11"
subtitle: "What worked when Scoop failed to extract WinDirStat"
description: "A quick Windows 11 fix for Scoop failing to install WinDirStat with an Invoke-ExternalCommand FilePath null or empty error during extraction."
category: [ "How-tos" ]
tags: [ "Windows", "Tools", "Sys Admin" ]
seoimage: "3015/seo.jpg"
---

![Scoop WinDirStat install error in PowerShell]({{ site.baseurl }}/static/postimages/3015/scoop.jpg)

I hit a small but annoying Scoop problem on my Windows 11 setup while trying to install WinDirStat.

The command was simple enough:

```powershell
scoop install windirstat
```

Scoop downloaded the package, verified the hash, and then failed while extracting the archive.

The relevant part of the error looked like this:

```text
Invoke-ExternalCommand : Cannot validate argument on parameter 'FilePath'.
The argument is null or empty. Provide an argument that is not null or empty,
and then try the command again.

Failed to extract files from C:\Users\francesco\scoop\apps\windirstat\2.7.0\WinDirStat.7z.
```

In my case, the problem was related to Scoop trying to use an external 7zip setup. Disabling external 7zip usage for Scoop and reinstalling WinDirStat fixed it.

## The fix for short

Run these commands from PowerShell:

```powershell
scoop update
scoop update 7zip
scoop config use_external_7zip false
scoop uninstall windirstat
scoop cache rm windirstat
scoop install extras/windirstat
```

That was enough on my Windows 11 laptop.

## What the commands do

First, update Scoop itself:

```powershell
scoop update
```

Then update Scoop's 7zip package:

```powershell
scoop update 7zip
```

The important part, at least in my case, was this line:

```powershell
scoop config use_external_7zip false
```

This tells Scoop not to use an external 7zip executable. Instead, it uses the Scoop-managed one, which avoids the broken or missing external path that caused the `FilePath` error.

After that, remove the failed WinDirStat install:

```powershell
scoop uninstall windirstat
```

Clear the cached WinDirStat download:

```powershell
scoop cache rm windirstat
```

Then install it again from the `extras` bucket:

```powershell
scoop install extras/windirstat
```

## Final check

After reinstalling, WinDirStat should be available normally.

You can check it with:

```powershell
scoop list windirstat
```

Or just launch it:

```powershell
windirstat
```

This is one of those fixes that is mostly about getting Scoop back to a clean and predictable extraction path. Nothing fancy, but it saved me from digging through the install script and the 7zip log for longer than necessary.

I hope it helps. Thanks for reading.

