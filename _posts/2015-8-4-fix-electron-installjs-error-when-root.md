---
layout: post
title: Fix electron-prebuilt install.js script error when installing as superuser
categories: 'Web-Dev'
description: How to fix install.js script error when installing electron-prebuilt as superuser
tags: ['electron','node.js']
---

Playing with electron, actually upgrading it, I've stumbled across this error:

```sh
francesco@Golden-Hind:~$ sudo npm i -g electron-prebuilt@0.30.3
/usr/local/bin/electron -> /usr/local/lib/node_modules/electron-prebuilt/cli.js

> electron-prebuilt@0.30.3 postinstall /usr/local/lib/node_modules/electron-prebuilt
> node install.js

Downloading electron-v0.30.3-darwin-x64.zip
[============================================>] 100.0% of 37.13 MB (1.75 MB/s)
/usr/local/lib/node_modules/electron-prebuilt/install.js:15
  throw err
        ^
Error: EACCES, rename '/usr/local/lib/node_modules/electron-prebuilt/electron-tmp-download/electron-v0.30.3-darwin-x64.zip'
    at Error (native)
npm ERR! Darwin 14.4.0
npm ERR! argv "node" "/usr/local/bin/npm" "i" "-g" "electron-prebuilt@0.30.3"
npm ERR! node v0.12.7
npm ERR! npm  v2.11.3
npm ERR! code ELIFECYCLE

npm ERR! electron-prebuilt@0.30.3 postinstall: `node install.js`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the electron-prebuilt@0.30.3 postinstall script 'node install.js'.
npm ERR! This is most likely a problem with the electron-prebuilt package,
npm ERR! not with npm itself.
npm ERR! Tell the author that this fails on your system:
npm ERR!     node install.js
npm ERR! You can get their info via:
npm ERR!     npm owner ls electron-prebuilt
npm ERR! There is likely additional logging output above.

npm ERR! Please include the following file with any support request:
npm ERR!     /Users/francesco/npm-debug.log

```

Interestingly enough, this issue is kind of random. It appeared in version 0.25.3-2 and it still randomly occurs even if fixed. What's more, it occurs only on OS X.

### The quick fix

The electron install.js script has an issue with permissions on ```~/.electron``` dir, which it uses as temp path to unpack install files.

```
chmod 777 ~/.electron
```
fixed the issue.

### Update

The best solution is different, though. Please check this post of mine about [best practice to install node on your computer]({{ site.baseurl }}/blog/2015/08/node-installation-best-practise/)

[Check this issue on Github](https://github.com/atom/electron/issues/1709) to know more about this.

Thanks for reading.
