---
layout: redirect
title: instagram
permalink: /instagram/
show_title: false
---

{% if site.data.social.instagram.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.instagram.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
