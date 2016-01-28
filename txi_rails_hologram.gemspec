$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "txi_rails_hologram/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "txi_rails_hologram"
  s.version     = TxiRailsHologram::VERSION
  s.authors     = ["Dan Hodos"]
  s.email       = ["danhodos@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of TxiRailsHologram."
  s.description = "TODO: Description of TxiRailsHologram."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
end
