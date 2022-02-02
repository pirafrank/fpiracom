---
layout: page
name: version
title: version info
permalink: /version/
show_title: true
sitemap: false
in_search: false
---

---|---
Built date|{{ "now" | date: "%d %B %Y %H:%M:%S %Z" }}
Last commit hash|[{{ site.data.git.commit_hash }}]({{ site.data.social.github.url }}/fpiracom/commit/{{ site.data.git.commit_hash }})
Last commit date|{{ site.data.git.commit_date | date: "%d %B %Y %H:%M:%S %Z" }}
Last commit branch|[{{ site.data.git.branch }}]({{ site.data.social.github.url }}/fpiracom/tree/{{ site.data.git.branch }})
