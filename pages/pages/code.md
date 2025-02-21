---
layout: page
title: Code
permalink: /code/
show_title: true
---

- [GitHub]({{ site.data.social.github.url }}?tab=repositories&q=&type=&language=&sort=)
- [Docker Hub]({{ site.data.social.docker.url }})
- [npm.js]({{ site.data.social.npmjs.url }})
- [crates.io]({{ site.data.social.crates.url }})
- [rubygems.org]({{ site.data.social.rubygems.url }})

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
