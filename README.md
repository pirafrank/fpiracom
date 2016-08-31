# Francesco Pira's website repository

[fpira.com](http://fpira.com)

### About the website code

Website code is based on Jekyll Blue. Please, head over [its repository]() if you like it.

### Content License

The content of the website, which is also part of this repository as it's hosted by Github Pages, is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

### Important notes

Static resources (like post images, project page images and files) are NOT hosted here. They're hosted in *fpiracom_static* repo.

In order to have previews with images and those files when running `jekyll serve`, also clone that repo and symlink `static` subfolder in that repo to the root here.

Note that `static` symlink or dir is already excluded in this repo `.gitignore`.

Look at the example below.

**Example**

```
ln -s /path/to/fpira.com_static/static /path/to/pirafrank.github.io/static
```
