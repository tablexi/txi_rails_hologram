require "jquery-rails"

module TxiRailsHologram

  class Engine < ::Rails::Engine

    isolate_namespace TxiRailsHologram

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.assets false
      g.helper false
    end

    initializer "txi_rails_hologram.assets.precompile" do |app|
      app.config.assets.precompile += %w(jquery.js jquery_ujs.js)
    end

  end

end
