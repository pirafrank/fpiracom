---
title: "How to fix the 'Needed for This Installer is Missing' during Oracle JDeveloper installation"
subtitle: Troubleshooting the installer error while installing Studio Edition 12.2.1.4
description: Solving 'Needed for This Installer is Missing' error while installing Oracle JDeveloper Studio Edition 12.2.1.4
category: ["How-tos"]
tags: ["Oracle", "Windows"]
seoimage: "3003/files-seo.png"
---

![JDeveloper Studio download files]({{ site.baseurl }}/static/postimages/3003/files.png)

It was long since my last ride with JDeveloper and the experience is even worse. I have stumbled across a weird bug even before installation of Oracle JDeveloper Studio Edition, version 12.2.1.4.0.

### The problem

I am on Windows at the moment, so I’ve tried to install by launching the `.exe` file which, after some unpacking progress, closed without any further explanation.

So I looked at the logs and found this:

```
2023-03-13 14:59:40,669 INFO  [1] com.oracle.cie.nextgen.launcher.LogUtils - Launcher log file is C:\Users\francesco\AppData\Local\Temp\OraInstall2023-03-13_02-59-40PM\launcher2023-03-13_02-59-40PM.log.
2023-03-13 14:59:40,685 INFO  [1] com.oracle.cie.nextgen.launcher.Launcher - Running jar: C:\Users\francesco\AppData\Local\Temp\sfx4229.tmp\Disk1\install\modules\com.oracle.cie.ora-launcher_12.8.4.0.jar
2023-03-13 14:59:40,685 INFO  [1] com.oracle.cie.nextgen.launcher.LogUtils - Extracting the installer . . .
2023-03-13 14:59:40,685 SEVERE [1] com.oracle.cie.nextgen.launcher.Launcher - 
The jar file C:\Users\francesco\Downloads\Oracle_JDeveloper_12c_download\V998593-01-2.zip needed for this installer is missing.
2023-03-13 14:59:41,691 SEVERE [1] com.oracle.cie.nextgen.launcher.Launcher - Self extraction to C:\Users\francesco\AppData\Local\Temp\sfx4229.tmp failed.
2023-03-13 14:59:41,691 INFO  [1] com.oracle.cie.nextgen.launcher.LogUtils - The log is located here: C:\Users\francesco\AppData\Local\Temp\OraInstall2023-03-13_02-59-40PM\launcher2023-03-13_02-59-40PM.log.
2023-03-13 14:59:56,521 INFO  [1] com.oracle.cie.nextgen.launcher.Launcher - Exiting launcher, result: 1
```

which clearly states:

```
The jar file C:\Users\francesco\Downloads\Oracle_JDeveloper_12c_download\V998593-01-2.zip needed for this installer is missing.
```

As it turns out, they misnamed the installation files, so you won’t install them with the same name their downloader saves them.

### The solution

The solution is surprisingly simple.

Close shell and rename `V998594-01.zip` to `V998593-01-2.zip`. Then run the `.exe` file as administrator.

Pretty much the same applies to other platforms: just rename the second, smaller zip file, to the name the installer looks for it. You will find the name in the installation error logs.

I hope it helps. Thanks for reading.
