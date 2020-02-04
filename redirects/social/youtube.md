---
layout: redirect
title: youtube
permalink: /youtube/
show_title: false
---

{% if site.social-links.youtube %}

<META http-equiv="refresh" content="0;URL=http://youtube.com/{{ site.social-links.youtube }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
