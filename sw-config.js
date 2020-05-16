// note that {{ site.baseurl }}/ is not present

module.exports = {
  staticFileGlobs: [
    "_site/index.html",
    "_site/assets/favicons/*.png",
    "_site/assets/icons/**/*.png",
    "_site/assets/icons/**/*.svg",
    "_site/assets/images/**/*.jpg",
    "_site/assets/pages/home.css",
    "_site/assets/js/*.js",
    "_site/style.css"
  ],
  stripPrefix: "_site",
};
