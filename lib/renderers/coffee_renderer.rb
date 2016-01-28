require "coffee-script"

Hologram::CodeExampleRenderer::Factory.define("coffee") do
  example_template "coffee_example_template"

  lexer { Rouge::Lexer.find(:coffee) }

  rendered_example do |code|
    CoffeeScript.compile(code)
  end
end
