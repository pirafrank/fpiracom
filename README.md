# fpira.com source code

[fpira.com](http://fpira.com)

### About the website code

This Jekyll instance is a completely overhauled fork of [Jekyll Now](https://github.com/barryclark/jekyll-now) with new design and many more features. A complete list of them is available [here]().

### Content License

To know about terms and license, please read the `terms.md` file in `pages/pages`.

Source code is released under the terms of GNU GPLv3 license.

### Important notes

Static resources (like post images, project page images and files) are NOT hosted here. They're hosted in *fpiracom_static* repo.

In order to have previews with images and those files when running `jekyll serve`, also clone that repo and symlink `static` subfolder in that repo to the root here.

Note that `static` symlink or dir is already excluded in this repo `.gitignore`.

Look at the example below.

**Example**

```
ln -s /path/to/fpira.com_static/static /path/to/pirafrank.github.io/static
```
### Further notes

`has_fa` variable is not used right now. Font-awesome is always loaded. Variables in front-matter are kept in case I change my mind and put an `if` in font-awesome loading in `head.html` file.
