---
layout: redirect
title: youtube
permalink: /youtube/
show_title: false
---

{% if site.data.social.youtube.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.youtube.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
