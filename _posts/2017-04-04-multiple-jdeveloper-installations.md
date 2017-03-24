---
title: Installing different versions of JDeveloper side by side
subtitle: There are many reasons for your to have multiple instances of installed on your computer
description: There are many reasons for your to have multiple JDeveloper versions of installed on your computer
category: ['How-tos']
tags: ['Oracle', 'JDeveloper']
---

Let's assume you want different JDeveloper versions using different JDK versions installed side by side on your dev environment. This how-to is about Windows but you can easily apply the steps to other operating systems, too.

### Different JDKs

JDeveloper 12.1.3 and 12.2.1.2.0 may use different JDK versions. Indeed the following matrix applies:

| JDeveloper | min JDK version | max JDK version |
|---|---|---|
| 12.1.3 | 1.7.55 | 1.7.80 (*) |
| 12.2.1.2.0 | 1.8 | 1.9 |

(*) Integrated WebLogic running on JDK 1.8 causes issues, like [this]({{site.baseurl}}/blog/2017/03/jdeveloper-error-401/).

### Installing JDeveloper 12.2.1.2.0 side by side 12.1.3

1. Install JDK 1.7 in some path **without** space characters within (like `C:\Java7`)
2. Set **system** (not user) env vars for it
3. Install JDeveloper 12.1.3 in a custom path **without** space characters within (like `C:\Oracle1213`)
4. Open JDeveloper 12.1.3 and **do not** set to associate any file format to it.

5. Install JDK 1.8 in some path **without** space characters within (like `C:\Java8`)
6. Set **system** env vars for it (thus replacing 1.7)
7. Install JDeveloper 12.2.1.2.0 in a custom path **without** space characters within (like `C:\Oracle122120`)
8. Open JDeveloper 12.2.1.2.0 and **do not** set to associate any file format to it.

I hope it helped.

Thanks for reading.