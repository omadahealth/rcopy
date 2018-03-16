# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rcopy/version"

Gem::Specification.new do |spec|
  spec.name          = "rcopy"
  spec.version       = Rcopy::VERSION
  spec.authors       = ["Chris Constantine"]
  spec.email         = ["chris@omadahealth.com"]

  spec.summary       = %q{Copy yur redis}
  spec.description   = %q{Copies keys from one redis to another.}
  spec.homepage      = "https://github.com/omadahealth/rcopy"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis", "~> 4.0"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "package_cloud"


end
