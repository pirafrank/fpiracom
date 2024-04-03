---
title: macOS security list
subtitle: A short guide to harden your Mac and keep it safe
categories: ['How-tos']
tags: ['Security','macOS','best practices']

---

Security is important.

The following guide is a mix of best practices inspired by [drduh's macOS security and privacy guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide) and improved with my experience. It aims to help people harden their Macs. It is written as short as possible, including just links and references and adding missing information only if needed. Please check drduh's guide for how-to details.

#### Preface

Security is a process not a state. It strongly depends on the attacker. Apple's security settings are great for the average user, but if you're reading this, it's likely you're not.

Some tools are tested and/or designed to work with specific version of macOS. Use the provided information at your own risk. I hope you find it useful.

#### The list

- Set an EFI password;
- Enable Filevault
    - Do NOT upload the master key to iCloud. Keep it in a safe deposit in your house or bank instead. Note that iCloud upload is default when upgrading the OS to a major version. A way to stop this is to refuse to encrypt during the setup steps and to do it manually when the installation is over;
- Use a strong user password (strong = [A-Z]+[0-9]+[!@$...]);
- Use standard user for day-to-day activity;
- Keep the system up-to-date;
- Subscribe to Apple mailing list and follow on twitter developers of software you care/use the most;
- Block phone-home daemons and agents (via this or firewall);
- Enable built-in incoming firewall (in *System Settings*);
- Use a third-party (e.g. Little Snitch) firewall to manage outgoing connections;
- Disable *Spotlight suggestions*;
- Disable sync of `~/Desktop` and `~/Documents` folders to iCloud (macOS Sierra only);
- Move private data to encrypted containers (e.g. using VeraCrypt) before uploading to any cloud storage;
- Using system keychain is safe, but do NOT save PGP key passphrases there;
- Use a VPN when you connect to public hotspots and only use trusted VPNs. Consider deploying your own. You may also use an SSH connection (e.g. to your own VPS) as a SOCKS proxy;
- Use [MacPorts](https://macports.org) or [Homebrew](https://brew.sh) to keep some userland tools (like bash!) up-to-date;
- Install updated versions of OpenSSL and cURL from [MacPorts](https://macports.org) or [Homebrew](https://brew.sh).
- Consider installing `gpg` or [GPGTools](https://gpgtools.org);
- Always verify PGP signatures for files and emails (note that PGP does not provide forward secrecy);
- Edit the `/etc/hosts` file to block known malware, ads and other treats;
- Don't use your ISP DNS. Use Google DNS instead, or better, use OpenDNS;
- Consider using `dnsmasq` and `dnscrypt`;
- Disable captive portal and use your web browser to login
    - Note that before trying to login to a captive portal secured network, you have to disable any proxy and custom DNS settings;
- Harden your GPG configuration (read [here](https://lists.gnupg.org/pipermail/gnupg-users/2016-May/055931.html) about the `no-honor-keyserver-url` option. Download also `sks-keyservers.netCA.pem` CA certificate, verify it (https://sks-keyservers.net/verify_tls.php) then copy it to a system path, such as /etc/ssl and `chown` it to `root:wheel`).
- Harden `~/.ssh/config` and `/etc/ssh/sshd_config` settings;
- Use DuckDuckGo as your web search engine and Firefox as your browser. Check [here](https://github.com/drduh/macOS-Security-and-Privacy-Guide#browser) some cool addons to use;
- Do not use apps coming from unidentified developers;
- Do not use cracked apps (as their executables are modified by unknown people);
- Consider using OpenBSM and DTrace for system auditing. Those are great tools and may help you further tuning you security configuration.

#### Final notes

Do NOT leave your computer unattended. If you want to further protect your PC from forensic tools, try [USBkill](https://github.com/hephaest0s/usbkill).

Your MacBook has an [IPS screen](https://en.wikipedia.org/wiki/IPS_panel). If you are worried about shoulder surfing, you should buy one of those screen privacy filters.
