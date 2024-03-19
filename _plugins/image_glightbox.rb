module Jekyll
  module Converters
    class Markdown < Converter

      def convert_line(line)
        if line.is_a?(String) && line.start_with?('![')
          line.gsub!(/\!\[(.*?)\]\((.*?)\)/,
            '<a href="\2" class="glightbox"><img src="\2" alt="\1"></a>'
          )
        end
        line
      end

      def convert(content)
        content.lines.collect {|line| convert_line(line) }.join
      end

    end
  end
end
