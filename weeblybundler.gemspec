# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weeblybundler/version'

Gem::Specification.new do |spec|
  spec.name          = "weeblybundler"
  spec.version       = Weeblybundler::VERSION
  spec.authors       = ["Bryan Ashley"]
  spec.email         = ["bryan@weebly.com"]
  spec.summary       = %q{Used to for packaging and publishing Weebly platform App bundles}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['weeblybundle']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'rubyzip'
  spec.add_dependency 'rest-client'
  spec.add_dependency 'awesome_print'
  spec.add_dependency 'jwt'
  spec.add_dependency 'filewatcher'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
