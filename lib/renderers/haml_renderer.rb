require "txi_rails_hologram/rendering_context"
require "haml"

# We overwrite the default "haml" handler from hologram to use our Rails-aware
# version.
Hologram::CodeExampleRenderer::Factory.define "haml" do
  example_template "markup_example_template"
  table_template "markup_table_template"
  lexer { Rouge::Lexer.find("haml") }

  rendered_example do |code|
    haml_engine = Haml::Engine.new(code.strip)

    context = TxiRailsHologram::RenderingContext.instance
    haml_engine.render(context, {})
  end
end
