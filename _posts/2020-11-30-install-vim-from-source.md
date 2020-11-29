---
title: "Install Vim 8.2 on Ubuntu 20.04"
subtitle: A quick how-to to build and install it from source
description: "A quick guide on how to install Vim 8.2 from sources on Ubuntu 20.04"
categories: ['How-tos']
tags: ['vim','ubuntu']
seoimage: 2020-11-30/installed_vim.png
---

Hi everyone, while customizing my `.vimrc` ([here]({{ data.social.github.url }}/dotfiles)), I found out Ubuntu 20.04 version of vim is a bit old and doesn't come with `+python` support. So I wrote a quick snippet to build vim 8.2 from source with it, and a couple of features more.

Just check the images below for a quick comparison.

{% include image.html
url="/static/postimages/2020-11-30/stock_vim.png"
desc="Stock vim from Ubuntu PPA (open in a new tab to zoom)"
%}

{% gist 8436327f2e59a5593fdbffd26d0e5fae %}

Then you should get something like this:

{% include image.html
url="/static/postimages/2020-11-30/stock_vim.png"
desc="Installed vim from sources (open in a new tab to zoom)"
%}

Please note that the scripts installs vim to `/usr/local/bin` and sets `alternatives` so that you can make it live along other vims, should you want to install other versions.

I hope it helps. Thanks for reading.
