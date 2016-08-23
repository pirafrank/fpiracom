#
# responsive-youtube-for-jekyll.rb
#
# by Jeffrey Morgan (http://usabilityetc.com)
# and edited by Francesco Pira (fpira.com)
#
# support for YouTube.
#
# Use Twitter Bootstrap's CSS to embed responsive YouTube videos
# or use your own CSS/SCSS
#
# Usage:
#
#   1. Copy this file into your Jekyll _plugins folder
#
#   2. Add the youtube tag with a YouTube video ID where you
#      want to embed the video
#
# Example:
#
#   {% ted catherine_bracy_why_good_hackers_make_good_citizens %}
#

module Jekyll
  class ResponsiveTedTag < Liquid::Tag
    def initialize(tag_name, markup, options)
      super
      @video_id = markup.strip
    end

    def render(context)
      %Q[
<div class="video-container">
    <div class="video-wrapper widescreen center">
        <iframe width="640" height="360" src="https://embed-ssl.ted.com/talks/#{@video_id}.html/" frameborder="0" allowfullscreen></iframe>
    </div>
</div>
      ]
    end
  end
end

Liquid::Template.register_tag("ted", Jekyll::ResponsiveTedTag)
