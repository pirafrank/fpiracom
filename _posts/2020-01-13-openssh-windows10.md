---
title: OpenSSH on Windows 10
subtitle: Install and configure OpenSSH server and client on Windows 10
description: Install and configure OpenSSH server and client on Windows 10
category: ["How-tos"]
tags: ["Sys Admin", "Windows 10", "Windows"]
---

Well, you want to install OpenSSH server in Windows 10.

### Before we start

If you found [this tutorial from Microsoft](https://devblogs.microsoft.com/powershell/using-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709/), consider it is broken in multiple ways. So don't follow it.

You can find updated steps below. I've tested them on Windows 10 (1903).

### Let's start!

First delete everything:

  - uninstall OpenSSH server and client from *Apps & Features* section in Windows 10 Settings and reboot
  - delete `C:\ProgramData\ssh` and its contents
  - delete `C:\Windows\System32\OpenSSH` and its contents
  - remove any OpenSSH server and client package installed through Cygwin (you should've done this before trying to install OpenSSH server for Windows 10

Then follow [this guide](https://github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH/0b6d262a5792ac48369f75faccf8172231146cb6) (step by step). If you have Windows 10 (by this I mean the consumer version, not Windows Server 2016 or above), to open port 22 on Windows firewall, you should use:

```
netsh advfirewall firewall add rule name=sshd dir=in action=allow protocol=TCP localport=22
```

OpenSSH should be installed by now. Host keys will be generated on first run and placed `%programdata%\ssh`. **Important:** Do not edit permissions of this folder or files inside.

Check for OpenSSH install to be on *PATH*:

1. Go to Computer > Properties > Advanced System Settings > Environment variables > System variables > select *PATH* and click *Edit*
2. Remove any *OpenSSH* location different than `C:\Program Files\OpenSSH` and add it if it's missing.
3. Click OK and close.

You better follow also [optional steps](https://github.com/PowerShell/Win32-OpenSSH/wiki/DefaultShell), too. For example, I'd set it to start at boot.

Ok, done.

### Test it

Just try to ssh to the freshly setup openssh server. By default port is 22 and all users are enabled to connect. 

To check it:

1. open the *Services* app (you can look for it from the search bar)
2. scroll to *OpenSSH SSH Server* (the `sshd` service) and double click it
3. in the *Log On* tab, *Local System account* should be selected. 

From here you can also check if the `sshd` service is set to start at boot./

### One final tip

If your username has a space inside, put it between single quotes when connecting from your client machines. What's written in Windows login screen aside, username is the one the home dir is named after (e.g. C:\Users\John Doe).

```
ssh 'John Doe'@10.181.22.40
```

Thanks for reading.

