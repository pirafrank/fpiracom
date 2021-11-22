---
title: git-crypt setup guide
subtitle: Encrypt secrets in your repositories and keep them near your code
description: "A guide about how to encrypt sensitive information in git repositories"
categories: ['How-tos']
tags: ['Bash','Git','Security']
seoimage: common/keys.jpg
---

{% include image.html url="/static/postimages/common/keys.jpg" desc="Keys" credits="https://unsplash.com/@contradirony" %}

Secrets such as API keys, tokens and passwords are necessary information our software needs to run.
Storing them safely is important so many options have been developed

Encrypting secrets in your repositories may be a convenient option to keep them near the code that needs them.

Let's start!

First install it:

```sh
sudo apt-get install -y git-crypt
```

Move to the repository root and init and export the symmetric key that encrypts files:

```sh
git-crypt init
git-crypt export-key ../exported_plain_key
```

Add users that are able to decrypt files in the repository.

this will encrypt the symmetric key with the public PGP key (or email) of the target users.

```sh
git-crypt add-gpg-user ABCD1234ABCD1234
```

Customize your `.gitattributes` file and paste the content below. If the file already exists in your repository, append lines to it.

Customize it to you needs with the relative path of files you need to protect. Lines starting with `#` are comments.

```txt
# [file pattern] attr1=value1 attr2=value2
# e.g.
# secretfile filter=git-crypt diff=git-crypt
# *.key filter=git-crypt diff=git-crypt
# secretdir/** filter=git-crypt diff=git-crypt
```

Now commit the file to finish setting up the git-crypt configuration.

```sh
git add .gitattributes 
git commit -m "git-crypt setup"
```

Now the repository is set up. The state git-crypt encryption is currently *unlocked*. Use `git-crypt status` to know about the status of encrypted and decrypted files. You can add the sensitive files you specified in `.gitattributes` and commit them.

If you need to add more files in the future, first update the `.gitattributes` file and commit it, then `git add` your files and commit them. git-crypt will handle encryption transparently. Just be sure the repository is *unlocked* when you perform those actions.

Hope it helps. Thanks for reading.

## Links

- [https://github.com/AGWA/git-crypt](https://github.com/AGWA/git-crypt) 
- [https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih](https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih)
