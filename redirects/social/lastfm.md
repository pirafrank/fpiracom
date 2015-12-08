---
layout: redirect
title: lastfm
permalink: /lastfm/
show_title: false
---

{% if site.social-links.lastfm %}

<META http-equiv="refresh" content="0;http://www.last.fm/user/{{ site.social-links.lastfm }}">

{% else %}

<META http-equiv="refresh" content="0;URL=http://{{ site.url }}">

{% endif %}