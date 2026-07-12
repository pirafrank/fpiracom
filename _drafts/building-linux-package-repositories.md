---
title: "Building APT, YUM/DNF, and APK Repositories"
subtitle: "Publishing signed Linux package repositories from GitHub Releases"
description: "How to build and publish signed APT, YUM/DNF, and APK repositories using GitHub Actions, Cloudflare R2, and a Worker."
category: [ "How-tos" ]
tags: [ "CI-CD", "GitHub", "Linux", "Debian", "CentOS", "Cloud" ]
seoimage: "3020/linux-package-repositories.svg"
---

![Building APT, YUM/DNF, and APK repositories]({{ site.baseurl }}/static/postimages/3020/linux-package-repositories.svg)

> Part 3 of a three-part CLI packaging automation series.
>
> Previous: [Automating Homebrew Formula Updates from GitHub Releases]({% link _drafts/automating-homebrew-tap-from-github-releases.md %})  
> Previous: [Automating AUR Packages with AURA]({% link _drafts/automating-aur-packages-with-aura.md %})

The first two parts of this series were about generating package-manager metadata from GitHub Releases.

- Homebrew needed a formula
- AUR needed `PKGBUILD` and `.SRCINFO`

For Debian-like, RPM-based, and Alpine systems, that is not enough.

Those ecosystems usually expect a repository, not just a single package file. That means the release process needs to handle more than package generation:

- package metadata
- repository indexes
- signatures
- storage
- a stable HTTP endpoint that package managers can use

That is what the third repository in this series does.

The source repository is [pirafrank/packages](https://github.com/pirafrank/packages){:target="_blank"}{:rel="noopener noreferrer"}. The public endpoint users actually interact with is [pkg.fpira.com](https://pkg.fpira.com){:target="_blank"}{:rel="noopener noreferrer"}.

That distinction matters, so I will keep repeating it:

- `packages` is the source repository
- `pkg.fpira.com` is the published package endpoint

## Package files are not package repositories

If I only build a `.deb`, `.rpm`, or `.apk`, I have solved only one part of the problem.

A repository-aware installation flow needs more:

- the package file itself
- the metadata that indexes it
- signing keys and signatures
- a location clients can add to their package-manager configuration
- a structure that supports upgrades later

That is why this repository is the most complex of the three. It is not only translating release metadata. It is also publishing an ecosystem-specific delivery channel.

The user-facing result is still boring, which is exactly the point.

On Debian and Ubuntu:

```bash
curl -fsSL https://pkg.fpira.com/apt/gpg.pub \
  | sudo gpg --dearmor -o /usr/share/keyrings/pkg.fpira.com.gpg
echo "deb [signed-by=/usr/share/keyrings/pkg.fpira.com.gpg] https://pkg.fpira.com/apt stable main" \
  | sudo tee /etc/apt/sources.list.d/pkg.fpira.com.list
sudo apt update && sudo apt install poof
```

On Fedora, RHEL, or CentOS:

```bash
sudo rpm --import https://pkg.fpira.com/yum/gpg.pub
sudo tee /etc/yum.repos.d/pirafrank.repo << EOF
[pirafrank]
name=pirafrank
baseurl=https://pkg.fpira.com/yum/el9/$(uname -m)/
enabled=1
gpgcheck=1
gpgkey=https://pkg.fpira.com/yum/gpg.pub
EOF
sudo dnf install poof
```

On Alpine:

```bash
wget -q -O /etc/apk/keys/signing-key.rsa.pub \
  https://pkg.fpira.com/apk/signing-key.rsa.pub
ALPINE_VERSION=$(cat /etc/alpine-release | cut -d. -f1,2)
echo "https://pkg.fpira.com/apk/v${ALPINE_VERSION}" \
  >> /etc/apk/repositories
apk update && apk add poof
```

Once that setup exists, upgrades become native too:

```bash
sudo apt update && sudo apt upgrade
sudo dnf upgrade
apk upgrade
```

That is the end-user experience I care about.

## The source repository vs the public endpoint

The repository called `packages` is where the automation lives:

- GitHub Actions workflows
- application configuration
- architecture matrices
- packaging scripts
- signing steps
- R2 publishing
- the Cloudflare Worker used to serve the final files

The public domain `pkg.fpira.com` is the output of that automation.

That separation is useful because it reflects the actual architecture:

1. a tool repository publishes a GitHub Release
2. `packages` consumes the release assets
3. GitHub Actions builds packages and repository metadata
4. the results are uploaded to a Cloudflare R2 bucket
5. a Cloudflare Worker serves the repository under `pkg.fpira.com`

So the repository name and the public name represent two different layers, not two names for the same thing.

## The common release contract

All three packaging repositories in this series consume upstream GitHub Releases, but the `packages` repository is deliberately more mechanical about it.

Each workflow accepts the same two pieces of input:

- `app_name`
- `tag`

Those values arrive either from `workflow_dispatch` or from a `repository_dispatch` event named `new_release`.

The workflows then strip the `v` prefix from the tag and use the app name to load:

- application metadata from `configurations/*.jsonc`
- target matrices from `matrices/{apt,yum,apk}/*.matrix.jsonc`

For `poof`, the base metadata is tiny:

```json
{
  "source_repo": "pirafrank/poof",
  "maintainer": "Francesco Pira <dev@fpira.com>",
  "description": "Easy to use zero-config, zero-install, zero-dependencies manager of pre-built software that works like magic",
  "url": "https://github.com/pirafrank/poof",
  "category": "utils",
  "license": "MIT"
}
```

The real variability lives in the matrices.

For example, the APT matrix for `poof` includes:

- `amd64`
- `arm64`
- `armhf`
- `i386`
- `riscv64`

with a per-target `glibc_max` constraint.

By contrast, `vault-conductor` only has two APT targets:

- `amd64`
- `arm64`

That is one reason I like the repository structure. The metadata for an app stays separate from the set of targets it supports in each ecosystem.

## One dispatch, three workflows

The repository is split into three publishing workflows:

- `apt.yml`
- `yum.yml`
- `apk.yml`

Each one listens to the same `new_release` event, but they keep their own concurrency group:

- `apt-publish`
- `yum-publish`
- `apk-publish`

That makes the repository easier to reason about than one giant workflow file trying to do everything in one place.

It also matches the actual work better:

- APT and YUM both use `fpm`, but publish very different metadata
- APK has a completely different build and signing path
- each repository family has its own storage layout

## APT: package files plus repository metadata

The APT workflow is a good example of how the repository is designed.

It starts by resolving inputs and loading:

- the app config JSONC
- the app-specific APT matrix

Then, for each matrix entry, it:

1. downloads the matching GitHub release asset with `gh release download`
2. extracts the binary from the tarball
3. runs a glibc compatibility check with the root `justfile`
4. builds a `.deb` package using `fpm`
5. uploads the built package as an artifact

The glibc check is a nice detail. The repository uses:

```bash
just glibc binary/<app>
```

to inspect the highest glibc version required by the binary and compare it against the configured ceiling for that target. That keeps the published packages aligned with the older distributions the repository still wants to support.

After the `.deb` files are built, the publish job:

1. downloads the existing APT repository from R2
2. installs `reprepro`
3. imports the GPG signing key
4. initializes or reuses `apt/conf/distributions`
5. adds any new `.deb` packages to the repository
6. exports the public GPG key
7. syncs the updated repository back to R2

One detail I particularly like is that the repository uses the `multiple-versions-debian` branch of `reprepro`, and the generated `distributions` config sets `Limit: 0`. In other words, the repository does not pretend the APT side is a one-version-at-a-time bucket. It behaves like an actual package repository.

Another useful detail is idempotency. Before adding a `.deb`, the publish step checks whether that version is already registered and skips `includedeb` if it is. That keeps retries boring.

## YUM and DNF: one binary, several repository layouts

The YUM workflow starts a lot like the APT one:

- resolve inputs
- load config and matrix
- download release assets
- extract binaries
- enforce glibc compatibility

It also uses `fpm`, but this time to build RPM packages.

The interesting part is that each binary is repackaged four times, one for each distribution family layout:

- `el8`
- `el9`
- `amzn2`
- `amzn2023`

That means one upstream `x86_64-unknown-linux-gnu` build can become several repository-specific RPM filenames, each published in the appropriate directory.

After building the RPMs, the publish job:

1. imports the GPG key
2. configures RPM signing macros
3. downloads the existing YUM repository from R2
4. signs the RPMs with `rpm --addsign`
5. organizes them into distribution and architecture directories
6. runs `createrepo_c`
7. signs each `repomd.xml`
8. exports the public GPG key
9. syncs everything back to R2

That is a good example of why "building package files" and "hosting repositories" are separate concerns. The RPM build itself is not the hardest part. The repository metadata and signing path are what turn the output into something DNF or YUM can actually trust and use.

## APK is the most different path

APK is the least similar to the Homebrew and AUR articles, and honestly that is one reason I find it the most interesting part of the repository.

The APK workflow still begins from the same release inputs, but it diverges quickly:

- it targets `*-unknown-linux-musl` binaries
- it uses a Docker-based Alpine build environment
- it relies on `APKBUILD.template`
- it signs the repository with an RSA key used by Alpine tooling

The matrix is also two-dimensional in a way the others are not. For `poof`, the APK flow builds across:

- `x86_64`
- `aarch64`
- `armv7`
- `riscv64`

and repeats that for Alpine:

- `3.20`
- `3.21`
- `3.22`
- `3.23`

That is a lot of combinations, but the matrix keeps it explicit.

The build job:

1. downloads the release asset for one musl target
2. extracts the binary
3. installs `poof` and Bitwarden's `bws` CLI
4. retrieves the APK signing key from Bitwarden Secrets Manager
5. converts the key material into the format expected by Alpine tooling
6. builds a Docker image for the target Alpine version
7. runs the container to generate the `.apk`

The template used inside that container is tiny:

```sh
pkgname=@@PKGNAME@@
pkgver=@@PKGVER@@
pkgrel=@@PKGREL@@
pkgdesc="@@PKGDESC@@"
url="@@URL@@"
arch="@@ARCH@@"
license="@@LICENSE@@"

package() {
    install -Dm755 /input/@@PKGNAME@@ "$pkgdir/usr/bin/@@PKGNAME@@"
}
```

That is much simpler than the surrounding publication machinery, which is probably the right balance. The template only needs to describe the package. The workflow handles the repository side.

The publish job then:

1. downloads the existing APK repository from R2
2. copies packages into `v<alpine-version>/<arch>/`
3. retrieves the signing key again
4. creates `APKINDEX.tar.gz` for each populated directory
5. signs each index with `abuild-sign`
6. exports the public key as `signing-key.rsa.pub`
7. syncs the repository back to R2

That is the part the combined draft completely missed, and it is probably the best example in the whole series of why the repository needs its own article.

## Trust and signing are different here

This repository has a different trust model from the other two in the series.

In the Homebrew tap, trust was mostly about a signed commit that updated a formula.

In AURA, trust included SSH-signed commits and a push to `aur.archlinux.org`.

Here, the trust story is about signed repository metadata and published keys:

- APT metadata is signed through GPG and `reprepro`
- RPM packages are signed, and `repomd.xml` is detached-signed
- APK uses an RSA signing key for `abuild-sign`

The repository also uses two secret-management styles:

- GPG secrets for APT and YUM
- Bitwarden Secrets Manager for the APK signing key

That is another reason I did not want to hide all packaging paths behind one generic abstraction. The trust model changes across ecosystems too.

## Storage and serving: R2 plus a Worker

All three package families are stored in Cloudflare R2.

That means the GitHub Actions workflows do not commit built artifacts back into the repository. They publish mutable repository state to object storage instead.

Then the Cloudflare Worker serves that state under `pkg.fpira.com`.

The Worker logic is refreshingly small:

- only `GET` and `HEAD` are allowed
- `/` serves `index.html`
- missing objects return `404`
- APK "stable" requests are redirected to the latest supported Alpine version

The last point is particularly useful:

```text
/apk/stable/...
```

is rewritten to the current stable Alpine path, which is hardcoded in the Worker so clients can have a simpler target when that shortcut makes sense.

The root page is also generated from the repository README and uploaded to R2, so the landing page users see at `pkg.fpira.com` is part of the same publishing model.

## Verification exists, but it is not release-gating

The repository includes:

- `test_apt.yml`
- `test_yum.yml`
- `test_apk.yml`

Those workflows build Docker images and install packages from the live repository endpoint. That is useful because it verifies the actual consumer experience, not only the packaging commands in isolation.

But they are manual `workflow_dispatch` workflows right now, not release-gating tests automatically triggered on each publish. That distinction is worth saying out loud for the same reason it mattered in the AURA article: automation descriptions are more useful when they describe what really happens.

## One important limitation

Unlike the Homebrew and AURA repositories, this one does **not** currently consume a release asset checksum from GitHub and verify it before packaging.

The workflows rely on:

- predictable asset names
- direct downloads from GitHub Releases
- the trust in the upstream release process

That is still a reasonable system, but it is different from the asset-digest flow used by the other two repositories. I think it is important to say that explicitly rather than pretending the three repositories share the exact same verification model.

## Why I still prefer three repositories

By the time I reach this part of the series, the answer is hopefully clearer than in the abstract.

| Repository | Purpose |
| --- | --- |
| `homebrew-tap` | Generate Homebrew formulae |
| `aura` | Generate AUR package definitions |
| `packages` | Build, sign, publish, and serve Linux repositories |

Trying to merge those three responsibilities into one release repository would save some duplication, but it would also blur a lot of important differences:

- file formats
- repository layout
- signing model
- publication path
- failure modes

I would rather maintain three smaller systems with clear jobs than one larger system that tries to pretend those jobs are identical.

## Wrap-up

This repository is the most operationally heavy part of my packaging setup, but it also gives the nicest end-user result.

Instead of telling users to fetch standalone package files by hand, I can give them repository instructions that integrate with the package manager they already use. That means native install commands, native upgrades, signed metadata, and a predictable endpoint at `pkg.fpira.com`.

That is why I split the original combined article into three parts.

The underlying philosophy is consistent across the series, but the implementation details are not:

- Homebrew translates release metadata into formulae
- AURA translates release metadata into `PKGBUILD` and `.SRCINFO`
- `packages` turns release assets into signed repositories backed by R2 and served through Cloudflare

That split keeps each repository smaller, easier to debug, and closer to the conventions of the package manager it serves.

I hope it helps. Thanks for reading.
