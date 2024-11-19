---
title: "Make Windows Start Menu search faster"
subtitle: "Disabling the default web search makes searching for apps and files a breeze"
description: "Make Start Menu searches faster by disabling web search on Windows 10 and Windows 11"
category: [ "How-tos" ]
tags: [ "Windows" ]
seoimage: "3009/66956-image.png"
---

While scrolling on Threads (admittedly in a prolonged moment of relax), I came across [this post](https://www.threads.net/@thebobpony/post/DB3EvtIuEb_?xmt=AQGz6jxTAfIPbzRMjWU7iwuI8JYl9hvtEB730bJ1GRePTA). Back in my Mac OS X era (yes, that was its name at the time), I fell in love with Alfred - so much so that I still have a [repository of workflows](https://github.com/pirafrank/alfred_workflows) for it. Those times are long gone, though, and I've since migrated to headless setups for my personal dev environment. At work, I've been using Windows machines for quite a while now, with a Dell running Windows 11 (23H2) as my current daily driver. Unfortunately, search from the Start Menu search bar has never been as fast and even if I tried [different](https://learn.microsoft.com/en-us/windows/powertoys/run) [programs](https://www.voidtools.com/downloads/) to improve my search experience, it’s hard to remap muscle memory to something different than the Windows key.

### But why Start Menu search is slow in first place?

In Windows 10, and even more in Windows 11, the Start Menu search not only scans your local indexed files and programs, but also queries Microsoft's services and the web to surface related information, recommendations, and online results. While someone could call it a better search experience, for me the additional API calls and web requests introduce a noticeable and annoying latency, especially on slower internet connections (e.g. mobile hotspot on-the-go) or when the PC run language servers or is busy at compiling. Also, the algorithm behind the search seems to prioritize online resources, often burying the local results you're actually looking for. Local files and programs sometimes get pushed way down the list, or may not show up at all unless you type an exact match, something the defeats the purpose of having fuzzy search and adds to the myth of Windows search being broken. You've probably experienced that frustrating situation where adding a couple more letters completely changes the search results.

### A solution

![Registry script as gist](https://fpira.com/static/postimages/3009/66956-image.png)

So after reading the post, my first thought was about disabling web search from the Start Menu and looking for speed improvements to local search. After some googling, I discovered there were some registry keys (of course) to set. I made [a gist](https://gist.github.com/pirafrank/ae668b702242b2b2ab79a2fc1d072015). Download and run `disable-web-search.reg` and you’re good to go. Run the other file to restore web search back.

Now about… results! Well, it turns out I succeeded. Since disabling web search, the Start Menu does not randomly freeze, and searches are much faster and surprisingly more accurate. Disabling web search forces the algorithm to look for apps and files locally and avoids API calls at every keystroke, reducing latency. At least until some Windows update changes the game again. Until then, I hope it helps.

Thanks for reading.
