---
title: "JDeveloper and forgotten Integrated WebLogic credentials"
subtitle: Short guide on how to regain access to your Integrated WebLogic server
description: Short guide on how to regain access to your Integrated WebLogic server
category: ['How-tos']
tags: ['Oracle', 'JDeveloper']
---

Credentials of the Integrated WebLogic instance in JDeveloper are set during first config. If you have a dev server where you deploy your configurations, you may not to use the integrated server for a long time and forget its credentials. 

How to regain access if your forgot them?

### Resetting the IntegratedWebLogic server

1. Stop the Integrated WebLogic server and close JDeveloper
2. Delete/rename the *DefaultDomain* instance in userdata. **DO NOT** delete the whole *JDeveloper* dir, just the subdir of the integrated server.

E.g. Go to %APPDATA% > JDeveloper and delete/rename just *systemYOURVERSION*.

The above applies to Windows since my work environments requires it, but the approach is similar on *nix machines.

3. Open JDeveloper. Your integrated webserver instance will be recreated from scratch at next run. Beware it will take a longer time than your previous launches.

I hope it helped.

Thanks for reading.