---
layout: post
title: "This is how Windows 10 messed up GRUB"
subtitle: "...or how to complete the upgrade to Windows 10 if you have dual-boot"
description: "Resolve Windows 10 installation error due to GRUB and complete the installation"
categories: ['How-tos']
tags: ['GRUB','Windows']
---

A few weeks ago Windows 10 build 1609 was out. For me, it was nothing to be exited about but a new browser to test my websites on.

### Upgrading to Windows 10 on a dual-boot machine

Unfortunately yesterday the Linux installation on my netbook, which I use for less important tasks, left me with a bunch of error screens. Then I've just booted to Windows 7 to finish my work when the idea of installing Windows 10 came to mind. So I've downloaded the ISO from my BizSpark account and put it on a USB drive.

It took a while on that little Atom N550-powered computer for the first restart to happen. But after that, GRUB (the Linux dual-boot menu) has KO. An error message told me it was missing.

### Sorting out the issue

If you're in the same situation, don't worry, your Windows 10 installation process is still safe.

1. Turn the computer off

2. Get a Windows media installation (Windows 7 or above) and boot from it

3. Choose your default *Language*, *Time* and *Keyboard Input* on the first window and click next

4. You're now presented with 3 choices. Click on *Repair Your Computer*

5. Choose *Windows 10* as installation

6. Select *Command Prompt*

7. Run `bootsect /nt60 C: /force /mbr`

8. Reboot and remove the installation media

Your Windows 10 should continue the installation from where it was stopped.

Thanks for reading.

