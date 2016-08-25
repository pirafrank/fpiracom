---
layout: post
title: How to install PHP 5.6 or newer on Raspbian
subtitle: Since no repo has an ARM version of PHP >5.4, compiling and installing by hand it's all we have.
categories: 'Raspberry-Pi'
description: A solution to install PHP >5.4 on your Raspberry Pi
keywords: php,install,raspbian,debian,php 5.6,raspberry,raspberry pi,raspberrypi
tags: ['Raspberry Pi','PHP','Debian']
---

Raspberry Pi is an awesome piece of hardware so you might need PHP on it for whatever kind of project.

Unfortunately the latest PHP version in official repo is (the no longer maintained) 5.4 and third-party repo do not support the ARM architecture. We have only one option left: download source, compile and install.

I've made a script for that and made it available as a gist.

{% gist 2bce62d541af195aaea865d5102f1c09 %}

### How to use the script

```
cd $HOME
wget -O install_php.sh https://gist.githubusercontent.com/pirafrank/2bce62d541af195aaea865d5102f1c09/raw/f8528fc6616663aa443b41059ae91d30794b3094/install_latest_php_raspberrypi.sh
chmod +x install_php.sh
```

Hope it helps!

Thanks for reading.
