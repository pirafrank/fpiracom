---
title: Add Azure DevOps as a hosting provider in Working Copy
subtitle: "It speeds up how you list and clone your repositories on the Microsoft code hosting platform"
description: "It speeds up how you list and clone your repositories on the Microsoft code hosting platform"
category: ["How-tos"]
tags: ["iOS","Git"]
---

[Working Copy](https://workingcopyapp.com) is *THE* git client for iOS. It packs a lot of awesome features. Adding a new hosting provider is among these, so you can easily access GitHub, BitBucket and more via their REST API and list your hosted repositories in one tap.

Although GitHub, BitBucket and GitLab are already available as presets, [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/) (previously knows as Visual Studio Team Service, or VSTS) is not. 

Below there's a quick guide to set up it.

### Configure it

1. Open Working Copy on iOS, go to `Settings > Hosting Providers` and press the `+` button in the upper right corner
2. Check your `USERNAME`. It is the name of the organization handling the repos you want to clone. On Azure DevOps you can have multiple organizations tied to same account/email address. You can find a list of them right after logging in.
3. Fill the fields as below:
    1. **URL** : https://*USERNAME*.visualstudio.com/
    2. **Name** : *your choice*. This is how it will be displayed in the app.
    3. **SSH transfers** : `off` if you want to transfer them via HTTPS, otherwise turn in `on`, but you'll need to add Working Copy ssh public key to your account.
    4. **Enable provider** : yes
4. Go to `https://USERNAME.visualstudio.com/_usersSettings/tokens` and generate a token. Only the *Code* capabilities are needed to make it work. Other capabilities offer access to other DevOps features, such as pipelines, etc. Now if you have universal clipboard enabled, you can just visit the website on you Mac and copy the token from there.
5. Back to the mobile app, tap `Test` and fill in your *USERNAME* and token. 

![Hosting providers screenshot]({{ site.baseurl }}/static/postimages/2018-10-21/001.png)

That's it.

### Cloning a repo

Now it's time to clone a repo. Since we have configured the organization, we can do it in three taps:

1. On the main screen of Working Copy, tap the `+` button in the upper right corner
2. In the new screen, select `Azure DevOps` as provider
3. Now tap the repo you want to clone. Done.

Hope it helps. Thanks for reading.