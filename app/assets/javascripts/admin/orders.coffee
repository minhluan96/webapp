# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->
  $('.js-create-order').click ->
    url = "/admin/cases/#{$(@).data('id')}/categories"
    $.ajax
      url: url
      type: 'get'
      data_type: 'json'
      success: (data)->
        $('#modal1').html(data)
        M.Modal.getInstance($("#modal1")).open()
        $('.datepicker').datepicker({autoclose: true, format: 'dd/mm/yyyy'})

  $('.js-remove-order').click ->
    url = "/admin/cases/#{$(@).data('id')}/get_orders"
    $.ajax
      url: url
      type: 'get'
      data_type: 'json'
      success: (data)->
        $('#modal1').html(data)
        M.Modal.getInstance($("#modal1")).open()