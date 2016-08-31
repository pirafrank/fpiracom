---
layout: post
title: Azure, add a new drive to a Linux VM
subtitle: A beginner guide to attach a new virtual drive to a Linux virtual machine
categories: ['Tutorials']
description: A beginner guide to attach a new virtual drive to a Linux virtual machine
tags: ['Sys Admin','Cloud','Microsoft Azure']
---

Microsoft Azure is here and we want to deploy lots of virtual machines and attach them even more drives.

First, we need to attach a new drive. Go to [portal.azure.com](http://portal.azure.com), then look for your virtual machine of choice in the *Virtual Machines* menu.

Then *Settings* > *Disks* > *Attach new*. Now choose a nice name (it will be seen only in the portal, btw) and the desired virtual drive dimension. As a side note, Azure pricing is currently set to count only data actually written to disk, not the dimension of the whole disk.

![Attach Disk to VM]({{ site.baseurl }}/static/postimages/2016-01-08/001.jpg)

After the success notification, the disk is attached to the VM. Unfortunately, unlikely Amazon EC2, Azure deploys new hard drives as blobs in raw format (nothing on the virtual disk, even the partition table!). So set it ready.

Now login as root via SSH and get the list of the current partitions:

```sh
# parted -l
```

Open parted on the new disk

```sh
# parted -a optimal /dev/sdX
```

Create a new partition table

```sh
(parted) mklabel msdos
```

Partition the disk. We will create just one partition that will fill the entire disk. To make it easy to use and remember, we're using percentage option in place of sector numbers.

```sh
(parted) mkpart primary ext4 0% 100%
```

Format the partition using ```mkfs```, as it is more reliable than the formatting tool embedded in ```parted```. Ext4 is a good filesystem to use, the default in Linux. There are other filesystems and this option can be tuned for particular purposes, but that's a topic for another tutorial.

```sh
# mkfs.ext4 /dev/sdX1
```

Now you should be able to see the newly created partition using parted list option.

```sh
# parted -l
```

Create a mount point for the new drive. We'll set it as the default mount point a boot in a few steps.
The ```-p``` option creates a new folder, including the necessary subfolders for the given path.

You can choose any folder as mountpoint, but usually in Linux new drives are mounted in ```/media```.

```sh
# mkdir -p /media/newhdd
```

*Note that ```/mnt``` is the mount point for the cache SSD used by Azure and automatically attached to your virtual machine*

Get the UUID for the new filesystem...

```sh
# blkid
```

...so we can use it to add a new entry in fstab for auto-mounting at boot.

First open fstab

```sh
# nano /etc/fstab
```

then add a line like the one below at the bottom of the file (remember to always leave a line before the very end of the file).

```sh
UUID=your-uuid-here      /your/mountpoint ext4   defaults   0 2
```

- *UUID*: the number you got it steps before;

- */path*: your mountpoint of choice;

- *ext4*: this needs to match the filesystem you formatted the partition to;

- *defaults*: to mount using defaults options, which are rw, suid, dev, exec, auto, nouser and async;

- *0*: dump option for the partition. Very rarely set to 1;

- *2*: tells the operating system to check the partition after the root one at boot time. We do care about data integrity, so it's good to enable this check. **Important: option 1 should be used only by root partition!**

For example:

```sh
UUID=22e9bb5e-0178-7sde-a181-40a12e9a7fwa   /media/newhdd ext4   defaults   0 2
```

Done!

Thanks for reading.
