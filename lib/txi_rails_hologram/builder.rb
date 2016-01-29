module TxiRailsHologram

  # Public: A thin wrapper around `Hologram::DocBuilder` that allows us to
  # specify our own set of renderers, templates, and documentation assets.
  class Builder

    # Internal: A set of default options to pass to `Hologram::DocuBuilder`.
    # These can be overwritten in the Rails app's `hologram_config.yml` file.
    attr_reader :defaults

    # Public: Initialize this object.
    def initialize
      gem_path = Bundler.rubygems.find_name("txi_rails_hologram").first.full_gem_path
      @defaults = {
        "code_example_renderers" => "#{gem_path}/lib/renderers",
        "code_example_templates" => "#{gem_path}/lib/templates",
        "documentation_assets" => "#{gem_path}/lib/assets",
      }.freeze
    end

    # Public: Build the hologram docs using the Rails app's configuration.
    #
    # config - A Hash containing config options for the `Hologram::DocBuilder`.
    #          NOTE: hologram expects String keys.
    #
    # Returns nothing.
    def build(config)
      config = defaults.merge(config)
      config["config_yml"] = config

      config["renderer"] = Hologram::Utils.get_markdown_renderer(config["custom_markdown"])
      config["base_path"] = "."

      builder = Hologram::DocBuilder.new(config)

      if builder.is_valid?
        builder.build
      else
        $stderr.puts builder.errors
      end
    end

  end

end
