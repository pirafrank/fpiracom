---
layout: redirect
title: lastfm
permalink: /lastfm/
show_title: false
---

{% if site.data.social.lastfm.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.lastfm.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
