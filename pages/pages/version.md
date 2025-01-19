---
layout: page
name: version
title: Current website version
permalink: /version/
show_title: true
sitemap: false
in_search: false
---

---|---
Built date|{{ "now" | date: "%d %B %Y %H:%M:%S %Z" }}
Jekyll version|{{ jekyll.version }}
Jekull plugins|{{ site.plugins | join: ', ' }}
Last commit hash|[{{ site.data.git.commit_hash | slice: 0, 7 }}]({{ site.data.social.github.url }}/fpiracom/commit/{{ site.data.git.commit_hash }})
Last commit date|{{ site.data.git.commit_date | date: "%d %B %Y %H:%M:%S %Z" }}
Last commit branch|[{{ site.data.git.branch }}]({{ site.data.social.github.url }}/fpiracom/tree/{{ site.data.git.branch }})
