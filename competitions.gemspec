# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'competition/version'

Gem::Specification.new do |spec|
  spec.name          = "competitions"
  spec.version       = Competitions::VERSION
  spec.authors       = ["Oleksii Fedorov"]
  spec.email         = ["waterlink000@gmail.com"]
  spec.summary       = %q{Predicts how person will do in competition}
  spec.description   = %q{Predicts how person will do in competition}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "contracts", "< 2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
