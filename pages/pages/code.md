---
layout: page
title: Code
permalink: /code/
show_title: true
---

#### Public registries

- [Homebrew tap](https://github.com/pirafrank/homebrew-tap)
- [AURA](https://github.com/pirafrank/aura)
- [crates.io](https://crates.io/users/pirafrank)
- [npm.js](https://www.npmjs.com/~pirafrank)
- [rubygems.org](https://rubygems.org/profiles/pirafrank)
- [Docker Hub](https://hub.docker.com/u/pirafrank)
- [poof APT/Yum/APK repository](https://poof-pkgs.fpira.com)

#### Projects

Side projects I make in my spare time, feel free to fork me. Most recent listed below.

{% assign projects = site.data.projects.projects | where: "maintained", true | sort: "creationDate" | reverse %}
{% for project in projects limit: site.code.projects.limit %} - [{{ project.name }}]({{ project.homepage }}), {{ project.description }}
{% endfor %}

Full list [here]({{ site.baseurl }}/projects).

#### Utilities

{% include partials/utilities.md %}

#### Release Channels

Available on Telegram. Get a notification each time a new version is released.

- [OPNsense updates]({{ site.data.external.telegram-opnsense-updates }})
- [Apple Developer releases]({{ site.data.external.telegram-apple-dev-releases }})

#### Resources

Additional pages you might find useful.

{% include partials/resources.md %}

#### External resources

{% include partials/external-links.md %}
