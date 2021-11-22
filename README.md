# fpira.com source code

[![deploy_fpiracom](https://github.com/pirafrank/fpiracom/actions/workflows/deploy_fpiracom.yml/badge.svg?branch=main)](https://github.com/pirafrank/fpiracom/actions/workflows/deploy_fpiracom.yml)

Visit [fpira.com](https://fpira.com) for a live version.

## About the website code

This Jekyll instance is a completely overhauled fork of [Jekyll Now](https://github.com/barryclark/jekyll-now) with new design and many more features.

## Content License

To know about terms and license, please read the `terms.md` file in `pages/pages`.

Source code is released under the terms of GNU GPLv3 license.

## Setup

```sh
gem install bundler
bundle install
```

## Run it

Use either:

```sh
bundle exec jekyll serve
bundle exec jekyll
jekyll serve
jekyll s
```

add `--future` to compile and show post with later date than today.

## Build it

Use either:

```sh
bundle exec jekyll build
bundle exec jekyll b
jekyll build
jekyll b
```

### Production build

Prepend `JEKYLL_ENV=production` to commands above.

## Embed content

### Images

Use standard markdown format:

```md
![alternative description](https://)
```

E.g.

```md
![Attach Disk to VM]({{ site.baseurl }}/static/postimages/2016-01-08/001.jpg)
```

### GitHub Gist

Write the gist id in a Liquid tag like the following:

```txt
{% gist 40880dbc3e2dcfbdc1dd817b8880fa66 %}
```

Powered by [https://github.com/jekyll/jekyll-gist](https://github.com/jekyll/jekyll-gist)

### twitter posts

Just post the twitter post URL standalone in the markdown file. For example:

```md

https://twitter.com/pirafrank/status/1353708824558002177

```

Powered by `LazyTweetEmbedding` plugin ([link](https://github.com/takuti/jekyll-lazy-tweet-embedding)).

The plugin is in the `_plugins` folder.

## SEO images

resource|path
---|---
page|https://fpira.com/static/pageimages/ + page.seoimage
post|https://fpira.com/static/postimages/ + page.seoimage
project|https://fpira.com/static/projectimages/ + page.seoimage

`page.seoimage` refers to the `seoimage` variable specified in the front-matter.

A folder for generic SEO images in posts exists, it's called `common`. So the resulting URL for those is `https://fpira.com/static/postimages/common/` + image filename.

## Further notes

`has_fa` variable is not used right now. Font-awesome is always loaded. Variables in front-matter are kept in case I change my mind and put an `if` in font-awesome loading in `head.html` file.
