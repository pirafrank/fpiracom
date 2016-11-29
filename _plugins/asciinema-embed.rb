#
# asciinema-embed.rb
#
# by Jeffrey Morgan (http://usabilityetc.com)
# and edited by Francesco Pira (fpira.com)
#
# support for Asciinema.
#
# Usage:
#
#   1. Copy this file into your Jekyll _plugins folder
#
#   2. Add the asciinema tag with a Asciinema cast ID where you
#      want to embed the video
#
# For example, to embed the video with the link
# https://asciinema.org/a/1234
# use the following tag:
#
#   {% asciinema 1234 %}
#

module Jekyll
  class AsciinemaEmbedTag < Liquid::Tag
    def initialize(tag_name, markup, options)
      super
      @video_id = markup.strip
    end

    def render(context)
      %Q[
<script type="text/javascript" src="https://asciinema.org/a/#{@video_id}.js" id="asciicast-#{@video_id}" async></script>
      ]
    end
  end
end

Liquid::Template.register_tag("asciinema", Jekyll::AsciinemaEmbedTag)
