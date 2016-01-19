---
layout: redirect
title: google+
permalink: /google+/
show_title: false
---

{% if site.social-links.googleplus %}

<META http-equiv="refresh" content="0;URL=https://plus.google.com/{{ site.social-links.googleplus }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url }}">

{% endif %}
