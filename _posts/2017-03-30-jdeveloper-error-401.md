---
title: "Fixing 'Error 401' in JDeveloper integrated servicebus console"
subtitle: "Fixing 'Error 401: Authorization error' when browsing JDeveloper integrated servicebus console locally"
description: "Fixing 'Error 401: Authorization error' when browsing JDeveloper integrated servicebus console locally"
category: ['How-tos']
tags: ['Oracle', 'JDeveloper']
---

Here I am to show you how to fix another issue JDeveloper showed to me.

### Unauthorized?

So, you open JDeveloper integrated servicebus console in the local browser (127.0.0.1:7011/servicebus) and it tells you `Error 401: Authorization Error` even if credentials are correct.

![Error 401 screenshot]({{ site.baseurl }}/static/postimages/2017-03-30/troubleshooting_jdeveloper_p2_error.png)

### The solution

Before we start (change to your version):

- we are using Windows (unfortunately...)
- assume wrong java version is (aka too new): 1.8.0_121
- assume correct java version is (aka 1.7.55+ and < 1.8): 1.7.0_80
- integrated weblogic default domain is in `C:\Users\FRANCE~1\AppData\Roaming\JDeveloper\system12.1.3.0.41.140521.1008\DefaultDomain` (yes, it doesn't live anymore in `C:\Oracle\Middleware\Oracle_Home\user_projects\applications`)
- you know we need to use DOS path names in settings (read more [here](http://www.thinkplexx.com/learn/howto/dos/bat/find-out-dos-path-name-8-character-for-the-directory)).

Let's go:

1. Close JDeveloper
2. Navigate to `C:\Users\FRANCE~1\AppData\Roaming\JDeveloper\system12.1.3.0.41.140521.1008\DefaultDomain\bin`
and replace it `C:\Java\JDK18~1.0_1` with `C:\Java\JDK17~1.0_8`
3. Then, go to `C:\Oracle\Middleware\Oracle_Home\oracle_common\common\bin`
find `jdk1.8.0_121` and replace it with `jdk1.7.0_80`
4. Open JDeveloper and choose **NOT TO** import any previous installation setting/preferences.

Click to *Allow access* if Windows Firewall prompts to give connection permission to Java 1.7.

I hope it helped.

Thanks for reading.