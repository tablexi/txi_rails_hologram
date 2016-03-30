# TxiRailsHologram

## Overview

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

4. Render partials (or use helper methods that do, e.g. [kaminari](https://github.com/amatsuda/kaminari)):

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

## Installation

### Add the gem to your app

1. Add the following to your Rails application's `Gemfile`:

    ```ruby
    gem "txi_rails_hologram", github: "tablexi/txi_rails_hologram"
    ```

2. If you previously had hologram installed, remove it (and `guard-hologram`) from your `Gemfile`.
3. Run  `bundle install`.
4. Restart your server (if you had one running)

### Set up your Rails environment

1. Add a `hologram_config.yml` to the root of your Rails app. You can see the [options available here](https://github.com/trulia/hologram#creating-a-yaml-config-file). **NOTE:** you don't need to specify any of the following, as this gem handles it for you:
    - `code_example_templates`
    - `code_example_renderers`
    - `documentation_assets`
    - `name_scope`
    - `custom_extensions`
2. If you had previously been using hologram, you should remove these (they are now handled by this gem):
    - `app/assets/stylesheets/application-styleguide.scss`
    - `app/assets/javascripts/application-styleguide.js.coffee`
    - `styleguide_assets/templates`

### Add guard support (optional)

In `Guardfile`, add the following (replacing any existing "hologram" block):

```ruby
guard :txi_rails_hologram, wait: 50, run_on_all: false do
  watch(%r{app/assets/stylesheets/.*scss})
  watch(%r{styleguide_assets/content/.*md})
  watch("hologram_config.yml")
end
```

## Usage

Instead of using `bundle exec hologram`, you use `bundle exec rake txi_rails_hologram:build`

## Customization

### Assets

Since different projects load different assets (JS and CSS), you can specify what to load in your styleguide. Set the `styleguide_head` and/or `styleguide_foot` options in your `hologram_config.yml` to a path relative to your `Rails.root`, and this gem will read a [haml](http://haml.info/) file at that location in order to pick up the content.

Example:

```yaml
styleguide_head: ./styleguide/assets/_head.html.haml
```

```haml
-# styleguide/assets/_head.html.haml
= stylesheet_link_tag 'application'
```

If these options are not specified, this gem will use the default head and foot from `lib/assets/`.

### Header and Footer

If the default `_header.html` and `_footer.html` provided by this gem simply don't suit you at all, you can set `documentation_assets` in your `hologram_config.yml` to a local folder inside your Rails project. This gem will then use _those_ files, instead of the default ones it provides.

In those files, you can use _some_ helpers, just as you would in a normal Rails layout. See `lib/txi_rails_hologram/template_variables_ext.rb` for what's currently implemented.
