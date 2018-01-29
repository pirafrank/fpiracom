// note that {{ site.baseurl }}/ is not present

module.exports = {
  staticFileGlobs: [
    '_site/css/**/*.css',
    '_site/**/*.html',
    '_site/**/*.jpg',
    '_site/**/*.jpeg',
    '_site/**/*.png',
    '_site/js/**/*.js'
  ],
  stripPrefix: '_site',
}
