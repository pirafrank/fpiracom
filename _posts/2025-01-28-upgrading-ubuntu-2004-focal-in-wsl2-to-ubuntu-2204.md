---
title: "Upgrading Ubuntu 20.04 Focal in WSL2 to Ubuntu 22.04 Jammy"
subtitle: "Little how to on upgrading from Ubuntu 20.04 Focal to Ubuntu 22.04 Jammy, even if 24.04 has already been released"
description: "Upgrading Ubuntu 20.04 Focal in WSL2 to Ubuntu 22.04 Jammy, even if 24.04 has already been released"
category: [ "How-tos" ]
tags: [ "WSL", "Windows", "Linux" ]
seoimage: "3014/557-002.jpg"
---

![Ubuntu on a laptop]({{ site.baseurl }}/static/postimages/3014/557-002.jpg)

Ubuntu 22.04 (Jammy Jellyfish) has been around for long and it’s now time to replace old 20.04 (Focal Fossa) LTS as the chosen one around the web, meaning cloud environments, CI pipelines, and more. So it’s time for a WSL2 VM upgrade, too. And here’s how.

The procedure has been tested on WSL2 running on Windows 11, however it is no different than updating a 20.04 LTS install running on a virtual machine. After all, WSL2 is a lightweight VM running on a subset of Hyper-V features.

### Before we start

As you’d do on a VM, [create a snapshot first](https://learn.microsoft.com/en-us/windows/wsl/basic-commands#export-a-distribution).

### Let’s start

First upgrade the installed software packages to their latest versions and update to the nearest available release.

```text
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
```

**Install update-manager-core: a**lthough the update manager core may already be there, be sure it’s installed:

```text
sudo apt install update-manager-core
```

Edit the release-upgrades configuration file:

```text
sudo vim /etc/update-manager/release-upgrades
```

Then, change the `Prompt` value from `Normal` to `lts`

```text
Prompt = lts
```

Save the file and quit.

### Upgrade

Now the system is prepared to get the next long-term version available, here for 20.04 _Focal Fossa_, it is 22.04 _Jammy Jellyfish_ even if 24.04 _Noble Numbat_ is available. It won’t jump and skip versions.

```text
sudo do-release-upgrade
```

Note: [do not use](https://ubuntu.com/server/docs/how-to-upgrade-your-release#upgrade-the-system) the `-d` flag.

After running the above command, the system will update and replace the system repository and after that, once the system is ready to get upgraded, you will ask finally whether you want to upgrade or not. If you have changed your mind then type ‘**n**‘ and the system will roll back all the made changes.

Once the installation of the new _Jammy Jellyfish_ is completed, remove the obsolete packages to clear some space by pressing **Y** and hitting the **Enter** key.

Once done, the WSL Ubuntu App will ask you to restart the system. No need to restart the whole Windows OS, the system here is just Ubuntu inside WSL. However, it won’t start on its own because there is no **init** system. So simply close the WSL app window and open a new shell.

### Restart WSL

In powershell run:

```powershell
wsl --shutdown
```

Done. Time to check Ubuntu 22.04 WSL version:

```bash
❯ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

I hope it helps. Thanks for reading.

