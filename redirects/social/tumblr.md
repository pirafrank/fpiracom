---
layout: redirect
title: tumblr
permalink: /tumblr/
show_title: false
---

{% if site.data.social.tumblr.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.tumblr.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
