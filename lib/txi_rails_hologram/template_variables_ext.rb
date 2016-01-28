module TxiRailsHologram

  module TemplateVariablesExt

    def stylesheet_link_tag(*args)
      TxiRailsHologram::RenderingContext.instance.stylesheet_link_tag(*args)
    end

    def javascript_include_tag(*args)
      TxiRailsHologram::RenderingContext.instance.javascript_include_tag(*args)
    end

    def asset_path(*args)
      TxiRailsHologram::RenderingContext.instance.asset_path(*args)
    end

  end

end

Hologram::TemplateVariables.class_eval do
  include TxiRailsHologram::TemplateVariablesExt
end
