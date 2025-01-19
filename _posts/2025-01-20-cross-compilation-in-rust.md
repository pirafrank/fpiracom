---
title: "Cross compilation in Rust"
subtitle: "A practical guide to build Rust applications across multiple platforms both locally and on CI/CD pipelines"
description: "Learn how to configure your Rust development environment for cross compilation, enabling your applications to run smoothly on multiple platforms."
category: [ "How-tos" ]
tags: [ "Rust", "CI-CD" ]
seoimage: "3013/90363-rust-cross-compilation.jpg"
---

![Cross compile in Rust]({{ site.baseurl }}/static/postimages/3013/90363-rust-cross-compilation.jpg)

One of the advantages of Rust applications is the possibility to ship the same code across different targets, with many CPU architecture and operating systems setup supported as first-class citizen. In such scenario, cross compilation is a fundamental technique for developers who want their Rust applications to run on multiple platforms, as it would be highly unpractical to parallel develop and test on each of your targets. By configuring your development environment to target different architectures, you can build software that operates seamlessly across various systems, and by setting up CI/CD pipelines for cross compilation you can develop on one platform while building, testing, and shipping for all of them in an automated fashion.

In this article, I'll tell about how to move the first steps for cross compilation in Rust, address common challenges, and provide practical examples for a CI/CD environment.

### Context

Consider a binary Rust application, one like [appimage_updater](https://github.com/pirafrank/appimage_updater). We have a `rust-toolchain.toml` file with the following content:

```toml
# Rust Toolchain File

# Version of Rust to use
[toolchain]
channel = "stable"

# Run `rustup target add <target>` to install a target platform
[target]
targets = [
    "x86_64-unknown-linux-gnu",
    "aarch64-unknown-linux-gnu"
]
```

as I am coding on x86_64 arch but also want to cross compile to aarch64 to release for that platform as well.

### Option 1 (standard approach)

The first option is the standard one, which requires no extra tools and relies only on `cargo` and the usual compilation toolbelt for the target architecture. In this case, we need to install `aarch64-linux-gnu-gcc` linker (via your package manager, e.g. `sudo apt install gcc-aarch64-linux-gnu`). Then you need to create a file `.cargo/config.toml` and add the following content

```toml
[target.aarch64-unknown-linux-gnu]
linker = "aarch64-linux-gnu-gcc"
```

to tell cargo which linker to use then compile (for the aarch64 target in this case).

Now you can compile (on x86_64 arch) for both x86_64 and aarch64 by running:

```text
cargo build --target x86_64-unknown-linux-gnu
cargo build --target aarch64-unknown-linux-gnu
```

of course, I assume that on x86_64 you already have the necessary compile tools already installed.

### Option 2 (an easier approach via cross)

This approach uses `cross` and doesn’t require we to install a linker for the target platform. It will handle the underground work for us. It works using tailored-made Docker images, one per each target, for an easy setup that doesn’t require install tooling on the host.

`cross` requirements are [just a few](https://github.com/cross-rs/cross/wiki/Getting-Started) and it’s likely you already have them installed. They are:

- the Rust stable toolchain (which you can install via `rustup toolchain install stable`)
- a container engine, like `docker` or `podman`.

If you got them, you can install `cross` . Either install it from source using `cargo` by running:

```text
cargo install cross
```

or, if you have [cargo-binstall](https://github.com/cargo-bins/cargo-binstall), you can get the pre-built binary via:

```text
cargo binstall cross
```

Now, there’s no need to setup the project cargo config in `.cargo/config.toml` . We can just cross compile by replacing the word `cargo` with `cross` in the compilation commands we used earlier:

```text
cross build --target x86_64-unknown-linux-gnu
cross build --target aarch64-unknown-linux-gnu
```

### Going GitHub Actions

To cross compile on a GitHub Action, the process is pretty similar. You just need to setup the Rust stable toolchain, then install cross as you’d do locally. Considering I did not want to setup _cargo-binstall_ on the Action, I went with `cargo install`.

```yaml
  - name: Setup Rust
    uses: actions-rust-lang/setup-rust-toolchain@v1
    with:
      toolchain: stable

  - name: Setup cross toolchain
    run: cargo install cross

  - name: cross compile
    run: |
      cross build --release --target x86_64-unknown-linux-gnu
      cross build --release --target aarch64-unknown-linux-gnu
```

For a full setup, including a release pipeline with assets, please check my [Appimage Updater](https://github.com/pirafrank/appimage_updater/blob/e5b616af6466baa80fb16e3890fbfb5cc85ef7a3/.github/workflows/release.yml) project.

### A different GitHub Action approach

A different approach, one with more targets, may use a GitHub Action matrix configuration to compile on different runners with different host operating systems. It may help parallelizing the build and speed up CI and release pipelines.

Here's an example of a CI pipeline I built for one of my private projects that's still in development. For the sake of clarity, I put combinations of OS and targets I want to compile on on a separate file called `matrix.jsonc`.  Consider that GitHub Actions hosted runners have a limited set of available OS so cross compilation is needed.

```json
{% raw %}
{
    "include": [
        { "os": "ubuntu-latest", "target": "x86_64-unknown-linux-gnu" },
        { "os": "ubuntu-latest", "target": "aarch64-unknown-linux-gnu" },
        { "os": "ubuntu-latest", "target": "x86_64-unknown-linux-musl" },
        { "os": "ubuntu-latest", "target": "aarch64-unknown-linux-musl" },
        { "os": "ubuntu-latest", "target": "x86_64-unknown-freebsd" },
        { "os": "macos-latest", "target": "x86_64-apple-darwin" },
        { "os": "macos-latest", "target": "aarch64-apple-darwin" },
        { "os": "windows-latest", "target": "x86_64-pc-windows-gnu" },
        { "os": "windows-latest", "target": "x86_64-pc-windows-msvc" },
        { "os": "windows-latest", "target": "aarch64-pc-windows-msvc" }
    ]
}
{% endraw %}
```

The workflow file has a job called `make_matrix` to parse and process `matrix.jsonc`, which is then set as a output for later retrieval in the next `ci` job. The process configures tooling via [taiki-e/setup-cross-toolchain-action](https://github.com/taiki-e/setup-cross-toolchain-action), a GitHub Action for easy setup of toolchains for cross compilation and cross testing for Rust. Each combination of the matrix is an input of such step, sparking a dedicated parallel run. If any of those runs fails, other jobs are stopped and the whole workflow run quits on failure, as you would expect for a CI job.

```yaml
{% raw %}
name: CI

on:
  push:
    branches:
      - main
    paths:
      - .github/workflows/ci.yml
      - src/**
      - tests/**
      - build.rs
      - Cargo.toml
      - Cargo.lock
      - rust-toolchain.toml
      - matrix.json
  pull_request:
    branches:
      - main

jobs:
  make_matrix:
    runs-on: ubuntu-latest
    outputs:
      matrix: ${{ steps.set-matrix.outputs.matrix }}
    env:
      MATRIX_FILE: matrix.jsonc
    steps:
      - name: Clone repo
        uses: actions/checkout@v4
        with:
          fetch-depth: 1

      - id: set-matrix
        run: |
          echo "matrix=$(grep -v '//' $MATRIX_FILE | jq -c '.')" >> "$GITHUB_OUTPUT"

  ci:
    name: CI
    needs: make_matrix
    runs-on: ${{ matrix.os }}
    strategy:
      matrix: ${{fromJson(needs.make_matrix.outputs.matrix)}}
      max-parallel: 4
    steps:
      - name: Clone repo
        uses: actions/checkout@v4

      - name: Setup Rust
        uses: actions-rust-lang/setup-rust-toolchain@v1
        with:
          toolchain: stable

      - name: Install cross compilation tools
        uses: taiki-e/setup-cross-toolchain-action@v1
        with:
          target: ${{ matrix.target }}

      # setup-cross-toolchain-action sets the `CARGO_BUILD_TARGET` environment variable,
      # so there is no need for an explicit `--target` flag.
      - name: Build project
        run: cargo build

      - name: Test project
        # Skip tests on FreeBSD, because testing are not supported by cross on FreeBSD.
        # https://github.com/cross-rs/cross#supported-targets
        if: ${{ !contains(matrix.target, 'freebsd') && !contains(matrix.target, 'aarch64-pc-windows-msvc') }}
        run: cargo test --verbose

{% endraw %}
```

Note I made some adjustments to comply with the scenarios supported by _setup-cross-toolchain-action_. For example, `cargo test` is unsupported when compile for `freebsd` ([source](https://github.com/taiki-e/setup-cross-toolchain-action?tab=readme-ov-file#freebsd)) or for triple `aarch64-pc-windows-msvc` ([source](https://github.com/taiki-e/setup-cross-toolchain-action?tab=readme-ov-file#windows-msvc)) so I’ve disabled it.

### Wrapping up

Cross compiling Rust code can be achieved through multiple ways, from the standard `cargo`-based approach requiring manual setup of toolchains to more streamlined solutions using tools like `cross`, or dedicated GitHub Actions, each with its own advantages. While the standard approach offers more control and understanding of the underlying process, tools like cross and _setup-cross-toolchain-action_ significantly simplify the workflow, especially in CI/CD pipelines.

The choice between these methods depends on your specific needs: for local development, `cross` provides a clean containerized solution, while for automated builds GitHub Actions with matrix configurations offer scalable and parallel compilation across multiple targets and architectures.

I hope it helps. Thank for reading.
