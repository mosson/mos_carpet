# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mos_carpet/version'

Gem::Specification.new do |spec|
  spec.name          = "mos_carpet"
  spec.version       = MosCarpet::VERSION
  spec.authors       = ["mosson"]
  spec.email         = ["cucation@gmail.com"]
  spec.summary       = 'redcarpet wrapper for custom post-processes.'
  spec.description   = 'redcarpet wrapper for custom post-processes.'
  spec.homepage      = "https://github.com/mosson/mos_carpet"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
