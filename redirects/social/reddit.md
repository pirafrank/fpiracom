---
layout: redirect
title: reddit
permalink: /reddit/
show_title: false
---

{% if site.data.social.reddit.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.reddit.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
