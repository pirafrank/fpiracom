---
layout: page
title: Code
permalink: /code/
show_title: true
toc_items:
  - Public registries
  - Projects
  - Utilities
  - Release Channels
  - Resources
  - External resources
---

{% include toc.html items = page.toc_items %}

## Public registries

- [Homebrew tap](https://github.com/pirafrank/homebrew-tap)
- [APT/YUM/APK repositories](https://pkg.fpira.com)
- [AURA](https://github.com/pirafrank/aura)
- [crates.io](https://crates.io/users/pirafrank)
- [npm.js](https://www.npmjs.com/~pirafrank)
- [rubygems.org](https://rubygems.org/profiles/pirafrank)
- [Docker Hub](https://hub.docker.com/u/pirafrank)

## Projects

Side projects I make in my spare time, feel free to fork me. Most recent listed
below.

{% assign projects = site.data.projects.projects | where: "maintained", true | where: "isArchived", false | sort: "creationDate" | reverse %}
{% for project in projects limit: 8 %}

**[{{ project.name }}]({{ project.homepage }})**<br>{{ project.description }}

<span class="link-chip"><a href="{{ project.repourl }}"><i class="fa-solid fa-code-branch" style="font-size: 0.9rem !important" aria-hidden="true"></i>&nbsp;Repo</a></span> {% for p in project.skills %}<span class="tag-chip">{{ p }}</span> {% endfor %}

{% endfor %}

Full list [here]({{ site.baseurl }}/projects).

## Scripts and snippets

- Scripts in [bin dotfiles]({{ site.data.social.github.url }}/dotfiles/tree/main/bin)
- [Zsh autoloaded functions]({{ site.data.social.github.url }}/dotfiles/tree/main/zsh/autoloaded)
- Snippets on [GitHub Gists]({{ site.data.social.github.gist }})

## Utilities

{% include partials/utilities.md %}

## Release Channels

Available on Telegram. Get a notification each time a new version is released.

- [OPNsense updates]({{ site.data.external.telegram-opnsense-updates }})
- [Apple Developer releases]({{ site.data.external.telegram-apple-dev-releases }})

## Resources

Additional pages you might find useful.

{% include partials/resources.md %}

## External resources

{% include partials/external-links.md %}
