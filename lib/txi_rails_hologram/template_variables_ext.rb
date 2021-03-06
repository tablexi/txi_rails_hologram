# The `Hologram::TemplateVariables` is used as the context object when
# rendering ERb in the `DocBuilder`'s `write_docs` method. We monkey-patch it
# to allow the usage of some general layout-related Rails helper methods in our
# ERb documentation assets.
Hologram::TemplateVariables.class_eval do
  extend Forwardable

  def_delegators(
    "TxiRailsHologram::RenderingContext.instance",

    # Rails-specific:
    :stylesheet_link_tag,
    :javascript_include_tag,
    :asset_path,

    # Our own custom functionality:
    :application_specific_styleguide_head,
    :application_specific_styleguide_foot,
  )
end
