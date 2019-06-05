---
layout: post
title: Migrate a repository from bazaar to git
categories: ['How-tos']
description: A guide that explains how to migrate a repository from bazaar to git
tags: ['Git']
---

Developers may have the need to change some tools they work with everyday, like VCS. This guide explains how to completely port a bazaar repository to a Git one.

#### Porting

Porting the repo is no more than few commands:

```sh
$ cp -pr repo-dir repo-dir_backup                 # Make a backup
$ cd repo-dir                                     # Change into your dir
$ git init                                        # Initialise a new git repo
$ bzr fast-export --plain . | git fast-import     # Do the actual conversion
$ git co -f master                                # Will reply 'Already on master'
$ rm -rf .bzr                                     # Remove the bzr data
```

#### Check

Now verify that everything is there:

```sh
$ git log
```

You should see the commit history.

Double check using:

```sh
$ diff -r repo-dir repo-dir_backup
```

Do it before you delete the backup directory.

#### Migrate the *ignore* file

Migrate .bzrignore to .gitignore:

```sh
$ git mv .bzrignore .gitignore
```

#### Commit all the things

Commit the repository migration:

```sh
$ git commit -a -m "Migrated from Bazaar to Git."
```

Optional: Now, you can add a remote to your git repo.

#### Troubleshooting

If you get `ERROR: unknown command "fast-export")`, type: 

```sh
$ sudo apt-get install bzr-fastimport
```

to sort it out.

Thanks for reading.

- - -

**Sources**

- https://astrofloyd.wordpress.com/2012/09/06/convert-bzr-to-git/
- https://flexion.org/posts/2012-10-migrating-bzr-to-git.html
- http://design.canonical.com/2015/01/converting-projects-between-git-and-bazaar/





