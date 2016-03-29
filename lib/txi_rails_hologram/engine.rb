require "jquery-rails"
require "hologram"
require "txi_rails_hologram/template_variables_ext"

module TxiRailsHologram

  # A mountable Rails engine that integrates Hologram with Rails.
  class Engine < ::Rails::Engine

    isolate_namespace TxiRailsHologram

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.assets false
      g.helper false
    end

    initializer "txi_rails_hologram.assets.precompile" do |app|
      app.config.assets.precompile += %w(jquery.js)
    end

  end

end
