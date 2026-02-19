---
layout: page
title: Code
permalink: /code/
show_title: true
---

- [Homebrew tap](https://github.com/pirafrank/homebrew-tap)
- [AURA](https://github.com/pirafrank/aura)
- [crates.io](https://crates.io/users/pirafrank)
- [npm.js](https://www.npmjs.com/~pirafrank)
- [rubygems.org](https://rubygems.org/profiles/pirafrank)
- [Docker Hub](https://hub.docker.com/u/pirafrank)

#### Projects

Side projects I make in my spare time. Code is available on Github, feel free to fork me.

Most recent listed below.

{% assign projects = site.data.projects.projects | where: "maintained", true | sort: "creationDate" | reverse %}
{% for project in projects limit: site.code.projects.limit %} - [{{ project.name }}]({{ project.homepage }}), {{ project.description }}
{% endfor %}

Full list [here]({{ site.baseurl }}/projects).

#### Utilities

{% include partials/utilities.md %}

#### Resources

{% include partials/resources.md %}

#### External resources

{% include partials/external-links.md %}
