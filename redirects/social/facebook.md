---
layout: redirect
title: facebook
permalink: /facebook/
show_title: false
---

{% if site.data.social.facebook.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.facebook.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
