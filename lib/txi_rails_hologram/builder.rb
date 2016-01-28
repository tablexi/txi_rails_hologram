module TxiRailsHologram

  class Builder

    attr_accessor :defaults

    def initialize
      gem_path = Bundler.rubygems.find_name("txi_rails_hologram").first.full_gem_path
      self.defaults = {
        "code_example_renderers" => "#{gem_path}/lib/renderers",
        "code_example_templates" => "#{gem_path}/lib/templates",
        "documentation_assets" => "#{gem_path}/lib/assets",
      }.freeze
    end

    def build
      config = defaults.merge(YAML.load_file(Rails.root.join("hologram_config.yml")))
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
