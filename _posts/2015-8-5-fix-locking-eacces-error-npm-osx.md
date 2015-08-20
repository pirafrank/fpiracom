---
layout: post
title: Fix 'locking EACCES' error in npm on OS X
categories: node.js
---

You were developing and suddenly got this:

```sh
npm WARN locking Error: EACCES, open '/Users/francesco/.npm/_locks/lodash-df494fd4c4f1a084.lock'
npm WARN locking     at Error (native)
npm WARN locking  /Users/francesco/.npm/_locks/lodash-df494fd4c4f1a084.lock failed { [Error: EACCES, open '/Users/francesco/.npm/_locks/lodash-df494fd4c4f1a084.lock']
npm WARN locking   errno: -13,
npm WARN locking   code: 'EACCES',
npm WARN locking   path: '/Users/francesco/.npm/_locks/lodash-df494fd4c4f1a084.lock' }
npm ERR! Darwin 13.4.0
npm ERR! argv "node" "/usr/local/bin/npm" "install" "lodash"
npm ERR! node v0.12.0
npm ERR! npm  v2.5.1

npm ERR! Attempt to unlock /Users/francesco/npmtest/node_modules/lodash, which hasn't been locked
npm ERR!
npm ERR! If you need help, you may report this error at:
npm ERR!     <http://github.com/npm/npm/issues>

npm ERR! Please include the following file with any support request:
npm ERR!     /Users/francesco/npmtest/npm-debug.log
```

Quick fix? Just run this:

```sh
sudo chmod -R g+w ~/.npm/_locks
```

But this is not be a permanent fix. If it is not related to an issue with a package you're trying to install, it usually happens because npm permissions are messed up. Maybe because you installed node from your system package manager.

**check if you installed them via macports running**

```sh
$ port installed | grep node
$ port installed | grep npm
```

**if that is your case, you need to remove those in first place**

1 - get a list of globally installed node packages

```sh
$ npm -g list --depth=0 > node_installed.txt
```

2 - remove npm and node

```sh
$ sudo port uninstall node@your_version_here
$ sudo port uninstall npm@your_version_here
```

3 - check for node_modules to be deleted

```sh
$ /opt/local/lib/node_modules
```

<del>then download and install npm and node via the official installer from nodejs.org/download.</del>

#### Update

You better follow [this guide]({{ site.baseurl }}/blog/2015/08/node-installation-best-practise/), to get a clean node and npm installation.
