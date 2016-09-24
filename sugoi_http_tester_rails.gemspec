$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sugoi_http_tester_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sugoi_http_tester_rails"
  s.version     = SugoiHttpTesterRails::VERSION
  s.authors     = ["jiikko"]
  s.email       = ["n905i.1214@gmail.com"]
  s.homepage    = "https://github.com/jiikko/sugoi_http_tester_rails"
  s.summary     = "Summary of HttpTesterRails."
  s.description = "Description of HttpTesterRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "> 4.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end
