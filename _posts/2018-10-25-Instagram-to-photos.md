---
title: Save Instagram pictures to Photos on iOS
description: "A simple Python script to save Instagram pictures on-the-go. It uses Pythonista and (optionally) Apple Shortcuts"
subtitle: "A simple Python script to save Instagram pictures on-the-go. It uses Pythonista and (optionally) Apple Shortcuts"
category: ["How-tos"]
tags: ["iOS","Pythonista","Python"]
---

Instagram iOS app doesn't let you save pictures in the stream to your gallery. But all those paradise beaches and landscapes shared on the social networks would look great as wallpaper on your lockscreen, right?

So I wrote a simple Python script and integrated it with Shortcuts to access it easily. The worflow is shown in the video below.

{% youtube Kfwzcu3ZCVc %}

### The script

1. Install [Pythonista for iOS](https://itunes.apple.com/us/app/pythonista-3/id1085978097?mt=8)
2. Grab the script [here](https://gist.github.com/pirafrank/d5ec45fecdd7b3a124a79110f5e893d4/raw/instagram_download.py) and copy it into Pythonista.

At this point you could run the script straight from the Share extension or from Pythonista itself. The script takes an URL as input and if no one is given, it checks the clipboard. You just need to copy the post URL.

### Shortcuts integration

To speed up all the things, integrate it with Shortcuts (it was still called Workflow when I wrote the script).

1. Get [the app](https://itunes.apple.com/us/app/shortcuts/id915249334?mt=8) 
2. Get [this shortcut](https://www.icloud.com/shortcuts/b7249e67b2e849f49c7d8f1fe9e16980). If you changed the name of the script or its path into Pythonista, edit the shortcut accordingly.
3. Add the shortcut to the ones in the widget.

That's it.

Thanks for reading.