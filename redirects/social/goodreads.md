---
layout: redirect
title: goodreads
permalink: /goodreads/
show_title: false
---

{% if site.social-links.goodreads %}

<META http-equiv="refresh" content="0;URL=https://www.goodreads.com/{{ site.social-links.goodreads }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
