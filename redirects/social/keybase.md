---
layout: redirect
title: keybase
permalink: /keybase/
show_title: false
---

{% if site.data.social.keybase.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.keybase.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
