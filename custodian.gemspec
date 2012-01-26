# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "custodian/version"

Gem::Specification.new do |s|
  s.name        = "custodian"
  s.version     = Custodian::VERSION
  s.authors     = ["Johannes Gorset"]
  s.email       = ["jgorset@gmail.com"]
  s.homepage    = "http://github.com/jgorset/custodian"
  s.summary     = "Lightweight resource monitor"
  s.description = "Custodian is a lightweight resource monitor that is easy to use and augment"

  s.rubyforge_project = "custodian"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "thin"
  s.add_runtime_dependency "active_support"
end
