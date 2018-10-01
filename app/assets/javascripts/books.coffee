# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $("a[data-remote]").on("ajax:success", (e, data, status, xhr) ->
    console.log('loaded')
    ).on "ajax:error", (e, xhr, status, error) ->
     console.log('ERROR')

  $('.rating_bar').starRating({
    starSize: 25,
    initialRating: 1,
    useFullStars: true,
    disableAfterRate: false,
    callback: (currentRating, $el) ->
      $('[name="review[rating]"]').val(currentRating)
  })

  currentQuantity = ->
    quantity = parseInt($(".egn_book_cart .quantity-input").val())
    return 1 if isNaN(quantity)
    quantity

  newQuantity = (quantity, delta) ->
    return 1 if quantity <= 1 && delta == -1
    quantity + delta

  checkQuantity = ->
    quantity = currentQuantity()
    return if quantity > 1
    $(this).val(1)

  $(".egn_book_cart .item-change-quantity").click (event) ->
    action = $(this).data('action')
    quantity = currentQuantity()
    delta = if action == "minus" then -1 else 1
    new_quantity = newQuantity(quantity, delta)
    
    $(".egn_book_cart .quantity-input").val(new_quantity)
    event.preventDefault()

  $(".egn_book_cart .quantity-input").change (event), checkQuantity

  $(".egn-read-more").click (event) ->
    $(this).hide()
    $('.full_txt_dots').hide()
    $('.full_txt').show()

