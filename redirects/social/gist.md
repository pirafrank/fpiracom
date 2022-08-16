---
layout: redirect
title: gist
permalink: /gist/
show_title: false
---

{% if site.data.social.github.gist %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.github.gist }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
