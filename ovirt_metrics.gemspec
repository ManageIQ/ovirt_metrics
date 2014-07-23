# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ovirt_metrics/version'

Gem::Specification.new do |spec|
  spec.name          = "ovirt_metrics"
  spec.version       = OvirtMetrics::VERSION
  spec.authors       = ["Oleg Barenboim", "Jason Frey"]
  spec.email         = ["chessbyte@gmail.com", "fryguy9@gmail.com"]
  spec.description   = %q{OvirtMetrics is an ActiveRecord-based gem for reading the oVirt History database.}
  spec.summary       = %q{OvirtMetrics is an ActiveRecord-based gem for reading the oVirt History database.}
  spec.homepage      = "http://github.com/ManageIQ/ovirt_metrics"
  spec.license       = "MIT"

  spec.files         = `git ls-files -- lib/*`.split("\n")
  spec.files        += %w[README.md LICENSE.txt]
  spec.executables   = `git ls-files -- bin/*`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.test_files   += %w[.rspec]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "coveralls"

  spec.add_dependency "activerecord", "~> 3.2.0"
end
