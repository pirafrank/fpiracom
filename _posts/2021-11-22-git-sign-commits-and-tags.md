---
title: Signing git commits and tags
subtitle: "Show proof of your identity... and get the 'verified' badges on GitHub"
description: "Show proof of your identity and get the 'verified' badges on GitHub"
categories: ['How-tos']
tags: ['PGP','Git']
seoimage: 2021-11-22/github.png
---

{% include image.html url="/static/postimages/2021-11-22/github.png" desc="Releases page and signed commits of the VSCode repository on GitHub" %}

Commit signing is a nice way to show proof you're the author and build trust among your users and contributors. If you have a PGP setup it's a must. It also allows you to get a *Verified* badge on the GitHub commit list.

And if you sign tags, you will get a badge near version numbers in the GitHub releases page, too.

### Signing commits

You can sign a commit using

```sh
git commit -S -m 'some message'
```

or you can default to commit signing for the current repository

```sh
git config commit.gpgsign true
```

Of course, you can add `--global` flag to set it for all repositories.

### Signing tags

Here's how you sign a tag. You will be asked for a message.

```sh
git tag -s 1.0.0
# OR
git tag -s 1.0.0 SOMECOMMITHASH
```

Since v2.23 (released in Q3 2019) Git supports a config setting to sign tags by default ([commit](https://github.com/git/git/commit/1c6b565f896c27dc7c52aa3af9c7dcfc7934e8fe)).

```sh
git config tag.gpgSign true
```

Please note the cases for the 's' letters in the commands above compared to the ones for commit signing.

### An alternative

An alternative compatible with Git versions < 2.23 may be setting two aliases.

```sh
git config --global alias.cm 'commit -S'
git config --global alias.tag 'tag -s'
```

Hope it helps. Thanks for reading.
