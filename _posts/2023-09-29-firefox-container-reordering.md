---
title: "Firefox Containers: How to reorder them"
subtitle: A temporary workaround to rearrange Firefox Containers
description: A temporary workaround to change the order of Firefox Containers in list
category: ["How-tos"]
tags: ["Firefox", "productivity"]
seoimage: "3002/screen.png"
---

![Idea on Mozilla Connect]({{ site.baseurl }}/static/postimages/3002/screen.png)

I've been using Firefox as my preferred browser for a long time, and I find that Firefox Containers extension is a wonderful feature that better integrates into browsing UX flow than profiles do on Google Chrome.

It's been a year since I posted [a feature request](https://connect.mozilla.org/t5/ideas/ability-to-rearrange-firefox-containers-in-manage-containers/idi-p/12447) for Mozilla Firefox on the Mozilla Community forum. I asked for the ability to rearrange list of containers in the Manage Containers menu. I think this would be a great feature to have, and I see I'm not alone by looking at the number of kudos and comments.

I'm glad to see that this post has recently gathered some attention, so it is a good time to further spread my request and offer a temporary solution for those interested. At least until it will gain enough kudos to be satisfied.

### A workaround

Tarang74's shared a workaround on the forum, and I thank him for sharing.

1. Close Firefox
2. Navigate to the following directory: `~\AppData\Roaming\Mozilla\Firefox\Profiles\<profile>.default`
3. Open `containers.json` with your text editor of choice
4. Rearrange the objects so that they are in the order you would like them to appear in Firefox.

Each object will look something like this:

```json
{"userContextId": 1, ..., "name": "Container 1"}
```

### Final words

I look forward to the day when Firefox will implement the ability to rearrange containers in the manage containers menu. Until then, I hope this solution helps.

Thank for reading.
