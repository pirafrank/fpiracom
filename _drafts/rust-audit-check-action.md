---
title: "A smaller, more maintainable GitHub Action for auditing Rust dependencies"
subtitle: "Introducing Rust Audit Check Action, a focused alternative for running cargo-audit without unnecessary runtime dependencies"
description: "Rust Audit Check Action provides a small and maintainable way to run cargo-audit in GitHub Actions, avoiding Node.js runtime dependencies, Docker and additional reporting layers."
category: [ "Posts" ]
tags: [ "Rust", "GitHub", "CI-CD", "Security", "Tools" ]
seoimage: "3017/seo.jpg"
---

{% include image.html
url="/static/postimages/3017/001.jpg"
alt="An sample abstract image showing the phases of a GitHub workflow highlighted in the post below"
%}

I have just published **Rust Audit Check Action**, a small GitHub Action for
running `cargo audit` and detecting [RustSec](https://rustsec.org/) advisories
in Rust projects. The action is now available on the [GitHub Marketplace](https://github.com/marketplace/actions/rust-audit-check-action).

The basic workflow is intentionally straightforward:

```yaml
- uses: pirafrank/audit-check-action@v1
```

It installs `cargo-audit`, runs it against the project’s dependency lockfile,
and lets the command output and exit status determine whether the workflow succeeds
or fails.

That simplicity is the main feature.

## Why create another Rust audit action?

There are already established projects for integrating `cargo audit` into GitHub
Actions, particularly `rustsec/audit-check` and `actions-rust-lang/audit`.

However, GitHub Actions do not exist in a static environment. Actions that depend
on a specific JavaScript runtime, Docker image, GitHub API integration, or additional
reporting layer inherit the maintenance requirements of those components.

A recent example is the deprecation of Node.js 20 in GitHub Actions.
Node.js 20 reached end of life in April 2026, and GitHub Actions have already
moved to Node.js 24. This is not an unusual or unexpected change, but it means
maintainers of JavaScript-based actions must periodically update their runtime
declaration, dependencies, generated bundles, and test environments.

Users may otherwise start seeing deprecation warnings in workflows even when
the underlying tool they wanted to run—such as `cargo audit`—continues to work correctly.

Plain. Boring.

So I looked for an alternative that was less exposed to that kind of maintenance
cycle and ended up creating one.

## Focused on the core audit workflow

Rust Audit Check Action deliberately avoids several features:

* no Node.js runtime
* no Docker container
* no GitHub Checks API integration
* no automatic issue creation
* no additional reporting abstraction.

The action performs the minimum useful workflow:

1. install `cargo-audit`;
2. run it in the requested directory;
3. optionally pass advisory IDs to ignore;
4. return the original command output and exit status.

This makes the implementation easier to inspect and reduces the number of components
that can become deprecated independently of Rust or `cargo-audit`.

It also avoids trying to replace the configuration mechanisms already provided by
the underlying tool. For more advanced configuration, projects can commit an `audit.toml`
file and use the standard options supported by `cargo audit`. The `audit.toml` file
is read automatically by `cargo audit`, so no additional action input is required.

## Example workflow

Here's a complete workflow example. It runs audits when dependency files change,
on pull requests, on a schedule, and even manually:

```yaml
name: Security audit

on:
  push:
    paths:
      - "**/Cargo.toml"
      - "**/Cargo.lock"
      - "**/audit.toml"
  pull_request:
    paths:
      - "**/Cargo.toml"
      - "**/Cargo.lock"
      - "**/audit.toml"
  schedule:
    - cron: "0 0 * * *"
  workflow_dispatch:

jobs:
  audit:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v7

      - uses: actions-rust-lang/setup-rust-toolchain@v1
        with:
          toolchain: stable
          rustflags: ""

      - uses: pirafrank/audit-check-action@v1
```

Specific advisories can also be ignored when necessary:

```yaml
- uses: pirafrank/audit-check-action@v1
  with:
    ignore: RUSTSEC-2020-0036,RUSTSEC-2021-0145
```

The action also supports a `working-directory` input for monorepos and repositories
containing multiple Rust projects.

## A deliberately small open-source component

Not every action needs to become a complete security reporting platform.

Sometimes a GitHub Action only needs to connect an existing command-line tool
to a workflow while preserving the tool’s normal behaviour.

That is the approach behind Rust Audit Check Action: keep the integration small,
predictable and maintainable, while leaving vulnerability detection and configuration
to `cargo-audit` and the RustSec advisory database.

The project is open source under the MIT licence. Try it today on the
[GitHub Marketplace](https://github.com/marketplace/actions/rust-audit-check-action).
Feedback, issues and contributions are welcome.

Thanks for reading.
