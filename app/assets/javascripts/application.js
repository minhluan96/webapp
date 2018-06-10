// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require owl.carousel
//= require materialize
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function () {
    var dataTable = $('.datatable').DataTable({
        "pageLength": 50,
        "autoWidth": false,
        "columnDefs": [{"targets": 0, "width": "80px"}]
    });

    $('.materialboxed').materialbox();

    if (window.isMobile) {
        numOfItem = 1;
    } else {
        numOfItem = 4;
    }

    $(".owl-carousel").not(".pagination").owlCarousel({
        loop: true,
        items: numOfItem,
        slideSpeed: 200,
        pagination: false,
        dots: false
    });

    owl = $(".owl-carousel.pagination").owlCarousel({
        items: numOfItem,
        slideSpeed: 200,
        dots: true
    });

    owl.find('.owl-dots').removeClass('disabled');

    $('.products-section--left-arrow').bind('click', function () {
        owl = $(this).parents('.products-section').find('.owl-carousel');
        owl.trigger('prev.owl.carousel')
    });

    $('.products-section--right-arrow').bind('click', function () {
        owl = $(this).parents('.products-section').find('.owl-carousel');
        owl.trigger('next.owl.carousel')
    });

    document.addEventListener("turbolinks:before-cache", function () {
        dataTable.destroy();
        $(".owl-carousel").owlCarousel('destroy');
    });

    $('.collapsible').collapsible({
        onOpenStart: function (el) {
            $(el).find('.material-icons').text('keyboard_arrow_up')
        },
        onCloseStart: function (el) {
            $(el).find('.material-icons').text('keyboard_arrow_down')
        }
    });
    $('.collapsible-header').attr('tabindex', '');
});