# fpira.com source code

[![Build and Deploy](https://github.com/pirafrank/fpiracom/actions/workflows/deploy.yml/badge.svg)](https://github.com/pirafrank/fpiracom/actions/workflows/deploy.yml)
[![Notion to Jekyll](https://github.com/pirafrank/fpiracom/actions/workflows/notion_to_jekyll.yml/badge.svg)](https://github.com/pirafrank/fpiracom/actions/workflows/notion_to_jekyll.yml)

Just my website. Visit [fpira.com](https://fpira.com) for a live version.

## About the website code

This website is powered by Jekyll. It started in 2015 as an overhauled fork of [Jekyll Now](https://github.com/barryclark/jekyll-now) with custom CSS designed from scratch. Over the years, I've implemented many additional features, tailored on my needs.

## Requirements

- Ruby (check `.ruby-version`)
- Node.js (check `.nvmrc`)

## Setup

```sh
gem install bundler
bundle install
npm install -g @redocly/cli@latest
npm install -g @openapitools/openapi-generator-cli
```

## Build and run it

Via rake, running either:

```sh
rake build
rake serve
```

to build or serve.

Or, as usual for Jekyll websites, you can use:

```sh
bundle exec jekyll serve
bundle exec jekyll
jekyll serve
jekyll s
```

add `--future` to compile and show post with later date than today;

add `--drafts` to compile and show drafts.

## Rake

As many other Ruby-based projects, most tasks listed in this readme are also available as `rake` tasks for brevity and consistency.

You can check the `rakefile` and use `rake` to list all of them.

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

## Dev/Preview in Docker

You can run the development server in a docker container. The image is not specifi to the blog and it's built as a general purpose Jekyll one. It contains: `rvm`, `ruby`, `jekyll`, `nvm`, and `nodejs`.

On Linux:

```sh
docker build -t pirafrank/jekyll -f ./Dockerfile .
docker run -it --name fpiracom -v $(pwd -P):/home/jekyll/app -p 4001:4001 pirafrank/jekyll:latest
```

On Windows:

```powershell
docker build -t pirafrank/jekyll -f .\Dockerfile .
docker run -it --name fpiracom -v ${PWD}:/home/jekyll/app -p 4001:4001 pirafrank/jekyll:latest
```

You can add `--build-arg RUBY_VERSION=x.y.z --build-arg NODE_VERSION=x.y.z` to build command to specify which Ruby and/or nodejs version to use.

After the container has started, you need to run `bundle install`. This is because the source is mounted via Docker and not included in the image.

**Important**: when launching jekyll serve, be sure to bind to all interfaces:

```txt
bundle exec jekyll serve --host=0.0.0.0
```

or just use the alias:

```sh
jks
```

otherwise the server won't be accessible from the host even if the port has been bound.

## CI/CD

CI/CD is achieved via GitHub Actions. To make workflows readable and to share code, some intermediate steps are written as composable actions in `.github/actions/*`.

Part of the CI workflow is running `rake ci` which builds the website and performs multiple checks to ensure consistency. For example:

- checking Jekyll installation
- looking for internal broken links
- perform API linting
- checking consistency of produces JSON files
- checking calendar `.ics` files
- checking RSS, Atom, and JSON feeds to be readable.

### GitHub Actions

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

Configure the following environment variables at build time if web analytics have to be set. Don't set any of them to disable it.

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

Environment variables must be set where the website is actually built, e.g. if the GitHub Action pipeline builds and deploys via Vercel, then set env vars there, not in the pipeline.

## Feeds

The website supports the following feeds:

- RSS
- Atom
- JSON Feed, ([more](https://www.jsonfeed.org/))

and allows them to be [easily discovered](https://rknight.me/please-expose-your-rss/).

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
alt="An office with a desk and a computer mouse"
credits="https://pixabay.com/users/markusspiske-670330/"
%}
```

or if caption has a link

```text
{% include image.html
url="/static/postimages/2020-06-08/office.jpg"
desc="Image by Markus Spiske from Pixabay"
alt="An office with a desk and a computer mouse"
link="https://somehost.local/some/article"
credits="https://pixabay.com/users/markusspiske-670330/"
%}
```

attribute|type|required|use
---|---|---|---
`url`|URL path|yes|image url relative path, prepended by `{{ site.baseurl }}`
`alt`|text|if no `desc`|alt text
`desc`|text|if no `alt`|image caption. Also alt text if `alt` is not specified
`link`|URL|no|if your caption needs to point to a url, this will be the link to it
`credits`|URL|no|url to credit image author

### Toggle lists / accordions

This is done using the `_includes/accordion.html` include.

```text
{% include accordion.html title="this is a toggle" file="some_file.md" %}
```

where:

- `title` is the title of the toggle
- `some_file.md` is a markdown file in `_posts/accordions/YYYY-MM-DD/` folder
- `YYYY-MM-DD` is the date of the post the toggle is in
- the markdown file contains the content of the toggle

Included `file` can be `.md` or `.html`. Content is rendered depending on the file extension.

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

## Links

### Relative links

Posts can be easily linked using:

```md
[some text]({% post_url 2016-09-13-my-jekyll-workflow-part1 %})
```

where `2016-09-13-my-jekyll-workflow-part1` is the filename in `_posts` dir without extension.

Anything else can be linked like:

```text
{% link static/postfiles/my-jekyll-workflow-part3/policy.txt %}
```

which specifies the full path from Jekyll root folder to the file, including filename and extension.

More details here: <https://mademistakes.com/mastering-jekyll/how-to-link/>.

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

Static media files are stored in `static` dir.

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

### SEO images in IFTTT RSS feed trigger

IFTTT may be used as a bridge between blog post publishing and social sharing. The SEO image is not part of the RSS feed, so an IFTTT *Make a web request* action is used to retrieve its URL via API. The action performs a `GET` request to `https://fpira.com/api/v1/ifttt/posts/latest`. The URL is then used in a filter code to set the image URL in next *Then* action.

Below there's a filter code example to set the image URL in a LinkedIn *Share an update with image* action.

```javascript
let imageURL = "https://fpira.com/assets/images/og_image.png";

if(MakerWebhooks.makeWebRequestQuery[0].StatusCode == "200" && MakerWebhooks.makeWebRequestQuery[0].Value3){
  imageURL = MakerWebhooks.makeWebRequestQuery[0].Value3;
}

Linkedin.shareImagePost.setPhotoUrl(imageURL)
```

Docs:

- [IFTTT - Why is there a “File not found” image on my post?](https://help.ifttt.com/hc/en-us/articles/115010361748/)

## Plugins

Apart from Jekyll plugins available as gems and declared in `Gemfile`, there are quite a few custom plugins in the `_plugins` folder. Not all code is mine, and some has been modified to fit my needs, but I've tried to give credit where it's due.

Most plugins are used to extend Jekyll functionalities, by adding new Liquid tags or filters, to edit the markdown conversion process, or to populate `site.data` with additional info (for example, with current git commit data).

### AddPostUpdateInfo

This plugin reorders the `post.updates` array and adds two property to each post:

- `most_recent_edit`: this is the most recent edit, which either the creation date or the last update date
- `most_recent_update`: this is the last update date, if any, otherwise it's null

## APIs

`api` folder contains an attempt to provide APIs out of a Jekyll website, being almost plugin-less, with plugins being part of this repository in `_plugins` dir.

APIs can be useful for integrations, e.g. I use `/api/v1/ifttt/posts/latest` to fetch details of the last published blog post from an RSS trigger on IFTTT.

### API docs

OpenAPI definition is available for `v1` in `/api/v1/openapi.yaml`. API documentation is generated as part of the website and available at `/api/docs` ([link](https://fpira.com/api/docs)).

## CMS

### Jekyll Post via Web

An early attempt was made using [vrypan/jekyll-post-via-web](https://github.com/vrypan/jekyll-post-via-web). But it was not maintained and too basic for my needs.

### prose.io

I tried to experience CMS-like functionality using [prose.io](https://prose.io).

Prose.io uses `_prose.yml` in the repo root. To provide a list of actual tags and categories available on the website two JSONP files are used, `jsonp/categories.jsonp` and `jsonp/tags.jsonp`.

### Notion-to-Jekyll

Looking for a CMS, I found Notion to be a good platform to build my own. But it required a way to convert Notion pages to Jekyll posts, so I built [notion-to-jekyll](https://github.com/pirafrank/notion-to-jekyll).

A Notion workspace is used to write drafts and publish them as Jekyll posts when ready. The conversion is done using notion-to-jekyll running on a daily scheduled [GitHub workflow](.github/workflows/notion_to_jekyll.yml).

notion-to-jekyll uses the Notion API to fetch pages and convert them to markdown files, as well download images and other assets. Finally, it commits and pushes changes to the repository via [github-commit-sign](https://github.com/marketplace/actions/github-commit-sign) action.

## Theming and dark mode

### Theming

```xml
<meta name="theme-color" content="#3344aa">
```

Links:

- [`theme-color`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta/name/theme-color)
- [Meta Theme Color and Trickery](https://css-tricks.com/meta-theme-color-and-trickery/)

## Further notes

`has_fa` variable is not used right now. Font-awesome is always loaded. Variables in front-matter are kept in case I change my mind and put an `if` in font-awesome loading in `head.html` file.

## License

Source code is released under GNU GPLv3 license. Any source code coming from other projects maintains its original license.

Website and blog content are released under Creative Commons Attribution-NonCommercial 4.0.

To know more about terms and license, please read the [terms](pages/pages/terms.md) page.
