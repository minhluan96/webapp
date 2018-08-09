class window.ScrollToLoadView

  constructor: (view_url)->
    canLoadMore = true
    $(window).scroll ->
      if $(window).scrollTop() + $(window).height() >= $(document).height() - 130 && canLoadMore
        $('#preloader').show()
        canLoadMore = false
        page = parseInt($('#current-page').val()) + 1
        url = new URL(view_url)
        url.searchParams.set('page', page)
        url.searchParams.set('category_id', $('#category-control').data('category-id'))
        $.ajax
          url: url,
          success: (result)=>
            $('#filtered-products').append(result)
            $('#preloader').hide()
            canLoadMore = true
            if result == ''
              canLoadMore = false
        $('#current-page').val(page)

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

  $('.tab').click (e)->
    $('.tab').removeClass('active')
    $('.tab-content').hide()
    $(@).addClass('active')
    $($(@).data('target')).show()
