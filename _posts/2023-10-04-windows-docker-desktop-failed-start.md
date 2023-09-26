---
title: "No need to reboot to fix 'Docker Desktop has failed to start' error"
subtitle: If you cannot restart your computer, you still have a way out. Tested on Windows 10.
description: "Fixing 'Docker Desktop has failed to start' error on Windows without rebooting Tested on Windows 10."
category: ["How-tos"]
tags: ["Docker", "Windows", "Windows 10"]
seoimage: "3004/stop.jpg"
---

![Stop sign photo by Johann Van Der Linde]({{ site.baseurl }}/static/postimages/3004/stop.jpg)

Sometimes, likewise after a Docker Desktop update, Docker may not be able to start and you could read a `Docker has failed to start` message. A reboot is (almost) always a working solution, yet not the best option in many cases. But what if you are in the middle of your workflow, can’t close everything and can’t reboot?

### Background

The Docker Desktop app is what runs the tray icon. Docker works with WSL and uses a Windows Service to handle things under the hood and let the Docker Desktop application talk with the underlying Docker in WSL. If things broke a reboot may help, but there is no an actual need for it.

### Solution

This has been tested on Windows 10. It might also work on Windows 11. If you find it to be, please reach out to me, so that I can update this post accordingly.

1\. Quit docker desktop

2\. In PowerShell Admin, stop WSL:

```
wsl --shutdown
```

3\. Restart the Docker Desktop Service by going to:

```
Start menu > Services
```

as shown in the screenshot below.

![Docker Desktop Service]({{ site.baseurl }}/static/postimages/3004/service.png)

4\. In PowerShell Admin, start WSL:

```
wsl
```

5\. Now open the Docker Desktop app.

It should now work again. And you can start your stopped containers.

I hope it helps. Thanks for reading.
