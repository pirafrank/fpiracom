# Liquid filter to get only keys of an hash
# Usage: {{ some_hash | keys }}

module Jekyll
  module HashKeysFilter
    def keys(hash)
      return hash.keys
    end
  end
end

Liquid::Template.register_filter(Jekyll::HashKeysFilter)
