---
layout: redirect
title: flickr
permalink: /flickr/
show_title: false
---

{% if site.data.social.flickr.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.flickr.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
