---
layout: page
title: Projects
permalink: /projects/
show_title: true
toc_items:
  - Active
  - Supported
  - Experiments
  - Legacy
---

*Sorted by creation date, in descending order.*

<!--
Documentation for boolean flags below from projects.json in site.data:
active = "item.isArchived == false and item.maintained == true"
supported = "item.isArchived == true and item.maintained == true"
experiments = "item.isArchived == false and item.maintained == false"
legacy = "item.isArchived == true and item.maintained == false"
-->

{% include toc.html items = page.toc_items %}

## Active

Projects maintained and in active development.

{% assign projects = site.data.projects.projects |
where_exp: "item", "item.isArchived == false and item.maintained == true" |
sort: "creationDate" | reverse %}
{% for project in projects %}

### [{{ project.name }}]({{ project.homepage }})

{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Supported

Projects set to receive only maintenance updates.

{% assign maintenance = site.data.projects.projects |
where_exp: "item", "item.isArchived == true and item.maintained == true" |
sort: "creationDate" | reverse %}
{% for project in maintenance %}

### [{{ project.name }}]({{ project.homepage }})

{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Experiments

Experiments and projects not yet ready to be used daily.
They may or may not ever be.

{% assign experiments = site.data.projects.projects |
where_exp: "item", "item.isArchived == false and item.maintained == false" |
sort: "creationDate" | reverse %}
{% for project in experiments %}

### [{{ project.name }}]({{ project.homepage }})

{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Legacy

Archived and no more maintained projects.

{% assign legacy = site.data.projects.projects |
where_exp: "item", "item.isArchived == true and item.maintained == false" |
sort: "creationDate" | reverse %}
{% for project in legacy %}

### [{{ project.name }}]({{ project.homepage }})

{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

### [Scaleway client]({{site.data.social.github.url}}/scaleway_api)

Very simple Python module calling Scaleway APIs to create/manage/undeploy
virtual servers. I've created it for my own needs before `scw`, so today
you may want to use that instead.

### [electron-dash-docset]({{ site.data.social.github.url }}/electron-dash-docset)

A repository to generate a [Dash](https://kapeli.com/dash) docset for the
[electron](https://electron.atom.io) documentation. Now with automatic check
for new releases.

### [Workflow for iOS recipes]({{ site.baseurl }}/projects/workflow-ios/)

Recipes for the popular iOS app [Workflow](https://workflow.is/download).

### [Battery Life Extender]({{ site.baseurl }}/projects/ble)

The niblest solution of a battery life extender for OS X. Take care of your MacBook.

### [OS X utils]({{site.data.social.github.url}}/OSX_utils)

Collection of OS X utilities to speed up your productivity and take care of your
OS X environment.

### [Eye Relief]({{site.data.social.github.url}}/Eye_Relief)

A simple script trigged every 20 minutes reminds you to take a break. For OS X
10.8 and above.

### [Raspberrypi web panel]({{site.data.social.github.url}}/raspberrypi-web-panel)

A simple web panel to control your Raspberry Pi on a local network.

<br>

Thank you for reaching this page.
