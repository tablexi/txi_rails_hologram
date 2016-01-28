$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "txi_rails_hologram/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "txi_rails_hologram"
  s.version     = TxiRailsHologram::VERSION
  s.authors     = ["Dan Hodos"]
  s.email       = ["danhodos@gmail.com"]
  s.homepage    = "https://github.com/tablexi/txi_rails_hologram"
  s.summary     = "Summary of TxiRailsHologram."
  s.description = "Description of TxiRailsHologram."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "hologram", "~> 1.4"
  s.add_dependency "haml"
  s.add_dependency "coffee-script"
  s.add_dependency "sass"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
