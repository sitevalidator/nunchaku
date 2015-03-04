# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nunchaku/version'

Gem::Specification.new do |spec|
  spec.name          = "nunchaku"
  spec.version       = Nunchaku::VERSION
  spec.authors       = ["Jaime Iniesta"]
  spec.email         = ["jaimeiniesta@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Ruby client for the Nu HTML Checker}
  spec.description   = %q{Ruby client to check HTML markup using the Nu HTML Checker at https://html5.validator.nu/}
  spec.homepage      = "https://github.com/sitevalidator/nunchaku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end