---
title: "Automating CLI packaging across Homebrew, AUR, and Linux repositories"
subtitle: "How I split release packaging between Homebrew tap, AURA, and pkg.fpira.com"
description: "A practical look at how I automate packaging and distribution of my CLI tools across macOS, Arch Linux, Debian, Ubuntu, Fedora, RHEL, CentOS, Amazon Linux, and Alpine."
category: [ "How-tos" ]
tags: [ "ci-cd", "github", "linux", "macos", "debian", "ubuntu", "centos", "tools" ]
seoimage: "common/TODO-seoimage.png"
---

![CLI packaging automation overview]({{ site.baseurl }}/static/postimages/common/TODO-seoimage.png)

<!-- TODO: replace the placeholder hero image with a diagram of GitHub Releases feeding Homebrew, AUR, APT, YUM/DNF, and APK repositories. -->

I have a few CLI tools that I want to install like normal software, not like random binaries I downloaded six months ago and forgot about.

For a single machine, a GitHub Release asset and a `curl` command are usually enough. For multiple platforms, distributions, architectures, and package managers, it gets boring very quickly.

So I ended up splitting the packaging problem into three small repositories:

- [homebrew-tap](https://github.com/pirafrank/homebrew-tap){:target="_blank"}{:rel="noopener noreferrer"} for macOS and Linux users who install tools with Homebrew
- [aura](https://github.com/pirafrank/aura){:target="_blank"}{:rel="noopener noreferrer"} for Arch User Repository automation
- [packages](https://github.com/pirafrank/packages){:target="_blank"}{:rel="noopener noreferrer"} and [pkg.fpira.com](https://pkg.fpira.com){:target="_blank"}{:rel="noopener noreferrer"} for APT, YUM/DNF, and APK repositories

This post is not a universal packaging doctrine. It is the setup I use for my own tools, with enough notes to make it reusable if you are trying to solve the same problem.

## The packaging problem

When I publish a CLI tool, the actual release artifact is usually the easy part.

A CI workflow builds binaries, archives them, attaches checksums, and creates a GitHub Release. Nice.

The less fun part starts after that:

- Homebrew needs a formula
- Arch users expect a `PKGBUILD`
- Debian and Ubuntu users want an APT repository
- Fedora, RHEL, CentOS, and Amazon Linux users want a YUM/DNF repository
- Alpine users expect APK packages
- every architecture needs the right asset and checksum
- every package manager has its own metadata format

Doing this manually is possible, but it is the kind of manual work that silently becomes outdated.

My goal was simple: the GitHub Release should remain the source of truth, and the packaging repositories should update from it.

## Homebrew tap: good for macOS and Homebrew users

The first piece is my Homebrew tap:

```bash
brew tap pirafrank/tap
brew install pirafrank/tap/<FORMULA_NAME>
```

The repository lives at:

```text
https://github.com/pirafrank/homebrew-tap
```

In my case, this tap is where I publish formulae for tools such as `poof`, `vault-conductor`, and `exif_renamer`.

The automation is based around a small Python script and templates. The script fetches the latest GitHub Release for a project, reads the release assets and checksums, then renders the formula from a Jinja2 template.

The useful part is that each tool gets a small YAML configuration file, instead of hardcoding everything into the script.

A simplified version of that idea looks like this:

```yaml
github_repo: "pirafrank/poof"
template_path: "templates/poof.rb.j2"
output_path: "Formula/poof.rb"

asset_patterns:
  darwin_amd64: "poof-{VERSION}-x86_64-apple-darwin.tar.gz"
  darwin_arm64: "poof-{VERSION}-aarch64-apple-darwin.tar.gz"
  linux_amd64: "poof-{VERSION}-x86_64-unknown-linux-gnu.tar.gz"
```

Then the local update command is boring, which is exactly what I want:

```bash
python scripts/update_formula.py poof
```

The same process can run in GitHub Actions, either manually with `workflow_dispatch` or from another repository with `repository_dispatch`.

That gives me a clean release flow:

1. the tool repository publishes a new GitHub Release
2. a dispatch event tells the tap which formula to update
3. the tap regenerates the formula
4. the workflow commits the result

I like this approach because the Homebrew tap stays small. It does not build the software. It only translates release metadata into Homebrew metadata.

## AURA: keeping Arch packaging separate

Arch packaging has a different shape, so I keep it in a separate repository:

```text
https://github.com/pirafrank/aura

```

AURA stands for Arch User Repository Automation. The idea is similar to the Homebrew tap: do not manually edit package files every time a release changes.

For Arch, the important file is usually the `PKGBUILD`. Depending on the tool, the package may need to update:

* `pkgver`
* `source`

* checksums
* architecture list
* install or post-install notes
* package description and metadata

The automation target is still the same: take the latest upstream release and produce the packaging files expected by the package manager.

I keep this separate from the Homebrew tap because Homebrew formulae and Arch `PKGBUILD` files have different conventions. Mixing both in the same repository would save almost nothing and make the automation harder to reason about.

In practice, I prefer this layout:

```text
tool repository
  -> publishes GitHub Release

homebrew-tap
  -> consumes release
  -> updates Formula/*.rb

aura
  -> consumes release
  -> updates AUR package files
```

That separation also makes failures easier to debug. If the Homebrew formula updates correctly but the Arch package does not, I know where to look.

## packages and pkg.fpira.com: APT, YUM/DNF, and APK

For Debian-like and Red Hat-like systems, a package file alone is not enough. Users usually expect a repository that their package manager can trust and update from.

That is what this repository is for:

```text
https://github.com/pirafrank/packages
```

And the published package endpoint is:

```text
https://pkg.fpira.com
```

At the moment, this repository is the home for package manager distribution of my CLI tools, including `poof` and `vault-conductor`.

For Debian and Ubuntu, the installation flow looks like this:

```bash
curl -fsSL https://pkg.fpira.com/apt/gpg.pub \

  | sudo gpg --dearmor -o /usr/share/keyrings/pkg.fpira.com.gpg

echo "deb [signed-by=/usr/share/keyrings/pkg.fpira.com.gpg] https://pkg.fpira.com/apt stable main" \
  | sudo tee /etc/apt/sources.list.d/pkg.fpira.com.list

sudo apt update
sudo apt install <APPNAME>
```

For newer Fedora, RHEL, and CentOS systems, it is the usual RPM repository setup:

```bash
sudo rpm --import https://pkg.fpira.com/yum/gpg.pub

sudo tee /etc/yum.repos.d/pirafrank.repo <<EOF
[pirafrank]
name=pirafrank
baseurl=https://pkg.fpira.com/yum/el9/$(uname -m)/
enabled=1
gpgcheck=1
gpgkey=https://pkg.fpira.com/yum/gpg.pub
EOF

sudo dnf install <APPNAME>
```

The nice thing about having a real repository is that updates become native:

```bash
sudo apt update && sudo apt upgrade
```

or:

```bash

sudo dnf upgrade
```

No special updater, no custom shell script, no instructions that only work on my machine.

## Why not use only one tool?

There are tools that can publish to many package managers from one configuration file. For some projects, that is the right choice.

For my own tools, I wanted the packaging repositories to stay close to the package manager they serve.

That gives me a few benefits:

* the Homebrew tap looks like a normal Homebrew tap
* the Arch automation can follow AUR conventions
* the Linux package repository can focus on repository metadata, signing, and publishing
* each workflow has a smaller blast radius
* I can rebuild or replace one packaging path without touching the others

The trade-off is that I maintain three repositories instead of one.

I am fine with that because they are small, and because each one has a clear job.

## The release flow I aim for

The release flow I want is this:

```text
CLI tool repository
  |
  | creates GitHub Release
  | uploads binaries, archives, checksums
  v
packaging automation
  |
  | updates Homebrew formula
  | updates AUR package files
  | publishes APT/YUM/APK repository metadata
  v
users install with their normal package manager
```

For example:

```bash
brew install pirafrank/tap/poof
```

or:

```bash
sudo apt install poof
```

or:

```bash
sudo dnf install poof
```


That is the end-user experience I care about. The automation exists so the installation command can stay boring.

## A few lessons learned

The first lesson is that release asset names matter.

If assets follow a predictable pattern, automation becomes much easier. I try to keep names structured around the project name, version, operating system, architecture, and sometimes libc.

Something like this is easier to automate:

```text
poof-0.6.0-x86_64-unknown-linux-gnu.tar.gz
poof-0.6.0-aarch64-apple-darwin.tar.gz
```

than something that changes shape between releases.

The second lesson is that checksums should come from the release process, not from my laptop.

If the CI system builds the artifact, the CI system should also produce or expose the digest used by the packaging automation.

The third lesson is to keep packaging logic boring.

Templates, small YAML configuration files, and explicit asset patterns are not fancy, but they are easy to inspect when something breaks.

## When this setup makes sense

This setup is probably useful if:

* you publish CLI tools as GitHub Releases
* you support more than one operating system or architecture
* you want users to install through normal package managers
* you prefer small purpose-built automation over one large release system
* you are okay maintaining packaging repositories as part of the project

It may be too much if you only publish one binary for one platform.

In that case, a GitHub Release plus a small install script may be enough. For example, `poof` itself is designed to install pre-built software from GitHub Releases without requiring manifests, formulae, ports, or repositories. So yes, there is a small irony here: I maintain package repositories for a tool that can avoid package repositories.

Computers are fun.

## Wrap-up

For now, this split works well for me:

* `homebrew-tap` handles Homebrew formulae
* `aura` handles Arch/AUR automation
* `packages` and `pkg.fpira.com` handle APT, YUM/DNF, and APK distribution

The common idea is the important part: GitHub Releases are the source of truth, and the package manager metadata is generated from them.

That keeps releases repeatable, makes updates less manual, and gives users the installation path they already expect on their system.

I hope it helps. Thanks for reading.

