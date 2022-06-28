---
layout: redirect
title: linkedin
permalink: /linkedin/
show_title: false
---

{% if site.data.social.linkedin.url %}

<META http-equiv="refresh" content="0;URL={{ site.data.social.linkedin.url }}">

{% else %}

<META http-equiv="refresh" content="0;URL={{ site.url | append: site.baseurl }}">

{% endif %}
