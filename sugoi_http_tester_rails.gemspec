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
  s.summary     = "Summary of SugoiHttpTesterRails."
  s.description = "Description of SugoiHttpTesterRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "> 4.2"
  s.add_dependency "sugoi_http_request_tester"
  s.add_dependency "kaminari"
  s.add_dependency "slim-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end
