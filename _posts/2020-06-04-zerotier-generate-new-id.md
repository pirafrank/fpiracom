---
title: "Generate a new device ID in ZeroTier"
description: "Reset ZeroTier client address generating a new one"
categories: ['How-tos']
tags: ['ZeroTier', 'networking']
---

ZeroTier is a great service to connect your VMs, mobile devices, and computers no matter if in cloud, behind a NAT, or on your local home or office network. Without going too much in detail, the client software creates virtual interfaces and lets you join multiple networks (on supported devices) acting *like chat rooms for machines*, as they say on [their website](https://www.zerotier.com/). You can create and manage networks via your account on [my.zerotier.com](https://my.zerotier.com/) and even deploy your own relay servers (*moons*). ZeroTier uses peer-to-peer connections when it is possible for max throughput and minimal latency. Among the other benefits, it is open-source, with clients available for almost every platform, and its connections are end-to-end encrypted.

While it resembles a VPN at first glance, under the hood, each virtual network is much more like a virtual switch your devices are connected to. And each device is recognized on the underlying infrastructure by an ID, which is generated the first time your run zerotier-cli or one of the client apps.

## Resetting the device ID

It may happen you want to regenerate the ID automatically given to your device. I had to spawn a couple of instances out of the same VM snapshot, so I needed a different ID on each of them.

So here it is. Be sure `/usr/sbin` is in `PATH` as `zerotier-cli` is installed there.

```bash
rm /var/lib/zerotier-one/identity.public
rm /var/lib/zerotier-one/identity.secret
systemctl stop zerotier-one.service
systemctl start zerotier-one.service
zerotier-cli join YOURNETWORKID
```

I hope it helps. Thanks for reading.
