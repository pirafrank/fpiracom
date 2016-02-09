---
layout: post
title: My 2-cents Guide For A Safe Upgrade To El Capitan
categories: osx
description: An outline about a good way to upgrade your OS X installation to El Capitan safely
keywords: upgrade,el capitan,osx,OS X, guide
---

Let's face it, you're a developer and you're jealous of your dev environment on your shiny Mac. But you're also a geek and you want to use the under-the-hood enhancements of OS X El Capitan.
Here's a guide I've written for myself for a smooth upgrade process. I have used it in the past for upgrading from Mavericks to Yosemite and then to El Capitan. Now I want to share it with you.

### Before we start

How much does it takes? It took 2 hours for me to check all apps to be compatible and upgrade some of them. All the process may take half a day, that's why I did on weekend. The upgrade itself is just about 30 minutes.

### Cleaning up...

You want a shiny upgrade, don't you?

- Remove unneeded apps and clean hard drive from useless files
- Start downloading El Capitan from the App Store (it may take awhile)

### Prepare

- check all installed applications to be compatible ([this is a handy website to do that](http://roaringapps.com/apps:table))

- check all the installed software to be compatible and to support the upgrade without any special procedure (if any, do it!)

- update all apps (xcode included)

- install all system updates

- check all files to be synced to the cloud

- make a time machine backup (write it down: it will be the latest with the old OS)

- handling Macports (skip it if you don't have)

    - export installed ports (for later restoring): ``` port installed -qv requested > ~/Desktop/my_requested_ports.txt ```

    - export requested ports (useful to keep your installation lean later): ``` port installed requested > ~/Desktop/my_requested_ports.txt ```

    - uninstall all ports ([you can follow this guide for migration](https://trac.macports.org/wiki/Migration))

- detach external drives and peripherals

- verify os x partition and repair it if necessary

- verify os x permissions and repair it if necessary

- remove EFI password (you'll be able to restore it later)*

- plug your Mac to the wall (in case it's a MacBook) and... update!

(*) this may be an unneeded step, but in the past some reboots stumbled across that password. You now, better safe than sorry!

**Note** Don't worry about Filevault 2 to be enabled. The installation setup will take care of it and will upgrade without need to decrypt the startup volume.

Go grab some food. It will take awhile to install the new OS. Mine took about 30 mins on an encrypted Filevault2 volume.

### After upgrade

- Login and shutdown to boot to the recovery. There you can verify the startup disk using the 'First Aid' option in the new (ugly) Disk Utility.

- Restore your EFI password (if you used to have)

- make a time machine backup

- restoring macports (if you had)

    - open Xcode and let it install tools on first run

    - run ``` xcode-select --install ``` and install Command Line Tools

    - run ``` xcodebuild -license ``` and accept the license typing ```agree```

    - install macports for El Capitan ([download](https://www.macports.org/install.php))

    - restore previous ports following the migration guide above (really easy!)

- fix apache ([here's how]({{ site.baseurl }}/blog/2015/10/restore-old-apache-conf-after-osx-upgrade/)) and any other broken things (like installing [Apple's version of Java 6](https://support.apple.com/kb/DL1824) to make Android Studio, [Matlab 2013a](http://www.mathworks.com/matlabcentral/answers/246135-is-matlab-compatible-with-mac-os-x-10-11-el-capitan) and other software work again)

- buy and install tuxera 2015.02 (If you used to had like me. It will overwrite any previous install)

- once you fixed everything, make another time machine backup and take note of it. It will be a useful base for any future restore.

- done!

Thanks for reading.
