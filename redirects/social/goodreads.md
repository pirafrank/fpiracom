---
layout: redirect
title: goodreads
permalink: /goodreads/
show_title: false
---

{% if site.data.social.goodreads.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.goodreads.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
