---
layout: redirect
title: dribbble
permalink: /dribbble/
show_title: false
---

{% if site.data.social.dribbble.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.dribbble.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
