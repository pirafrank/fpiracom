---
layout: page
name: version
title: version info
permalink: /version
show_title: true
---

---|---
Built date|{{ "now" | date: "%d %B %Y %H:%M:%S %Z" }}
Last commit hash|[{{ page.git_commit_hash }}]({{ site.data.social.github.url }}/fpiracom/commit/{{ page.git_commit_hash }})
Last commit date|{{ page.git_commit_date | date: "%d %B %Y %H:%M:%S %Z" }}
Last commit branch|[{{ page.git_branch }}]({{ site.data.social.github.url }}/fpiracom/tree/{{ page.git_branch }})
