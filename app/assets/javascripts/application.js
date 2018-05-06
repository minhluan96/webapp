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
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function () {
    var dataTable = $('.datatable').DataTable({
        "pageLength": 25,
        "columnDefs": [
            {
                "targets": 2,
                render: function (data, type, row) {
                    return data.length > 50 ?
                        data.substr(0, 50) + '…' :
                        data;
                }
            },
            {"targets": 3, "width": "50px"},
            {"targets": 4, "width": "50px"}]
    });

    document.addEventListener("turbolinks:before-cache", function () {
        dataTable.destroy();
    });

    $(".owl-carousel").owlCarousel({
        loop: true,
        items: 4,
        slideSpeed: 200,
        pagination: false,
        dots: false
    });

    $('.products-section--left-arrow').bind('click', function () {
        owl = $(this).parents('.products-section').find('.owl-carousel');
        owl.trigger('prev.owl.carousel')
    });

    $('.products-section--right-arrow').bind('click', function () {
        owl = $(this).parents('.products-section').find('.owl-carousel');
        owl.trigger('next.owl.carousel')
    });
});