---
layout: redirect
title: angel
permalink: /angel/
show_title: false
---


{% if site.data.social.angel.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.angel.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
