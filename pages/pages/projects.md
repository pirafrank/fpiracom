---
layout: page
title: Projects
permalink: /projects/
show_title: true
toc_items:
  - Public registries
  - Pinned
  - Active
  - Supported
  - Experiments
  - Legacy
---

{% assign not_featured = site.data.projects.projects |
where_exp: "item", "item.isFeatured == false" %}

Open-source projects I develop and maintain in my spare time.

All sorted by creation date, in descending order.

<!--
Documentation for boolean flags below from projects.json in site.data:
active = "item.isArchived == false and item.maintained == true"
supported = "item.isArchived == true and item.maintained == true"
experiments = "item.isArchived == false and item.maintained == false"
legacy = "item.isArchived == true and item.maintained == false"
-->

{% include toc.html items = page.toc_items %}

## Public registries

Projects in this page may be available for download from one or more of these public registries.

- [Homebrew tap](https://github.com/pirafrank/homebrew-tap)
- [APT/YUM/APK repositories](https://pkg.fpira.com)
- [AURA](https://github.com/pirafrank/aura)
- [crates.io](https://crates.io/users/pirafrank)
- [npm.js](https://www.npmjs.com/~pirafrank)
- [rubygems.org](https://rubygems.org/profiles/pirafrank)
- [Docker Hub](https://hub.docker.com/u/pirafrank)

## Pinned

Featured project maintained and in active development.

{% assign featured_projects = site.data.projects.projects |
where_exp: "item", "item.isFeatured == true" |
sort: "creationDate" | reverse %}
{% for project in featured_projects %}

**[{{ project.name }}]({{ project.homepage }})**<br>{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Active

More projects maintained and in active development.

{% assign projects = not_featured |
where_exp: "item", "item.isArchived == false and item.maintained == true" |
sort: "creationDate" | reverse %}
{% for project in projects %}

**[{{ project.name }}]({{ project.homepage }})**<br>{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Supported

Projects set to receive only maintenance updates.

{% assign maintenance = not_featured |
where_exp: "item", "item.isArchived == true and item.maintained == true" |
sort: "creationDate" | reverse %}
{% for project in maintenance %}

**[{{ project.name }}]({{ project.homepage }})**<br>{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Experiments

Experiments and projects not yet ready to be used daily.
They may or may not ever be.

{% assign experiments = not_featured |
where_exp: "item", "item.isArchived == false and item.maintained == false" |
sort: "creationDate" | reverse %}
{% for project in experiments %}

**[{{ project.name }}]({{ project.homepage }})**<br>{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

## Legacy

Older projects are available in the [Legacy]({{ site.baseurl }}/projects/legacy/) page.

---

Visit the [Code]({{ site.baseurl }}/code) page to discover scripts, tools and utilities.

Thank you for reaching this page.
