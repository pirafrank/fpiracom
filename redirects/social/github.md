---
layout: redirect
title: github
permalink: /github/
show_title: false
---

{% if site.data.social.github.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.github.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
