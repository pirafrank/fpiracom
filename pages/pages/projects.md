---
layout: page
title: Projects
permalink: /projects/
show_title: true
custom_css: "pages/projects"
pinned_text: Featured
public_registries_text: Public registries
---

{% assign projects = site.data.projects.projects |
where_exp: "item", "item.isArchived != true or item.maintained != false" |
sort: "creationDate" | reverse %}
{% assign project_groups = projects | group_by: "group" | sort: "name" %}
{% assign project_group_names = project_groups | map: "name" %}
{% assign toc_items = project_group_names | unshift: page.pinned_text | unshift: page.public_registries_text | push: "Legacy" %}

Open-source projects I develop and maintain in my spare time.

Grouped by category and sorted by creation date, in descending order.

<!--
Documentation for boolean flags below from projects.json in site.data:
active = "item.isArchived == false and item.maintained == true"
supported = "item.isArchived == true and item.maintained == true"
experiments = "item.isArchived == false and item.maintained == false"
legacy = "item.isArchived == true and item.maintained == false"
-->

{% include toc.html items = toc_items %}

## {{ page.public_registries_text }}

Projects in this page may be available for download from one or more of these public registries.

- [Homebrew tap](https://github.com/pirafrank/homebrew-tap)
- [APT/YUM/APK repositories](https://pkg.fpira.com)
- [AURA](https://github.com/pirafrank/aura)
- [crates.io](https://crates.io/users/pirafrank)
- [npm.js](https://www.npmjs.com/~pirafrank)
- [rubygems.org](https://rubygems.org/profiles/pirafrank)
- [Docker Hub](https://hub.docker.com/u/pirafrank)

## {{ page.pinned_text }}

{% assign featured_projects = site.data.projects.projects |
where_exp: "item", "item.isFeatured == true" |
sort: "creationDate" %}
<div class="pinned-project-grid">
{% for project in featured_projects %}
  {% assign project_image = project.image | default: '/assets/pages/project-placeholder.svg' %}
  <article class="pinned-project-card">
    <a class="pinned-project-image-link darkmode-ignore" href="{{ project.homepage }}" aria-label="{{ project.name }}">
      <div class="pinned-project-image" style="background-image: url('{{ project_image | relative_url }}');" aria-hidden="true"></div>
    </a>
    <div class="pinned-project-content">
      <h3><a href="{{ project.homepage }}">{{ project.name }}</a></h3>
      <p>{{ project.description }}</p>
    </div>
    <div class="pinned-project-chips">
      <span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span>
      {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}
    </div>
  </article>
{% endfor %}
</div>

{% for project_group in project_groups %}

## {{ project_group.name }}

{% for project in project_group.items %}

**[{{ project.name }}]({{ project.homepage }})**<br>{{ project.description }}

<div class="project-chips"><span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span>{% for p in project.skills %}<span class="tag-chip">{{ p }}</span>{% endfor %}</div>

{% endfor %}

{% endfor %}

## Legacy

Older projects are available in the [Legacy]({{ site.baseurl }}/projects/legacy/) page.

---

Visit the [Code]({{ site.baseurl }}/code) page to discover scripts, tools and utilities.

Thank you for reaching this page.
