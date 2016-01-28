module TxiRailsHologram

  # Public: A context for rendering HAML that knows about helpers from Rails,
  # gems and the current application.
  #
  # NOTE: This is totally hacked together.
  class RenderingContext

    # Public: Creates a new context into which we can render a chunk of HAML.
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

      view_context
    end
    private_class_method :create

    # A Singleton instance of the context
    def self.instance
      @instance ||= create
    end

  end

end
