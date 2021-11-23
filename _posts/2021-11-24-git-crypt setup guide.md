---
title: git-crypt setup guide
subtitle: Encrypt secrets in your repositories and keep them near your code
description: "Encrypt sensitive information in git repositories and keep them near your code"
categories: ['How-tos']
tags: ['Bash','Git','Security']
seoimage: common/keys.jpg
---

{% include image.html url="/static/postimages/common/keys.jpg" desc="Keys" credits="https://unsplash.com/@contradirony" %}

Secrets such as API keys, tokens and passwords are necessary information our software needs to run.
Storing them safely is important and many options are available. One of these is to commit secrets (encrypted, of course) in the repository itself, a convenient way to keep them near the code that needs them. A good tool I've been using to achieve that is [git-crypt](https://github.com/AGWA/git-crypt).

Let's start!

First install it:

```sh
sudo apt-get install -y git-crypt
```

Move to the repository root, then initialise `git-crypt` and export the keyfile:

```sh
git-crypt init
git-crypt export-key ../exported_plain_key
```

What about other people you work with? We need to add users that are able to decrypt files in the repository. Run the command below to encrypt the keyfile with the public PGP keys of your collaborators. You can specify their PGP key ID or their email.

```sh
git-crypt add-gpg-user ABCD1234ABCD1234
git-crypt add-gpg-user lucas@wonderful.email
```

Now edit your `.gitattributes` file and paste the content below. If the file already exists in your repository just append lines to it. Customize it to you needs with the relative path of files you want to protect. Lines starting with `#` are comments.

```text
# [file pattern] attr1=value1 attr2=value2
# e.g.
# secretfile filter=git-crypt diff=git-crypt
# *.key filter=git-crypt diff=git-crypt
# secretdir/** filter=git-crypt diff=git-crypt
```

Commit the file to finish setting up the git-crypt configuration.

```sh
git add .gitattributes 
git commit -m "git-crypt setup"
```

The repository is now set up and the git-crypt encryption state is currently *unlocked*. Use `git-crypt status` to know which files are encrypted/decrypted.

Finally, `git add` the sensitive files you specified in `.gitattributes` and commit them.

You can lock/unlock git-crypt by running `git-crypt lock` and `git-crypt unlock` respectively.

If you need to add more files in the future, first update `.gitattributes` adding their relative path followed by the `filter=git-crypt diff=git-crypt` string and commit it, then `git add` your sensitive files and commit them. git-crypt will handle encryption (at commit) and decryption (e.g. during diffs) transparently. Just be sure the repository is *unlocked* when you perform those actions.

Hope it helps. Thanks for reading.

## Links

- [https://github.com/AGWA/git-crypt](https://github.com/AGWA/git-crypt)
- [https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih](https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih)
