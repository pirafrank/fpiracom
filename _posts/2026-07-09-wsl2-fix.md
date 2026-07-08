---
date: 2026-07-09
title: "A 30 seconds fix to a WSL2 catastrophic failure"
subtitle: "About how to fix a (pessimistic) WSL2 error log on Windows 11"
description: "How to fix the Wsl/Service/E_UNEXPECTED 'catastrophic' failure on Windows 11 without rebooting"
category: [ "How-tos" ]
tags: [ "Windows", "WSL" ]
seoimage: "3016/001.png"
---

I like WSL2 a lot. It is one of those pieces of my Windows setup that I expect to just be there: open the terminal, get my Linux shell, do the thing. It makes Windows 11 livable.

That also means that when it breaks, it feels worse than a normal application crash. It means I need to fix it fast. I use [Rio](https://rioterm.com/) and I configured it to start directly into zsh inside WSL2. One morning it simply closed immediately after launch. No time to read the error, no useful terminal left behind, just a very quick nope.

WSL2 is accessed from `wsl.exe` Windows executable so, as I usually do for those kind of Windows quirks, I opened a Powershell console e run `wsl` there to have a shell that stays open even if `wsl.exe` crashes.

## The problem

It printed the following.

{% include image.html
url="/static/postimages/3016/001.png"
desc="Running wsl.exe from PowerShell shows a Catastrophic failure error with Error code: Wsl/Service/E_UNEXPECTED."
alt="PowerShell terminal showing the command wsl and the error message Catastrophic failure, Error code Wsl Service E_UNEXPECTED."
%}

Wow! *Catastrophic* is a word I have very rarely seen in my life. Not one I’d rather use in code anyway. So I feared my WSL2 install was gone. Well, I thought *fair enough, I will re-import the backup as start again*, as have a backup on a ZFS pool server over a Samba share (but that’s a topic for a future blog post, maybe).

Then the `/Service/` string in the error caught my eye. Windows WSL integration is tight and makes wonders, like exposing localhost port bindings in WSL to Windows, allow Windows to access WSL files and viceversa, and more. Those functionalities are managed by a Windows Service.

What if it was the Windows Service the one who suffered from the *catastrophic* failure? Traditionally, a full Windows restart fixes many things but I had too many open apps to be willing to restart my laptop, so I took another path.


## How to fix

First turn off the WSL2 tiny VM to keep it safe.

```powershell
wsl --shutdown
```

Then manually restart the crashed Windows Service. Search for *Services*  in Start Menu and right click *WSL Service*, then *Restart*.

{% include image.html
url="/static/postimages/3016/002.png"
desc="Restarting the WSL Service from the Windows Services application."
alt="Windows Services application with WSL Service selected and the Restart option highlighted in the context menu."
%}

Once it’s done, back to the terminal to check if it’s fixed. Type `wsl` to restart the WSL2 machine and open its shell.

{% include image.html
url="/static/postimages/3016/003.png"
desc="After restarting the WSL Service, running wsl.exe from PowerShell opens the WSL shell again instead of returning the catastrophic failure error."
alt="PowerShell terminal showing an initial WSL catastrophic failure, then wsl shutdown, then a successful WSL shell prompt after running wsl again."
%}

Bingo! My WSL install is still safe and sound. The *catastrophe* was actually avoided and I get back to work.

I hope it helps. Thanks for reading.

