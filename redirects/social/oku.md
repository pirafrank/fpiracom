---
layout: redirect
title: Oku
permalink: /oku/
show_title: false
---

{% if site.data.social.oku.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.oku.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
