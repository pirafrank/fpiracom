---
layout: redirect
title: pocket
permalink: /pocket/
show_title: false
---

{% if site.data.social.pocket.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.pocket.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
