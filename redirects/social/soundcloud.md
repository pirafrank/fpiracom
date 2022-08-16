---
layout: redirect
title: soundcloud
permalink: /soundcloud/
show_title: false
---

{% if site.data.social.soundcloud.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.soundcloud.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
