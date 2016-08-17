# Francesco Pira's website repository

[fpira.com](http://fpira.com)

### About the website code

Website code is based on Jekyll Blue. Please, head over [its repository]() if you like it.

### Content License

The content of the website, which is also part of this repository as it's hosted by Github Pages, is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

### Important notes

Post images and project page images are NOT hosted here. They're hosted in *fpiracom_static_backup* repo. In order to have previews with images when running `jekyll serve`, also clone that repo and symlink `postimages` and `projectimages` folders here. Look at the example below.

**Example**

```
ln -s /path/to/static_repo/postimages/ /path/to/this_repo/assets/postimages/
```

and

```
ln -s /path/to/static_repo/projectimages/ /path/to/this_repo/assets/projectimages/
```
