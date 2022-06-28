---
layout: redirect
title: twitter
permalink: /twitter/
show_title: false
---

{% if site.data.social.twitter.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.twitter.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
