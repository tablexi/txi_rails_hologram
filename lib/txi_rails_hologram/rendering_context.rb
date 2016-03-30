require "haml"

module TxiRailsHologram

  # Public: A context for rendering HAML that knows about helpers from Rails,
  # gems and the current application.
  class RenderingContext

    # Internal: Creates a new context into which we can render a chunk of HAML.
    #
    # Returns a properly-configured instance of ActionView::Base.
    def self.create
      # Create a new instance of ActionView::Base that has all of the helpers
      # that our ApplicationController does. This allows us to use normal Rails
      # helpers like `link_to`, most gem-provided helpers, and also custom
      # application helpers like `svg_icon`.
      view_context = ApplicationController.helpers

      # Add named route support to our view context, so we can reference things
      # like `root_path`.
      class << view_context; include Rails.application.routes.url_helpers; end

      # Create a new controller instance and give it a fake request; this vaguely
      # mirrors what happens when Rails receives a request and routes it. This
      # step allows us to use `simple_form_for`.
      controller = ApplicationController.new
      controller.request = ActionDispatch::TestRequest.new
      view_context.request = controller.request

      # Set up our view paths so that both `render` and gems that provide helpers
      # that use `render` (e.g. kaminari) can work.
      controller.append_view_path "app/views"
      view_context.view_paths = controller.view_paths
      view_context.controller = controller


      # Add support for capturing HAML via the helpers module.
      class << view_context; include Haml::Helpers; end

      # This call is needed since we're outside the typical Rails setup. See:
      # https://github.com/haml/haml/blob/88110b0607efca433c13bb1e339dcb1131edf010/lib/haml/helpers.rb#L56-L70
      view_context.init_haml_helpers

      ViewContextWrapper.new(view_context)
    end
    private_class_method :create

    # Public: A Singleton instance of the context.
    def self.instance
      @instance ||= create
    end

    # Public: A decorator around an ActionView::Base object that provides some
    # custom functionality around loading assets that are specific to this
    # gem's host application. This allows us to account for variance in setup
    # of CSS and JS files across projects.
    class ViewContextWrapper < SimpleDelegator

      # Public: The content that should be loaded in the <head> for the
      # particular host application.
      #
      # Returns a String.
      def application_specific_styleguide_head
        render_assets(config["styleguide_head"], "lib/assets/_default_styleguide_head.html.haml")
      end

      # Public: The content that should be loaded in the foot (right before the
      # closing </body> tag) of the particular host application.
      #
      # Returns a String.
      def application_specific_styleguide_foot
        render_assets(config["styleguide_foot"], "lib/assets/_default_styleguide_foot.html.haml")
      end

      private

      # Internal: The configuration from the hologram_config.yml file of the
      # host application.
      #
      # Returns a Hash.
      def config
        @config ||= YAML.load(File.read(Rails.root.join("hologram_config.yml")))
      end

      # Internal: Renders the HAML content at the app_file_path or fallback_path.
      #
      # app_file_path - A String path relative to the host application's
      #                 Rails.root, e.g. `styleguide/assets/_head.html.haml`
      # fallback_path - A String path relative to the gem's root, e.g.
      #                 `lib/assets/_default_head.html.haml`
      #
      # Returns a String.
      def render_assets(app_file_path, fallback_path)
        if app_file_path
          content = File.read(Rails.root.join(app_file_path))
        else
          gem_path = Bundler.rubygems.find_name("txi_rails_hologram").first.full_gem_path
          content = File.read("#{gem_path}/#{fallback_path}")
        end

        engine = Haml::Engine.new(content)
        engine.render(self)
      end
    end

  end

end
