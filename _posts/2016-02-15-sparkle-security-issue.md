---
layout: post
title: Sparkle vulnerability and list of safe apps (Updated!)
categories: ['Posts']
description: List of OS X apps with addressed Sparkle man-in-the-middle vulnerability
tags: ['Security','macOS']
last_edit_at: 2016-02-19
---

Many OS X apps use [Sparkle](https://sparkle-project.org/) as update library.

Recently a vulnerability in the software has been discovered. Affected apps are those using a vulnerable version of Sparkle on an unencrypted HTTP connection to receive data from their update servers. Those apps are subject to man-in-the-middle attacks that could install malicious code. 

You can read more about this security issue on [ArsTecnica](https://arstechnica.com/security/2016/02/huge-number-of-mac-apps-vulnerable-to-hijacking-and-a-fix-is-elusive/).

### List of safe apps (Updated!)

In alphabetical order, the minimum safe versions of apps using Sparkle.

**App name / Safe since / Notes**

- CodeKit 1.7.1, [prior releases should be unaffected](https://incident57.com/codekit/versionhistory.html)
- Dash 3.2.2
- iTerm 2.1.4 and 2.9
- SourceTree 2.2
- Spectacle 1.0.2
- VLC 2.2.2

*Post constantly updated as I discover new safe versions.*

- - -

Related links

- https://github.com/sparkle-project/Sparkle/issues/717
