---
title: How to disable duplicated sent emails in Zoho
subtitle: "Zoho server may duplicate emails in the 'Sent' folder. This is how to disable this behaviour."
description: "Zoho server may duplicate emails in the 'Sent' folder. This is how to disable this behaviour."
category: ["How-tos"]
tags: ["email"]
---

If you have experienced finding duplicate emails in your *Sent* folder on the Web client of your Zoho email account, don't worry as this has been a widespread issue. It turns out that Zoho places (by default) a copy of any outgoing email in the *Sent* folder. If your IMAP client does the same, you'll end up with duplicated emails.

While it is possible to disable this behavior client-side, it isn't always the best option. For example, the email client may miss this particular feature or, if you have an iOS device, keeping the *Sent* email folder locally doesn't enable you to see the folder on the server, preventing you to search for emails sent from other devices.

### The solution

The solution is as simple as toggling a flag, which is hidden in the web GUI of Zoho email settings. Just follow the steps below.

1. Login to your [Zoho Email Account](https://mail.zoho.com). Be sure you're using the new UI.
2. Click on the *cog* icon in the upper right corner
3. Scroll down to *Mail accounts* box then click *View*
4. Now click *SMTP* and untoggle *Save copy of sent emails*

That's it. Now future emails you'll send shouldn't be duplicated anymore. Remember also to set the IMAP clients to save a copy on the server.

Hope it helps. Thanks for reading.
