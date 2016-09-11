---
layout: post
title: Installing git from source on Debian and CentOS
categories: ['How-tos']
description: "How to install Git on Debian and CentOS distros and their derivatives"
tags: ['Debian','CentOS','Git']
---

Git is maybe the most used VCS in the world and one of the first things you install on a fresh new server. Package managers are a handy to put new software in but Git version in repositories if often out-to-date. Compiling from source is then a must.

You can find commands below for Debian and Red Hat distro families. Change the version to the one you want to install. Both procedures are patched to avoid git pull errors due to missing SSL support during config. 

#### Debian-based distros

```sh
$ wget ftp://ftp.kernel.org/pub/software/scm/git/git-2.x.y.tar.xz
$ tar -xJf git-2.x.y.tar.xz
$ cd git-2.x.y.tar.xz
$ sudo apt-get install build-essential libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev autoconf
$ make configure
$ ./configure --prefix=/usr --with-gitconfig=/etc/gitconfig
$ make
$ sudo make install
```

#### CentOS 7.x

```sh
$ sudo yum install curl-devel expat-devel gettext-devel openssl-$ devel zlib-devel
$ sudo yum install gcc perl-ExtUtils-MakeMaker
$ sudo yum install wget
$ sudo yum remove git
$ wget https://www.kernel.org/pub/software/scm/git/git-2.x.y.tar.xz
$ tar -xf git-2.x.y.tar.xz 
$ cd git-2.x.y
$ sudo yum install autoconf -y
$ sudo yum install curl-devel -y
$ make configure
$ ./configure --prefix=/usr/local --without-tcltk
$ sudo yum install gettext
$ make all
$ sudo make install
```

#### CentOS 6.x

For CentOS 6.x guidelines, please head over to the great tutorial by [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-git-on-a-centos-6-4-vps).

#### Checking

Either case, verify your installation to be successful:

```sh
git --version 
```


Thanks for reading.
