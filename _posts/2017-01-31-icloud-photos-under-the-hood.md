---
layout: post
title: iCloud Photo Library under the hood
subtitle: Undocumented facts in Apple's photo management technology
categories: ['Articles']
description: Undocumented facts in Apple's photo management technology
tags: ['macOS','cloud','iOS']
---

After some fiddling with Apple's photo management technology I've found some undocumented but interesting things.

![Show Package Content]({{ site.baseurl }}/static/postimages/2017-01-31/001.png)

### The setup

- Dual-core Haswell MacBook Pro with 16GB RAM
- macOS 10.12.2
- iOS 10.2
- 5.07 minutes video I took (in portrait)
- Handbrake 1.0.2
- `mediainfo` tool

3 files:

- the original video (591.8 MB)
- the one I've exported from Photos app (407.4 MB) by dran-n-dropping it to Desktop after waiting for iCloud sync to complete
- the one I've shrunk using Handbrake (153.6 MB) with the following options:
  - format: MP4, Web optimized
  - video: x264, FPS same as source, Costant quality (RF: 22)
  - audio: AAC PassThru (read 'copy from source')
  - picture: `607x1080`, down from `1080x1920`, no visual difference to me. Leaving it the same would output a file twice as bigger (285.5 MB)

### Encoding

**Photos app export**

- Duration: 3 minutes 5 sec
- CPU usage: 40% (average)
- Fan: at minimum
- Process name: com.apple.photos.VideoConversionService

**Handbrake**

- Duration: 10 minutes 20 sec
- CPU usage: 100%
- Fan: at maximum

### The output

![File sizes]({{ site.baseurl }}/static/postimages/2017-01-31/002.png)

#### Video details

**Original video meta**

I've hidden geolocation info for privacy reasons.

```
Format                                   : MPEG-4
Format profile                           : QuickTime
Codec ID                                 : qt
File size                                : 564 MiB
Duration                                 : 5mn 7s
Overall bit rate mode                    : Variable
Overall bit rate                         : 15.4 Mbps
Writing library                          : Apple QuickTime
com.apple.quicktime.location.ISO6709     : +37.****+015.****+033.***/
com.apple.quicktime.make                 : Apple
com.apple.quicktime.model                : iPhone 6
com.apple.quicktime.software             : 10.2
com.apple.quicktime.creationdate         : 2017-01-21T21:10:34+0100
```

**Exported video meta (Photos app)**

Resolution was the same as the original.

```
Format                                   : MPEG-4
Format profile                           : QuickTime
Codec ID                                 : qt
File size                                : 389 MiB
Duration                                 : 5mn 7s
Overall bit rate mode                    : Variable
Overall bit rate                         : 10.6 Mbps
Writing library                          : Apple QuickTime
com.apple.quicktime.make                 : Apple
com.apple.quicktime.model                : iPhone 6
com.apple.quicktime.software             : 10.2
com.apple.quicktime.creationdate         : 2017-01-21T21:10:34+0100
```

**Handbrake-encoded video meta**

```
Format                                   : MPEG-4
Format profile                           : Base Media / Version 2
Codec ID                                 : mp42
File size                                : 146 MiB
Duration                                 : 5mn 7s
Overall bit rate mode                    : Variable
Overall bit rate                         : 3 990 Kbps
Writing application                      : HandBrake 1.0.2 2017012200
```

### What can we learn?

- A video shot using an iOS devices uses:
  - MPEG4 as container
  - AVC as video codec, variable bit rate and 8 bit depth
  - AAC as audio codec, variable bit rate and 44.1 KHz sampling rate, mono
  - and it carries the `QuickTime`profile ID
- iCloud Photo Library stores originals to the cloud. I've found this by comparing MD5 hashes of the original file on phone and of the Photo Library file
- iCloud Photo Library on macOS stores files by default in `~/Pictures/Photos Library`. You can change this in app preferences.
- macOS Photos app does not rename files locally if *Download Originals* is enabled. It also keeps files organised in subfolders into the *Photos Library* bundle. The folder structure is `Photos Library > Masters > YYYY > MM > DD > YYYYMMDD-hhmmss`, where date and time are those read from file date modified. Just change that using `touch` before importing a photo to import it in the desired place in the timeline
- On iOS Photos app if *Optimized storage* is turned on filenames are UUID4 name, instead.
- The *Optimized Storage* option does not download locally a new (heavy?) video uploaded from another device until you open it or browse pictures of the same day on that device
- AirDrop actually sends the original file to iOS and Mac computers. The file keeps meta and all. They have the same MD5
- Exporting the original video out of the Photos app on Mac (say to Desktop) using dran-n-drop actually shrinks the video and removes location meta tag (see details above). The same applies doing *Files > Export > Export*. The visual quality of the video is the same and only the video stream is reduced in size as the audio one is kept the same. You have to use *Files > Export > Export Unmodified Original* to get the untouched video. Also, this is much faster as there's no transcoding.
- Using Handbrake I was able to shrink the exported video:
  - to 218.1 MB setting RF:20, 64% smaller than the original video
  - to 153.6 MB setting RF:22, 74% smaller than the original video
- `exiftool` cannot edit QuickTime meta. You can import the file and fix recorded location and time going to *Option-click > Get Info* and double clicking. Only meta (not the file) will be uploaded as those are kept in a separate database and not merged back into the file. For this reason exporting the file doesn't export the meta you set
- Editing meta of video/picture does not move it to the corresponding subfolder into the Photos Library bundle

#### What about pictures?

The results follow the same principles:

- iCloud Photo Library stores the original photos.
- by simply exporting from Photos app you get the original pictures, thus *Export Untouched* option here is useful only when you want to get the original shot without any adjustment you made in the app (e.g. rotation, filters, etc.)
- Editing meta doesn't upload
- Editing a picture does not re-upload it but just syncs the edit.

### Some tips

#### Saving space

To save precious space on iCloud and on device (at least until the *Optimized Storage* setting deletes it on your iPhone you can:

- simple way: on your device go to *Settings > Photos* and set quality to *720p 30fps*
- hard way: keep the *1080p 30 fps* setting on device, shrink it using Handbrake, then replacing the file. This is more time consuming and forces you to go back to your Mac from time to time. Note that there's room for automation here (with the usual suspects: Finder Folder Actions, Automator, shell scripting and maybe [Hazel](https://www.noodlesoft.com))

#### Advanced photo management on iOS

After a long search, those are great apps with the best integration. Totally worth their money.

- [Exif Viewer](https://itunes.apple.com/us/app/exif-viewer/id562827354?mt=8) to read EXIF data without leaving the Photos app. It also does not import (read duplicate) pictures into its app container thus eating precious storage space
- [Pixelmator](https://itunes.apple.com/it/app/pixelmator/id924695435?mt=8) is the real Photoshop on iOS and sports tons of edit tools and a cool feature: if you import a picture and edit it, saving it back to photo library replaces the original by adding a new version instead of overwriting. Want to go back? Open Photos, select the picture, then tap the edit button and ta-da you have the *Restore* option even if you haven't edited it via the built-in Photos app.

I hope you've found this interesting. Thanks for reading.
