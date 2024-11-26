---
title: Run two instances of Microsoft Teams desktop app on Windows 10
subtitle: A simple workaround to work with multiple accounts on desktop
description: How to run two Microsoft Teams desktop apps on Windows 10 and work with multiple accounts
categories: ['How-tos']
tags: ['Windows','Windows 10']
seoimage: 2021-11-29/teams.png
---

### Update (November 26, 2024)

The procedure described in this blog post is no longer applicable to recent versions of Microsoft Teams, referred to as "New." In 2024, Microsoft transitioned users to this updated version. The procedure is now unnecessary because the new Teams provides native support for managing multiple accounts and organizations within the same account. To switch between them, simply click on your profile picture. Additionally, a new icon featuring a user and a bell and located in the top-right corner of the app, helps you stay in the loop by displaying notifications across all the organizations you've signed into.

The original post follows.

---

{% include image.html url="/static/postimages/2021-11-29/teams.png" desc="Two Microsoft Teams instances
running on Windows 10" %}

Since the pandemic, Microsoft Teams has been the central hub of work communication for me. But not only me, other companies and clients we work with have adopted it as their go-to tool. They have their own organizations and sometimes we get (and have to use) an account there to comply to their policies.

This means choosing between my organization or the customer one because Teams on desktop apps doesn't supports multiple work accounts. I know I can run it in the browser and use [Firefox containers](https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/) or [Ghost Browser](https://ghostbrowser.com/) to login to more organizations in parallel but although it's based on Electron and thus web technologies, Microsoft Teams works better (*better*, not *good*) on desktop than it does on browser. It's still an heavy application, and even Microsoft [acknowledges that](https://docs.microsoft.com/en-us/microsoftteams/teams-memory-usage-perf). So I've started looking for ways to run multiple desktop instances of Teams side-by-side on my work OS, which is Windows 10.

Googling around I have come across [a post](https://techcommunity.microsoft.com/t5/microsoft-teams/solution-microsoft-teams-multiple-accounts-second-account/m-p/548309) published on the Microsoft's Tech Community which adopted a clever solution: given you're the administrator of your PC, run another Teams instance as another (Windows) local user.

Theorically, you could run more instances than two: just keep creating local users!

The post even suggests a PowerShell script to automate the step required to run the other instance every time. I made a slight modified version to ask the user for password via a secure input, instead of having it written in plain in the script body.

I've tested it on Windows 10 21H1 and it looks like it works well enough. Here's it.

{% gist 40880dbc3e2dcfbdc1dd817b8880fa66 %}

I hope it helps. Thanks for reading.
