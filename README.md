# fpira.com source code

[![deploy on vercel](https://github.com/pirafrank/fpiracom/actions/workflows/deploy_on_vercel.yml/badge.svg)](https://github.com/pirafrank/fpiracom/actions/workflows/deploy_on_vercel.yml)

Just my website. Visit [fpira.com](https://fpira.com) for a live version.

## About the website code

This website is powered by Jekyll. It started in 2015 as an overhauled fork of [Jekyll Now](https://github.com/barryclark/jekyll-now) with custom CSS designed from scratch. Over the years, I've implemented many additional features, tailored on my needs.

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

### Use environment variables

Thanks to the `jekyll-environment-variables` plugin, you can use `{{ site.env.MYENV }}` in Liquid expressions.

### Production build

Prepend `JEKYLL_ENV=production` to commands above.

### Algolia search

Algolia settings are stored in `_config.yml`. It uses the search-only API key.

To update the Algolia index run:

```sh
ALGOLIA_API_KEY='123abc123abc123abc123abc123abc12' bundle exec jekyll algolia
```

where the `ALGOLIA_API_KEY` is the Admin API Key you get from [your account dashboard](https://www.algolia.com/account/api-keys/all).

## GitHub Actions

To run a GitHub Actions workflow on any branch use the `--ref` flag. This works even if you have never merged the workflow file in the repository's default branch.

```sh
gh workflow run workflow --ref branch-name
```

or for input params

```sh
gh workflow run workflow --ref branch-name -f myparameter=myvalue
```

For futher info, [check the docs](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow#running-a-workflow-using-github-cli).

## Web Analytics

Configure the following environment variables at build time if web analytics have to be set. Don't set to disable.

```text
ANALYTICS_GOOGLE='UA-1234567-1'

ANALYTICS_GTAG='UA-1234567-8'

ANALYTICS_HEATMAP=abc123abc123

ANALYTICS_MATOMO_HOST=somematomo.host.com
ANALYTICS_MATOMO_ID=abc123abc123

ANALYTICS_CLOUDFLARE=abc123abc123

ANALYTICS_UMAMI_WEBSITEID=abc123abc123
ANALYTICS_UMAMI_ENDPOINT=umami.instance.com
```

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

### Video embeds

You only need the video ID from the link URL (e.g. abc123abc123)

YouTube

```text

{% youtube abc123abc123 %}

```

Vimeo

```text

{% vimeo abc123abc123 %}

```

TED talks

```text

{% ted abc123abc123 %}

```

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

### External links

To add `target="_blank" rel="noopener noreferrer"` to markdown, write links as follows:

```md
[Awesome link]({{ site.data.external.awesomelink }}){:target="_blank"}{:rel="noopener noreferrer"}.
```

which generates:

```html
<a href="https://www.someexternal.site" target="_blank" rel="noopener noreferrer">here</a>
```

To add a font-awesome icon:

```html
<i class="fa-solid fa-arrow-up-right-from-square" aria-hidden="true"></i>
<i class="fa-brands fa-github" aria-hidden="true"></i>
```

## Media files

Static media files are stored in `static/media`.

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

## APIs

`api` folder contains an attempt to provide APIs out of a Jekyll website. Those can be useful for integrations: e.g. I use `/api/v1/ifttt/posts/latest` to fetch details of the last published blog post from an RSS trigger on IFTTT.

Check the folder to find the structure.

## CMS

### prose.io

CMS-like functionality can be experiences using [prose.io](https://prose.io).

Prose.io uses `_prose.yml` in the repo root. To provide a list of actual tags and categories available on the website two JSONP files are used. Run the following to generate them.

```sh
bash repo_utils/list_categories.sh | awk '{ print $2 }' | sort | node repo_utils/jsonp_generator.js categories
bash repo_utils/list_tags.sh | awk '{ print $2 }' | sort | node repo_utils/jsonp_generator.js tags
```

which will generate `jsonp/categories.jsonp` and `jsonp/tags.jsonp` files.

## Theming

```xml
<meta name="theme-color" content="#3344aa">
```

Links:

- [Meta Theme Color and Trickery](https://css-tricks.com/meta-theme-color-and-trickery/)

## Further notes

`has_fa` variable is not used right now. Font-awesome is always loaded. Variables in front-matter are kept in case I change my mind and put an `if` in font-awesome loading in `head.html` file.

## License

Source code is released under GNU GPLv3 license. Website and blog content are released under Creative Commons Attribution-NonCommercial 4.0.

To know more about terms and license, please read the [terms](pages/pages/terms.md) page.
