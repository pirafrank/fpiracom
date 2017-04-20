---
title: "Install XML validation tools in Sublime Text 3 on Windows"
subtitle: "A short and quick guide to install Exalt package and companion XML tools on Windows"
description: "A short and quick guide to install Exalt package and companion XML tools on Windows"
category: ['How-tos']
tags: ['Sublime Text','Editor','XML']
---

In many ways a developer comes across XML files, especially when  dealing with SOAP services.

[Exalt](https://packagecontrol.io/packages/Exalt) is an awesome package for Sublime Text 3, my text editor of choice. It offers validation of XSLT files, of XML against an XML Schema (XSD) and more useful features. It can even cache W3C specification documents to speed up validation processes.

Last week I had to figure it how to install it on Windows. It is not an intuitive task to perform compared to the *nix world. So here it is a short guide that may help you.

### Installation

1. Download *libxslt*, *iconv* and *libxml2* from [here](ftp://ftp.zlatkovic.com/libxml/)
2. Extract the files and put the content of `\bin` folder in each zip into `C:\xmltools`
3. Add `C:\xmltools` to PATH environment variable for your user (instead of system, safer)
4. Install Exalt from Package Control on Sublime Text.

That's it.

Thanks for reading.