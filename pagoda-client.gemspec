# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "pagoda-client"
  s.version     = "0.0.1"
  s.authors     = ["Lyon"]
  s.email       = ["lyon@delorum.com"]
  s.homepage    = "http://www.pagodabox.com"
  s.summary     = %q{summary}
  s.description = %q{description}

  s.rubyforge_project = "pagoda-client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # testing dependencies
  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"
  # s.add_development_dependency "simplecov"


  # real dependencies
  s.add_dependency "rest-client"
  s.add_dependency "json_pure"


end
