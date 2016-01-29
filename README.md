# TxiRailsHologram

This gem integrates [hologram](https://github.com/trulia/hologram) with [rails](https://github.com/rails/rails) for generating a [living style guide](http://alistapart.com/article/creating-style-guides).

This gem provides a Rails-aware [haml](http://haml.info/) renderer. This renderer allows code examples that

1. Use stock Rails helpers, e.g.

    ```haml
    = link_to("http://tablexi.com")
    ```

2. Use helper methods defined in gems, e.g.

    ```haml
    = simple_form_for :example, url: "#" do |f|
      = f.button :submit, "Submit Button"
    ```

3. Use helper methods defined in your application, e.g.

    ```ruby
    # app/helpers/application_helper.rb
    module ApplicationHelper
      def svg_icon(icon, options = {})
        content_tag :svg, class: "icon icon--#{icon} #{options[:class]}", viewBox: "0 0 100 100" do
          content_tag :use, "xlink:href": "##{icon}"
        end
      end
    end
    ```

    ```haml
    = svg_icon(:flag)
    ```

4. Render partials (or use helper methods that do, e.g. [kaminari]):

    ```haml
    -# app/views/shared/logo.html.haml
    = image_tag("logo.svg", class: "logo")
    ```

    ```haml
    = render "shared/logo"
    ```

5. Use named routes, e.g.:

    ```haml
    = root_path
    ```

## Quick Start

1. Add the following to your Rails application's `Gemfile`:

    ```ruby
    gem "txi_rails_hologram"
    ```

    and then run  `bundle`.

2. Add a `hologram_config.yml` to the root of your Rails app. You can see the [options available here](https://github.com/trulia/hologram#creating-a-yaml-config-file). **NOTE:** you don't need to specify any of the following, as this gem handles it for you:

    - `code_example_templates`
    - `code_example_renderers`
    - `documentation_assets`

3. Whenever you want to generate the styleguide, run `rake txi_rails_hologram:build` from your Rails app's root.

## Overrides

If the default `_header.html` and `_footer.html` provided by this gem don't suit you, you can set `documentation_assets` in your `hologram_config.yml` to a local folder inside your Rails project. This gem will then use those files, instead of the default ones it provides.

In those files, you can use _some_ helpers, just as you would in a normal Rails layout. See `lib/txi_rails_hologram/template_variables_ext.rb` for what's currently implemented.
