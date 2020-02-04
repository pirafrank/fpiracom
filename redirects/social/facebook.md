---
layout: redirect
title: facebook
permalink: /facebook/
show_title: false
---

{% if site.social-links.facebook %}

<META http-equiv="refresh" content="0;URL=http://facebook.com/{{ site.social-links.facebook }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
