# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "jekyll-devto"
  spec.version = "0.1.0"
  spec.authors = ["Francesco"]
  spec.summary = "Generate Dev.to-compatible Markdown from Jekyll posts"
  spec.license = "MIT"
  spec.files = [
    "jekyll-devto.gemspec",
    "lib/jekyll-devto.rb",
    "lib/jekyll/devto.rb"
  ]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.0"
  spec.add_runtime_dependency "jekyll", ">= 4.4", "< 5.0"
end
