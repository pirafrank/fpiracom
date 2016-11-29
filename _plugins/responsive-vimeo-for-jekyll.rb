#
# responsive-vimeo-for-jekyll.rb
#
# by Jeffrey Morgan (http://usabilityetc.com)
# and edited by Francesco Pira (fpira.com)
#
# support for Vimeo.
#
# Use Twitter Bootstrap's CSS to embed responsive videos
# or use your own CSS/SCSS
#
# Usage:
#
#   1. Copy this file into your Jekyll _plugins folder
#
#   2. Add the vimeo tag with a Vimeo video ID where you
#      want to embed the video
#
# Example:
#
#   {% vimeo 179689444 %}
#

module Jekyll
  class ResponsiveVimeoTag < Liquid::Tag
    def initialize(tag_name, markup, options)
      super
      @video_id = markup.strip
    end

    def render(context)
      %Q[
<div class="video-container">
    <div class="video-wrapper vimeo center">
        <iframe width="640" height="360" src="https://player.vimeo.com/video/#{@video_id}" frameborder="0" allowfullscreen></iframe>
    </div>
</div>
      ]
    end
  end
end

Liquid::Template.register_tag("vimeo", Jekyll::ResponsiveVimeoTag)
