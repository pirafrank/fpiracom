---
layout: redirect
title: soundcloud
permalink: /soundcloud/
show_title: false
---

{% if site.social-links.soundcloud %}

<META http-equiv="refresh" content="0;URL=https://soundcloud.com/{{ site.social-links.soundcloud }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
