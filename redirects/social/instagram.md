---
layout: redirect
title: instagram
permalink: /instagram/
show_title: false
---

{% if site.social-links.instagram %}

<META http-equiv="refresh" content="0;URL=http://instagram.com/{{ site.social-links.instagram }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
