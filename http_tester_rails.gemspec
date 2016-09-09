$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "http_tester_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "http_tester_rails"
  s.version     = HttpTesterRails::VERSION
  s.authors     = ["jiikko"]
  s.email       = ["n905i.1214@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of HttpTesterRails."
  s.description = "TODO: Description of HttpTesterRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
