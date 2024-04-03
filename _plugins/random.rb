module Jekyll
  class RandomIntTag < Liquid::Tag
    def initialize(tag_name, text, opts)
      super
      @text = text.strip
    end

    def render(context)
      min, max = @text.split(',').map(&:to_i)
      rand(min..max).to_s
    end
  end
end

Liquid::Template.register_tag('random', Jekyll::RandomIntTag)
