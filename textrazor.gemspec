# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'textrazor/version'

Gem::Specification.new do |spec|
  spec.name          = "text_razor"
  spec.version       = TextRazor::VERSION
  spec.authors       = ["Anuj Dutta"]
  spec.email         = ["anuj@andhapp.com"]
  spec.description   = %q{Api wrapper for text razor}
  spec.summary       = %q{An api wrapper for text razor in ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"
  spec.add_dependency "fast_open_struct"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
