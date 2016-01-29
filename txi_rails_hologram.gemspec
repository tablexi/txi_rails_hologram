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
  s.summary     = "Living style guides using Hologram and Rails"
  s.description = "Allows Rails-aware rendering in Hologram documentation, allowing the use of helpers and other Rails-related Ruby shenanigans."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "hologram", "~> 1.4"
  s.add_dependency "haml"
  s.add_dependency "coffee-script"
  s.add_dependency "sass"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "microformats_helper"
end
