# Filter docs
# https://jekyllrb.com/docs/plugins/filters/

module Jekyll
   module RegexMatch
    def regex_match(text, regex_str)
      return text.match?(%r[#{regex_str}])
    end
  end
end

Liquid::Template.register_filter(Jekyll::RegexMatch)
