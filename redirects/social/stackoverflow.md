---
layout: redirect
title: stackoverflow
permalink: /stackoverflow/
show_title: false
---

{% if site.data.social.stackoverflow.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.stackoverflow.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
