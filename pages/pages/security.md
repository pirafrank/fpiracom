---
layout: page
title: Security Resources
permalink: /security/
show_title: true
---

A collection of security guides, tools, cheat sheets and best practices I've found to be useful.

#### Communications

- [Get S/MIME on your iPhone and iPad](https://web.archive.org/web/20211202001345/https://nerd.one/how-to-set-up-smime-on-iphone-and-mac/)

#### SSH

- A very good introduction to SSH ([part 1](https://web.archive.org/web/20220703203844/https://scottwillsey.com/blog/comp/sshbasics/), [part 2](https://web.archive.org/web/20220527194742/https://scottwillsey.com/blog/comp/sshkeytheory/), and [part 3](https://web.archive.org/web/20220527174629/https://scottwillsey.com/blog/comp/sshkeygen/))
- [Top 20 OpenSSH Server Best Security Practices](http://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html)

#### VPNs

- It is best to deploy your own by installing OpenVPN on a VPS of yours
- [ProtonVPN](https://protonvpn.com)
- [privatetunnel.com](https://www.privatetunnel.com/home/?referral=NUTAYZHU54), a consumer VPN by OpenVPN

#### CPU vulns

- [Speculative execution]({% post_url 2019-05-25-speculative-execution %})

#### Harden your OS

**Linux**

- [GrSecurity](https://grsecurity.net/), a set of patches to harden the Linux kernel
- SELinux, built-in into the Linux kernel for years. I am not really a big fan of it.
- [Tomoyo](https://web.archive.org/web/20161222155130/http://tomoyo.osdn.jp//), a MAC good enough to be used as a system analysis tool, its rules are easy to write

I gave two talks about them, *Hardening One* and *Hardening Two*. Find more [here]({{ site.baseurl }}/talks/).

**macOS**

- [macOS security checklist]({% post_url 2016-11-27-macos-security-list %}) (*)
- [How the NSA snoop-proofs its Macs](http://www.macworld.com/article/2048160/how-the-nsa-snoop-proofs-its-macs.html), a bit old but something you may want to check anyway

**iOS**

- [iOS configuration hardening guide by Australian Department of Defence](http://www.asd.gov.au/publications/iOS8_Hardening_Guide.pdf)
- [A deep dive into the world of 'dev-fused' iDevices](https://motherboard.vice.com/en_us/article/gyakgw/the-prototype-dev-fused-iphones-that-hackers-use-to-research-apple-zero-days) ([archived page](https://web.archive.org/web/20190307000111/https://motherboard.vice.com/en_us/article/gyakgw/the-prototype-dev-fused-iphones-that-hackers-use-to-research-apple-zero-days))

**Android**

- [Hardening Android for Security and Privacy](https://blog.torproject.org/blog/mission-impossible-hardening-android-security-and-privacy), it may sounds impossible but there’s still something you can do

#### Tools

- [Brute-force calculator]({{ site.baseurl }}/utilities/bfc) (*)
- [nmap](http://nmap.org)
- [Wireshark](http://wireshark.org/)
- [Debookee](http://debookee.com) (macOS only)

#### Distros

- [Kali Linux](http://kali.org)
- [Tails](http://tails.boum.org)

#### Websites and blogs

- [Offensive Security](http://offensive-security.com)
- [OWASP](http://owasp.org/) and its [periodic table](https://www.owasp.org/index.php/OWASP_Periodic_Table_of_Vulnerabilities#Periodic_Table_of_Vulnerabilities)
- [Krebs on Security](https://krebsonsecurity.com/)
- [Schneier On Security](http://www.schneier.com/blog/)
- [Google Project Zero](http://googleprojectzero.blogspot.com)
- [Naked Security](https://nakedsecurity.sophos.com/)
- [The Hacker News](https://thehackernews.com/)

<br>

---

(*) Mantained by me. Please, [tell me]({{ site.baseurl }}/contacts) about your suggestions or any broken link you spot.
