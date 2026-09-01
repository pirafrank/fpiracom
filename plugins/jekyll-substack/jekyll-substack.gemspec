# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "jekyll-substack"
  spec.version = "0.1.0"
  spec.authors = ["Francesco Pira"]
  spec.email = ["dev@fpira.com"]

  spec.summary = "Substack Jekyll exporter plugin"
  spec.description = "Generates Substack-ready Markdown and API payloads from Jekyll posts."
  spec.homepage = "https://fpira.com"
  spec.license = "MIT"

  spec.files = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 4.0"
  spec.add_dependency "kramdown", ">= 2.0"
end
