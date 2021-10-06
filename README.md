# fpira.com source code

[![deploy_fpiracom](https://github.com/pirafrank/fpiracom/actions/workflows/deploy_fpiracom.yml/badge.svg?branch=main)](https://github.com/pirafrank/fpiracom/actions/workflows/deploy_fpiracom.yml)

Visit [fpira.com](https://fpira.com) for a live version.

## About the website code

This Jekyll instance is a completely overhauled fork of [Jekyll Now](https://github.com/barryclark/jekyll-now) with new design and many more features.

## Content License

To know about terms and license, please read the `terms.md` file in `pages/pages`.

Source code is released under the terms of GNU GPLv3 license.

## Important notes

Static resources (like post images, project page images and files) are NOT hosted here. They're hosted in *fpiracom_static* repo.

In order to have static files and images working when running `jekyll serve`, you need to clone that repo and creat a symlink named `static` pointing to the _static_ subfolder in it. The symlink must be in this repo root and it is already excluded by `.gitignore`.

Look at the example below.

### Example

```sh
ln -s /path/to/fpira.com_static/static /path/to/pirafrank.github.io/static
```

## Further notes

`has_fa` variable is not used right now. Font-awesome is always loaded. Variables in front-matter are kept in case I change my mind and put an `if` in font-awesome loading in `head.html` file.
