---
layout: post
title: Node installation best practices
subtitle: or how to avoid post-install headaches by using nvm
categories: ['How-tos']
description: Install node.js via nvm to avoid sudo issues after installation
tags: ['best practices','node.js']
---

Installing node.js can be terrible.

In short:

- if you're going to install it on your development machine, don't use the setup from nodejs.org
- don't install it using your system package manager. Those repo are usually outdated and you may broke your node installation.
- installing on a development machine using one of the methods above, will lead to crazy permissions that will eventually make you crazy, too. See [this]({{ site.baseurl}}/blog/2015/08/fix-locking-eacces-error-npm-osx/) and [this]({{ site.baseurl }}/blog/2015/08/fix-electron-installjs-error-when-root/).

Then, what to do?

### On a development machine

- Install node with NVM (Node Version Manager). 
  - Check the [nvm repo on github](https://github.com/creationix/nvm) and run the install command
  - Install Node.js using
  
  ```sh
  nvm install stable
  ```
  
  - Activate it and set it as default with

  ```sh
  nvm alias default stable
  ```

**Note** that ```nvm use <version>``` is a handy way to set a different node version, but it won't be persistent. To make it so, use ```nvm alias default <version>``` instead.

### On a production machine

- You can install node directly using the website installer, with appropriate permissions.

### More

If you stumble upon 

```text
unknown option '-q'
```

error, please [check this article]({{ site.baseurl }}/blog/2015/07/fix-unknown-option-q-nvm/) to fix it.

Thanks for reading.

---
**Credits**

This blog post takes a lot from [this great reply on stackoverflow](http://stackoverflow.com/questions/16151018/npm-throws-error-without-sudo). Thanks to the author.
