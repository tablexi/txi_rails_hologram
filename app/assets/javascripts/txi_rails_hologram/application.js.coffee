#= require "jquery"

# Check margin setting and add class if margins are off.
marginsOff = localStorage["margins"] == "off"
$("body").addClass "is--full" if marginsOff

$ ->
  # Drawer Menu
  $(".sg--menu").on "click", ->
    $("body").toggleClass "is--navigation"

  # Toggle Margins
  $(".sg--margins").on "click", ->
    $("body").toggleClass "is--full"
    if Modernizr.localstorage
      if $("body").hasClass "is--full"
        localStorage.setItem "margins", "off"
      else
        localStorage.setItem "margins", "on"
