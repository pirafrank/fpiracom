---
layout: redirect
title: medium
permalink: /medium/
show_title: false
---

{% if site.data.social.medium.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.medium.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
