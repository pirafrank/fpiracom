# Liquid filter to group by a property which is an array of strings
# Usage: {{ some_hash | group_by_array_prop: 'some_property' }}

module Jekyll
  module GroupByArrayPropertyFilter
    def group_by_array_prop(arr, prop)
      result = {}
      arr.each do |hash|
        if hash.key?(prop)
          hash[prop].each do |item|
            result[item] ||= []
            result[item] << hash
          end
        end
      end
      result
    end

  end
end

Liquid::Template.register_filter(Jekyll::GroupByArrayPropertyFilter)
