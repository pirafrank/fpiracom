---
title: Speculative execution side-channel vulnerabilities
subtitle: Keep track of them and check for mitigations to be installed and enabled
description: "Speculative execution side-channel vulnerabilities: keeping track of them and checking for mitigations to be installed and enabled"
category: ['Posts']
tags: ["Security", "malware", "hardware"]
updates:
  - date: 2019-06-02
    content: "Added notes about libgo improvements landing in GCC 10 Git."
  - date: 2020-01-28
    content: "Added CVE-2019-1125, CVE-2019-11135, CVE-2019-12207, CVE-2020-0549, CVE-2020-0548 and updated [spreadsheet]({{ site.data.external.cpu-vulns }})."
---

It’s been over a year since speculative execution side-channel vulnerabilities are making the headlines.
Understanding and knowledge of them are essential to protect against attacks that use them.
This post tries to gather information about them. I will update it as new ones are discovered.

### Get to know them

 We can group them in the following sub-families:

**Spectre**

| CVE | Name | Known-as |
|---|---|---|
| CVE-2017-5753 | bounds check bypass | 'Spectre Variant 1'
| CVE-2017-5715 | branch target injection | 'Spectre Variant 2'
| CVE-2017-5754 | rogue data cache load | 'Meltdown' or 'Variant 3'
| CVE-2018-3640 | rogue system register read | 'Variant 3a'
| CVE-2018-3639 | speculative store bypass | 'Variant 4'
| CVE-2019-1125 | SWAPGS | SWAPGS ('Spectre Variant 1')

**Foreshadow**

| CVE | Name | Known-as |
|---|---|---|
| CVE-2018-3615 | L1 Terminal Fault | 'Foreshadow (SGX)'
| CVE-2018-3620 | L1 Terminal Fault | 'Foreshadow-NG (OS)'
| CVE-2018-3646 | L1 Terminal Fault | 'Foreshadow-NG (VMM)'

**MDS**

| CVE | Name | Known-as |
|---|---|---|
| CVE-2018-12126 | microarchitectural store buffer<br>data sampling (MSBDS) | 'Fallout'
| CVE-2018-12130 | microarchitectural fill buffer<br>data sampling (MFBDS) | 'ZombieLoad'
| CVE-2018-12127 | microarchitectural load port<br>data sampling (MLPDS) | 'RIDL'
| CVE-2019-11091 | microarchitectural data sampling<br>uncacheable memory (MDSUM) | 'RIDL'
| CVE-2019-11135 | TAA | 'ZombieLoad V2'
| CVE-2018-12207 | MCEPSC | 'No eXcuses' or 'iTLB Multihit'
| CVE-2020-0549 | L1D Eviction Sampling | L1DES
| CVE-2020-0548 | Vector Register Sampling | VRS

While Spectre variants affect almost all chips featuring out-of-order execution, Intel chips are vulnerable to all speculative execution side-channel attacks.

I've made a spreadsheet (and I'll keep it updated) with more details and a links to *deep dives* by Intel:

- [Comprehensive Google Spreadsheet]({{ site.data.external.cpu-vulns }})

I also advise you to check the following links:

- [Intel security software guidance](https://software.intel.com/security-software-guidance/)
- [Thread about MDS OS patches](https://twitter.com/pirafrank/status/1128400923632574467)

### Check for mitigations to be installed and enabled:

There are two ways to do so:

via [this awesome script](https://github.com/speed47/spectre-meltdown-checker) (Windows, Solaris and macOS are not supported):

```
$ curl -L https://meltdown.ovh -o spectre-meltdown-checker.sh
$ chmod +x spectre-meltdown-checker.sh
$ sudo ./spectre-meltdown-checker.sh
```

or, on Linux, you can do it in a less-fancy way but without the need to download and execute a script (your kernel may need to be updated to support these):

```
$ ls -1 /sys/devices/system/cpu/vulnerabilities/*
/sys/devices/system/cpu/vulnerabilities/l1tf
/sys/devices/system/cpu/vulnerabilities/mds
/sys/devices/system/cpu/vulnerabilities/meltdown
/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
/sys/devices/system/cpu/vulnerabilities/spectre_v1
/sys/devices/system/cpu/vulnerabilities/spectre_v2

$ cat /sys/devices/system/cpu/vulnerabilities/*
Mitigation: PTE Inversion; VMX: conditional cache flushes, SMT disabled
Vulnerable: Clear CPU buffers attempted, no microcode; SMT disabled
Mitigation: PTI
Vulnerable
Mitigation: __user pointer sanitization
Mitigation: Full generic retpoline, STIBP: disabled, RSB filling
```

### Benchmarks

Phoronix has written an interesting post with a comparison of 2nd and 3rd gen Intel CPU performances, with and without mitigations applied. [Check it out](https://www.phoronix.com/scan.php?page=article&item=sandy-fx-zombieload&num=1).

On May 31 2019, GCC developers have pushed code for libgo runtime library aimed at improving context switch speed of golang code running on Linux machines with a x86_64 CPU. More details are available [here](https://www.phoronix.com/scan.php?page=news_item&px=Golang-Cheaper-Context-Switches).

For more comparisons about performance penalties, these articles have information worth checking out:

- [The Combined Impact Of Mitigations On Cascade Lake Following Recent JCC Erratum + TAA](https://www.phoronix.com/scan.php?page=article&item=cascadelake-jcc-taa&num=1)
- [Debian 7 Through Debian Testing Benchmarks With/Without Mitigations](https://www.phoronix.com/scan.php?page=article&item=debian-7-2020&num=1)

### Conclusions

Speculative execution side-channel vulnerabilities make a relatively new topic in InfoSec and more are likely to be found down the road. I will update this post and the [linked Google Spreadsheet]({{ site.data.external.cpu-vulns }}) as new vulnerabilities are discovered.

Thanks for reading.
