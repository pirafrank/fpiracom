---
title: "Docker Desktop's Compose Plugin Bug: A Quick Fix for Windows 11 Users"
subtitle: Upgrading Docker Compose plugin on Docker for Windows and WSL2
description: "How to upgrade Docker Compose plugin on Docker for Windows and WSL2"
category: [ "How-tos" ]
tags: [ "Windows", "Docker", "WSL" ]
seoimage: "3010/15610-screenshot_768.png"
updates:
  - date: 2024-11-20
    content: "Docker Desktop `4.36` has just been released ([notes here](https://docs.docker.com/desktop/release-notes/#4360)) and it ships with `docker-compose` version `2.30.3`. Original post follows."
---

Like many developers working on Windows 11, I rely on Docker Desktop with WSL2 integration for running containers, a setup that has proven both reliable and efficient. However, after upgrading to Docker Desktop 4.35.1, I encountered an unexpected issue: the "_unexpected character '-' in variable name_" error in the docker-compose plugin.

This bug, which first appeared in Docker Desktop 4.35.0, affects the bundled docker-compose plugin. It's currently being tracked as issue [#14395](https://github.com/docker/for-win/issues/14395) for Docker Desktop on Windows. While the issue [has already been resolved](https://github.com/docker/compose/issues/12240) in the docker-compose source code with version `2.30.3`, this fix isn't yet available via Docker Desktop's regular update channel. The complete resolution will ship with Docker Desktop `4.36`.

For those who need an immediate solution, I'll show you how to manually update just the `docker-compose` plugin without waiting for the next Docker Desktop release. The fix is is two parts: we have to both update `docker-compose` on Windows and on the default WSL2 distro we use, if any. In my case it is an Ubuntu 22.04.

### Windows

![docker compose version executed on windows](https://fpira.com/static/postimages/3010/15610-screenshot_768.png)

1. In PowerShell, check the current Compose version with `docker compose version`
2. Run the commands below:

```powershell
cd $env:USERPROFILE\.docker\cli-plugins
mv docker-compose.exe docker-compose.exe.old
Invoke-WebRequest -Uri "https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-windows-x86_64.exe" -OutFile "docker-compose.exe"
```

3. Rename `docker-compose.exe` symlink to `docker-compose.exe.old`
4. Download the updated exe to put it in the folder as `docker-compose.exe`
5. Restart Docker Desktop by right clicking on the icon in the tray bar

### Ubuntu 22.04 on WSL2

![docker compose version executed on wsl](https://fpira.com/static/postimages/3010/6973-screenshot_767.png)

1. Check the current Compose version with `docker compose version`
2. Run the commands below:

```bash
mkdir -p ~/.docker/cli-plugins
cd -p ~/.docker/cli-plugins
wget -q https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64 -O docker-compose
chmod +x docker-compose
```

3. Run `docker compose version` again to check for Compose to be updated
4. Done. No need to relaunch Docker Desktop

### Final considerations

Before upgrading to Docker Desktop `4.36` revert the changes by deleting the downloaded files on WSL2 and Windows and renaming `docker-compose.exe.old` back to `docker-compose.exe` on Windows. Also, the procedure may be used to upgrade or install other Docker plugins.

I hope it helps. Thanks for reading.
