# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "turbolinks:load", ->
  $("input[type='checkbox'].egn-use_billing").click (event) ->
    return $(".egn-shipping-block").slideUp() if $(this).prop('checked')
    $(".egn-shipping-block").slideDown()

