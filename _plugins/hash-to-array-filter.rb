# Liquid filter to convert an Hash to an Array
# Usage: {{ some_hash | hash_to_array }}

module Jekyll
  module HashToArrayFilter
    def hash_to_array(hash)
      hash.map do |key, value|
        { 'id' => key }.merge(value)
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::HashToArrayFilter)
