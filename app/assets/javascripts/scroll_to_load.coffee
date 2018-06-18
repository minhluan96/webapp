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