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

add `--future` to compile and show post with later date than today;

add `--drafts` to compile and show drafts.

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

### Images with captions and/or links

This is done using the `_includes/image.html` include.

```text
{% include image.html 
url="/static/postimages/2020-06-08/office.jpg"
desc="Image by Markus Spiske from Pixabay"
credits="https://pixabay.com/users/markusspiske-670330/"
%}
```

or if caption has a link

```text
{% include image.html 
url="/static/postimages/2020-06-08/office.jpg"
desc="Image by Markus Spiske from Pixabay"
link="https://somehost.local/some/article"
credits="https://pixabay.com/users/markusspiske-670330/"
%}
```

attribute|required|use
---|---|---
`url`|yes|image url
`desc`|yes|image caption and alt text
`link`|no|if your caption needs to point to a url
`credits`|no|url to image author

### GitHub Gist

Write the gist id in a Liquid tag like the following:

```text
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
page|`https://fpira.com/static/pageimages/` + `page.seoimage`
post|`https://fpira.com/static/postimages/` + `page.seoimage`
project|`https://fpira.com/static/projectimages/` + `page.seoimage`

`page.seoimage` refers to the `seoimage` variable specified in the front-matter.

If `seoimage` is not specified, `https://fpira.com/assets/images/og_image.png` will be used instead, as written in `_includes/seo.html`.

A folder for generic SEO images in posts exists, it's called `common`. So the resulting URL for those is `https://fpira.com/static/postimages/common/` + image filename.

### SEO images in RSS feed

Check the guide below to make IFTTT EntryImageURL work ([source](https://en.philipp-guttmann.de/Blog/IFTTT_Photo_RSS_EntryImageURL/)).

First specify the `xmlns:content` namespace.

```xml
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
```

Then add `content:encoded` tag to every feed item. See below how to specify the URL in the `img` tag.

```xml
<item>...
<content:encoded><![CDATA[<img src="Your Image URL" />]]></content:encoded>
...</item>
```

Now IFTTT can get the URL from the `img` tag and make it available to applet via the `EntryImageURL` ingredient.

### Adding filters to IFTTT RSS feed trigger

- [IFTTT - Why is there a “File not found” image on my post?](https://help.ifttt.com/hc/en-us/articles/115010361748/)

## Theming

```xml
<meta name="theme-color" content="#3344aa">
```

Links:

- [Meta Theme Color and Trickery](https://css-tricks.com/meta-theme-color-and-trickery/)

## Further notes

`has_fa` variable is not used right now. Font-awesome is always loaded. Variables in front-matter are kept in case I change my mind and put an `if` in font-awesome loading in `head.html` file.
