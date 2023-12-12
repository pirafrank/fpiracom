require 'digest'

module Jekyll
  module ToHashFilter
    def to_hash(input, algorithm)
      algorithm = algorithm.strip.downcase
      case algorithm
      when 'md5'
        hash = Digest::MD5.hexdigest(input)
      when 'sha1'
        hash = Digest::SHA1.hexdigest(input)
      when 'sha256'
        hash = Digest::SHA256.hexdigest(input)
      else
        # fallback
        hash = input
      end
      return hash
    end
  end
end

Liquid::Template.register_filter(Jekyll::ToHashFilter)
