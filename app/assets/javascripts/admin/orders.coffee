# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.js-create-order').click ->
    url = "/cases/#{$(@).data('id')}/categories"
    $.ajax
      url: url
      type: 'get'
      data_type: 'json'
      success: (data)->
        $('#modal1').html(data)
        M.Modal.getInstance($("#modal1")).open()
        $('.datepicker').datepicker({autoclose: true})
