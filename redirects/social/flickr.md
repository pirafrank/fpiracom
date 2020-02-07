---
layout: redirect
title: flickr
permalink: /flickr/
show_title: false
---

{% if site.social-links.flickr %}

<META http-equiv="refresh" content="0;URL=http://flickr.com/{{ site.social-links.flickr }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
