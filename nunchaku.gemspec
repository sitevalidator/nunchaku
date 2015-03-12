# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nunchaku/version'

Gem::Specification.new do |spec|
  spec.name          = "nunchaku"
  spec.version       = Nunchaku::VERSION
  spec.authors       = ["Jaime Iniesta"]
  spec.email         = ["jaimeiniesta@gmail.com"]

  spec.summary       = %q{Ruby client for the Nu HTML Checker}
  spec.description   = %q{Ruby client to check HTML markup using the Nu HTML Checker at http://validator.w3.org/nu/}
  spec.homepage      = "https://github.com/sitevalidator/nunchaku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "httparty", "~> 0.13"

  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.2"
  spec.add_development_dependency "webmock", "~> 1.20"
end
