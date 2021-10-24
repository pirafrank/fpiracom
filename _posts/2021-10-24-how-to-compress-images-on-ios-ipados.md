---
title: "How to compress images in bulk on iOS/iPadOS"
subtitle: Compress your images in a shell app
description: "About compressing images in a shell app on iOS and iPadOS"
categories: ['How-tos']
tags: ['Bash','iPad','iOS']
seoimage: 2021-10-24/ipad_images_unsplash.jpg
---

Earlier this year I have shared a tweet about compressing images on iOS and iPadOS using a shell app. The tweet has received a fair amount of interest so far and to further help people looking for the matter, I have decided to write a short blog post about it.

https://twitter.com/pirafrank/status/1353708824558002177

It’s worth pointing out that there are a couple of other ways to do that. Images can be compressed using the pre-installed Shortcuts app, as pointed out in the [tweet thread](https://twitter.com/jankais3r/status/1361216475466522626?s=21), or by using an [online service](https://www.google.it/search?q=compress+images+online&ie=UTF-8&oe=UTF-8&hl=it-it&client=safari). By the way, a shell approach may be helpful to reuse a script you already have, do some batch processing and protect your privacy (you don’t need to upload pictures anywhere).

### Prerequisites:

1. Download the [@iSH_app](https://twitter.com/iSH_app)
2. add Alpine repositories ([link](https://github.com/ish-app/ish/wiki/Using-Alpine-Linux-repositories))

and install the ImageMagick package:

`apk add imagemagick`

### *mount* and *convert*!

Time to convert. But before I show you how to mount an external path, thanks to the awesome iSH app. It is a good option to read/write images straight where you need them. For example, you could use it with apps such as [Secure ShellFish](https://apps.apple.com/it/app/secure-shellfish-ssh-sftp/id1336634154) or [FileBrowser Pro](https://apps.apple.com/it/app/filebrowser-professional/id854618029). In the example below, I use iCloud Drive which we all have:

1. `mkdir -p /mnt/icloud_drive`
2. `mount -t ios . /mnt/icloud_drive`
3. `cd /mnt/icloud_drive`

Since ImageMagick is now installed, we can use the same commands and options we are used to:

`convert -format "jpg" -quality "75" old.jpg new.jpg`

That’s it!

Thanks for reading. Hope it helps!
