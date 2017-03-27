---
title: "Troubleshooting JDeveloper"
subtitle: "Fixing 'Error: Unable to load class' in path with space characters"
description: "Fixing 'Error: Unable to load class' in path with space characters"
category: ['How-tos']
tags: ['Oracle', 'JDeveloper']
---

This post applies to JDeveloper installation on Windows.

### Error: Unable to load class in ...

Right after a fresh installation of JDeveloper on Windows, you may start the Integrated WebLogic server and stumble upon this error:

`Unable to locate class in Pira\AppData\Roaming\JDeveloper\...`

As it turns out, Java can't load classes in paths with space characters within.

### The solution

In order to fix this, you have to replace all the occurrences of the directory with the space character (likely your user home dir) with its DOS name in all Integrated WebLogic configuration files, which live in.

```C:\Users\USERNAME\AppData\Roaming\JDeveloper\systemYOURVERSION\DefaultDomain\bin```

Tip: You better use *Find and replace* in folder with a smart text editor like Sublime Text.

### An example

Let's take my first and last names: `Francesco Pira`. If my local account is named after that, my JDeveloper Integrated WebLogic instance files sit in `C:\Users\Francesco Pira\AppData\Roaming\JDeveloper\`. So I've replaced all occurences of `Francesco Pira` to `FRANCE~1` in

```C:\Users\Francesco Pira\AppData\Roaming\JDeveloper\system12.1.3.0.41.140521.1008\DefaultDomain\bin```

I hope it helped.

Thanks for reading.

