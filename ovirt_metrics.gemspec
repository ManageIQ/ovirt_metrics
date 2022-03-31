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
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.test_files   += %w[.rspec]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.8"

  spec.add_dependency "activerecord", ">=5.0", "<7.0"
  spec.add_dependency "pg"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "manageiq-style"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",         ">= 3.0"
  spec.add_development_dependency "simplecov",     ">= 0.21.2"
  spec.add_development_dependency "sqlite3"
end
