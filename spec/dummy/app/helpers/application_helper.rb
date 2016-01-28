# Public: A place to store small view-related functions.
module ApplicationHelper

  # Public: Outputs the text in a `strong` tag.
  #
  # text - A String.
  #
  # Returns a String of HTML.
  def strong_text(text)
    content_tag(:strong, text)
  end

end
