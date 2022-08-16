---
layout: redirect
title: pinterest
permalink: /pinterest/
show_title: false
---

{% if site.data.social.pinterest.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.pinterest.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
