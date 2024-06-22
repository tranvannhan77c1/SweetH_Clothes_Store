$(function() {
    "use strict";

    //------- Parallax -------//
    skrollr.init({
        forceHeight: false
    });

    //------- Active Nice Select --------//
    $('select').niceSelect();

    //------- hero carousel -------//
    $(".hero-carousel").owlCarousel({
        items: 3,
        margin: 10,
        autoplay: false,
        autoplayTimeout: 5000,
        loop: true,
        nav: false,
        dots: false,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            810: {
                items: 3
            }
        }
    });

    //------- Best Seller Carousel -------//
    if ($('.owl-carousel').length > 0) {
        $('#bestSellerCarousel').owlCarousel({
            loop: true,
            margin: 30,
            nav: true,
            navText: ["<i class='ti-arrow-left'></i>", "<i class='ti-arrow-right'></i>"],
            dots: false,
            responsive: {
                0: {
                    items: 1
                },
                600: {
                    items: 2
                },
                900: {
                    items: 3
                },
                1130: {
                    items: 4
                }
            }
        });
    }

    //------- single product area carousel -------//
    $(".s_Product_carousel").owlCarousel({
        items: 1,
        autoplay: false,
        autoplayTimeout: 5000,
        loop: true,
        nav: false,
        dots: false
    });

    //------- mailchimp --------//  
    function mailChimp() {
        $('#mc_embed_signup').find('form').ajaxChimp();
    }
    mailChimp();

    //------- fixed navbar --------//  
    $(window).scroll(function() {
        var sticky = $('.header_area'),
            scroll = $(window).scrollTop();

        if (scroll >= 100) sticky.addClass('fixed');
        else sticky.removeClass('fixed');
    });

    //------- Price Range slider -------//
    if (document.getElementById("price-range")) {

        var nonLinearSlider = document.getElementById('price-range');

        noUiSlider.create(nonLinearSlider, {
            connect: true,
            behaviour: 'tap',
            start: [0, 4000000], // Update the start values for VND
            range: {
                'min': [0],
                '10%': [500000, 500000], // Step value for VND
                '50%': [4000000, 1000000],
                'max': [10000000]
            },
            format: {
                to: function(value) {
                    return Math.round(value).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                },
                from: function(value) {
                    return Number(value.replace(/[^0-9.-]+/g, ""));
                }
            }
        });

        var nodes = [
            document.getElementById('lower-value'), // 0
            document.getElementById('upper-value') // 1
        ];

        // Display the slider value and how far the handle moved
        // from the left edge of the slider.
        nonLinearSlider.noUiSlider.on('update', function(values, handle, unencoded, isTap, positions) {
            nodes[handle].innerHTML = values[handle];
        });
    }
});