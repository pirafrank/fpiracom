---
layout: redirect
title: slideshare
permalink: /slideshare/
show_title: false
---

{% if site.data.social.slideshare.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.slideshare.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
