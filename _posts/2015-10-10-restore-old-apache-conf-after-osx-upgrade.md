---
layout: post
title: Restore your (good) old Apache configuration after upgrading to El Capitan
categories: osx
---

Since Mavericks, upgrading to a new major version of OS X restores the Apache settings to default. Luckily enough the setup backups the old configuration. Here's what I did to put it back.

It will take about 2 minutes.

1. I checked my apache user conf file to be in path (/etc/apache2/users/francesco.conf)

2. backed-up default elcapitan apache conf file (sudo cp httpd.conf httpd.conf.original.elcapitan)

3. removed default confif (sudo rm httpd.conf) and placed old custom one (sudo cp httpd.conf.pre-update httpd.conf)

4. tested the old config to be workind (apachectl configtest)

5. restarted apache (sudo apachectl restart)

6. tested php to be working with a simple php.info file

7. tested phpmyadmin and mysql to be working by logging into phpmyadmin (mysql needs to be stared from its panel in System Preferences)