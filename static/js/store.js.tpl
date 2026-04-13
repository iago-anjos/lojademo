{#/*============================================================================
    #Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================
  
    Table of Contents

    #Lazy load
    #Notifications and tooltips
    #Modals
    #Cards
    #Accordions
    #Header and nav
        // Header
        // Utilities
        // Nav
        // Search suggestions
    #Sliders
        // Home slider
        // Products slider
        // Brand slider
        // Product related
        // Banner services slider
    #Social
        // Youtube or Vimeo video
        // Instagram feed
    #Product grid
        // Secondary image on mouseover
        // Fixed category controls
        // Filters
        // Sort by
        // Infinite scroll
        // Quickshop
    #Product detail functions
        // Installments
        // Change Variant
        // Submit to contact form
        // Product labels on variant change
        // Color and size variants change
        // Custom mobile variants change
        // Submit to contact
        // Product slider
        // Pinterest sharing
        // Add to cart
        // Product quantity
    #Cart
        // Free shipping bar 
        // Add to cart
        // Cart quantitiy changes
        // Empty cart alert
    #Shipping calculator
        // Select and save shipping function
        // Calculate shipping function
        // Calculate shipping by submit
        // Shipping and branch click
        // Select shipping first option on results
        // Toggle branches link
        // Toggle more shipping options
        // Calculate shipping on page load
        // Shipping provinces
        // Change store country
    #Forms
    #Footer
    #Empty placeholders

==============================================================================*/#}

// Move to our_content
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/*============================================================================
  #Lazy load
==============================================================================*/ #}

document.addEventListener('lazybeforeunveil', function(e){
    if ((e.target.parentElement) && (e.target.nextElementSibling)) {
        var parent = e.target.parentElement;
        var sibling = e.target.nextElementSibling;
        if (sibling.classList.contains('js-lazy-loading-preloader')) {
            sibling.style.display = 'none';
            parent.style.display = 'block';
        }
    }
});


window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.4;


$(document).ready(function(){

	{#/*============================================================================
	  #Notifications and tooltips
	==============================================================================*/ #}

    {# /* // Close notification and tooltip */ #}

    $(".js-notification-close, .js-tooltip-close").on( "click", function(e) {
        e.preventDefault();
        $(this).closest(".js-notification, .js-tooltip").hide();
        $(".js-quick-login-badge").hide();
    });

    {# Notifications variables #}

    var $notification_status_page = $(".js-notification-status-page");
    var $quick_login_notification = $(".js-notification-quick-login");
    var $fixed_bottom_button = $(".js-btn-fixed-bottom");
    
	{# /* // Follow order status notification */ #}
    
    if ($notification_status_page.size() > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){
            $notification_status_page.show();
        };
        $(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    {# /* // Cart notification: Dismiss notification */ #}

    $(".js-cart-notification-close").click(function(){
        $(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            $('.js-cart-notification-item-img').attr('src', '');
            $(".js-alert-added-to-cart").hide();
        },2000);
    });

    {% if not settings.head_fix %}

        {# /* // Add to cart notification on non fixed header */ #}

        var topBarHeight = $(".js-topbar").outerHeight();
        var logoBarHeight = $(".js-nav-logo-bar").outerHeight();
        var searchBarHeight = $(".js-search-container").outerHeight();
        if ($(window).width() > 768) {
            var fixedNotificationPosition = topBarHeight + logoBarHeight; 
        }else{
            var fixedNotificationPosition = logoBarHeight - searchBarHeight; 
        }
        var $addedToCartNotification = $(".js-alert-added-to-cart");
        var $addedToCartNotificationArrow = $addedToCartNotification.find(".js-cart-notification-arrow-up");

        $addedToCartNotification.css({"top": fixedNotificationPosition, "margin-top": -10});

        $(function () {
            $(window).scroll(function () {
                if ($(this).scrollTop() == 0) {
                    $addedToCartNotification.css("top" , fixedNotificationPosition);
                    $addedToCartNotificationArrow.css("visibility" , "visible");
                } else {
                    $addedToCartNotification.css("top" , 20);
                    $addedToCartNotificationArrow.css("visibility" , "hidden");
                }
            });
        })

    {% endif %}

    {# /* // Quick Login notification */ #}

    {% if not customer and template == 'home' %}

        {# Show quick login messages if it is returning customer #}

        setTimeout(function(){
            if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
                {% if store.country == 'AR' %}
                    $(".js-quick-login-badge").fadeIn();
                    $(".js-login-tooltip").show();
                    $(".js-login-tooltip-desktop").show().addClass("visible");
                {% else %}
                    $quick_login_notification.fadeIn();
                {% endif %}
                return;
            }
            
        },500);

    {% endif %}

    {# Dismiss quick login notifications #}

    $(".js-dismiss-quicklogin").on( "click", function(e) {
        LS.dontShowQuickLoginNotification();
    });


    setTimeout(function(){
        $(".js-quick-login-success").fadeOut();
    },8000);

    {% if not params.preview %}

        {# /* // Legal footer visibility */ #}

        const footerLegal = $(".js-footer-legal");

        let footerOffset = 20;

        if (window.innerWidth > 768) {
            footerOffset = 60;
        }

        {% if store.whatsapp %}
            footerLegal.css("padding-bottom", footerOffset + "px");
        {% endif %}

        {# /* // Cookie banner notification */ #}

        restoreNotifications = function(){

            // Whatsapp button position
            if ($(window).width() < 768) {
                $fixed_bottom_button.css({"margin-bottom": "10px"});
            }

            footerLegal.css("padding-bottom", footerOffset + "px");
        };

        if (!window.cookieNotificationService.isAcknowledged()) {
            $(".js-notification-cookie-banner").show();

            {# Offset to show legal footer #}
                
            const cookieBannerHeight = $(".js-notification-cookie-banner").outerHeight();
            footerLegal.css("padding-bottom", cookieBannerHeight + 20 + "px");

            {# Whatsapp button position #}
            if ($(window).width() < 768) {
                $fixed_bottom_button.css({"margin-bottom": "140px"});
            }
        }

        $(".js-acknowledge-cookies").on( "click", function(e) {
            window.cookieNotificationService.acknowledge();
            footerLegal.removeAttr("style");
            restoreNotifications();
        });

    {% endif %}

    {#/*============================================================================
      #Modals
    ==============================================================================*/ #}

    {# Full screen mobile modals back events #}

    if ($(window).width() < 768) {

        {# Clean url hash function #}

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        {# Go back 1 step on browser history #}

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        {# Clean url hash on page load: All modals should be closed on load #}

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        {# Open full screen modal and url hash #}

        $(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = $(this).data("modal-url");            
            window.location.hash = modal_url_hash;
        });

        {# Close full screen modal: Remove url hash #}

        $(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {

                {# Close opened modal #}

                if($(".js-fullscreen-modal").hasClass("modal-show")){

                    {# Remove body lock only if a single modal is visible on screen #}

                    if($(".js-modal.modal-show").length == 1){
                        $("body").removeClass("overflow-none");
                    }
                    var $opened_modal = $(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();

                    $opened_modal.removeClass("modal-show").delay(500).hide(0);
                    $opened_modal_overlay.fadeOut(500);
                    
                }
            }
        }

    }
    
    $(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault(); 
        var modal_id = $(this).data('toggle');
        var $overlay_id = $('.js-modal-overlay[data-modal-id="' + modal_id + '"]');
        if ($(modal_id).hasClass("modal-show")) {
            $(modal_id).removeClass("modal-show").delay(500).hide(0);
        } else {
            {# Lock body scroll if there is no modal visible on screen #}
            
            if(!$(".js-modal.modal-show").length){
                $("body").addClass("overflow-none");
            }
            $overlay_id.fadeIn(400);
            $(modal_id).detach().appendTo("body");
            $overlay_id.detach().insertBefore(modal_id);
            $(modal_id).show(0).addClass("modal-show");
        }             
    });

    $(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();  

        {# Remove body lock only if a single modal is visible on screen #}

        if($(".js-modal.modal-show").length == 1){
            $("body").removeClass("overflow-none");
        }
        var $modal = $(this).closest(".js-modal");
        var modal_id = $modal.attr('id');
        var $overlay_id = $('.js-modal-overlay[data-modal-id="#' + modal_id + '"]');
        $modal.removeClass("modal-show").delay(500).hide(0); 
        $overlay_id.fadeOut(500);
        
        {# Close full screen modal: Remove url hash #}

        if (($(window).width() < 768) && ($(this).hasClass(".js-fullscreen-modal-close"))) {
            goBackBrowser();
        }
    });

    $(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if($(".js-modal.modal-show").length == 1){
            $("body").removeClass("overflow-none");
        }

        var modal_id = $(this).data('modal-id');
        $(modal_id).removeClass("modal-show").delay(500).hide(0);   
        $(this).fadeOut(500);
    });

    {% if template == 'home' and settings.home_promotional_popup %}

        {# /* // Home popup and newsletter popup */ #}

        $('#news-popup-form').submit(function () {
            $(".js-news-spinner").show();
            $(".js-news-send, .js-news-popup-submit").hide();
            $(".js-news-popup-submit").prop("disabled", true);
        });

        LS.newsletter('#news-popup-form-container', '#home-modal', '{{ store.contact_url | escape('js') }}', function (response) {
            $(".js-news-spinner").hide();
            $(".js-news-send, .js-news-popup-submit").show();
            var selector_to_use = response.success ? '.js-news-popup-success' : '.js-news-popup-failed';
            $(this).find(selector_to_use).fadeIn(100).delay(4000).fadeOut(500);
            if ($(".js-news-popup-success").css("display") == "block") {
                setTimeout(function () {
                    $('[data-modal-id="#home-modal"]').fadeOut(500);
                    $("#home-modal").removeClass("modal-show").delay(500).hide(0);
                }, 2500);
            }
            $(".js-news-popup-submit").prop("disabled", false);
        });


        var callback_show = function(){
            $('.js-modal-overlay[data-modal-id="#home-modal"]').fadeIn(500);
            $("#home-modal").detach().appendTo("body").show(0).addClass("modal-show");
        }
        var callback_hide = function(){
            $('.js-modal-overlay[data-modal-id="#home-modal"]').fadeOut(500); 
            $("#home-modal").removeClass("modal-show").delay(500).hide(0); 
        }
        LS.homePopup({
            selector: "#home-modal",
            timeout: 10000
        }, callback_hide, callback_show);

    {% endif %}

    {#/*============================================================================
      #Cards
    ==============================================================================*/ #}
    $(document).on("click", ".js-card-collapse-toggle", function(e) {
        e.preventDefault();
        $(this).toggleClass('active');
        $(this).closest(".js-card-collapse").toggleClass('active');
    });

    {#/*============================================================================
      #Accordions
    ==============================================================================*/ #}
    $(document).on("click", ".js-accordion-toggle", function(e) {
        e.preventDefault();
        if($(this).hasClass("js-accordion-show-only")){
            $(this).hide();
        }else{
            $(this).find(".js-accordion-toggle-inactive").toggle();
            $(this).find(".js-accordion-toggle-active").toggle();
        }
        $(this).prev(".js-accordion-container").slideToggle();
    });

	{#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Header */ #}

        {% if template == 'home' and settings.head_transparent %}
            {% if settings.slider and settings.slider is not empty %}        

                var $swiper_height = $(window).height() - 100;
                
                $(document).scroll(function() {
                    if ($(document).scrollTop() > $swiper_height ) {
                        $(".js-head-main").removeClass("head-transparent");
                    } else {
                        $(".js-head-main").addClass("head-transparent");
                    }
                });

            {% endif %}
        {% endif %}

        {# /* // Nav offset */ #}

        function applyOffset(selector){

            // Get nav height on load
            if ($(window).width() > 768) {
                var head_height = $(".js-head-main").height();
                $(selector).css("padding-top", head_height); 
            }else{

                {# On mobile there is no top padding due to position sticky CSS #}
                var head_height = 0;
            }

            // Apply offset nav height on load
            
            $(window).resize(function() {

                // Get nav height on resize
                var head_height = $(".js-head-main").height();

                // Apply offset on resize
                if ($(window).width() > 768) {
                    $(selector).css("padding-top", head_height);
                }else{

                    {# On mobile there is no top padding due to position sticky CSS #}
                    $(selector).css("padding-top", 0);
                }
            });
        }


    {% if settings.head_fix %}

        applyOffset(".js-head-offset");

        {# Slim header on scroll #}

        window.addEventListener("scroll", function() {

            var scrolledPosition = window.pageYOffset;

            var header = $(".js-head-main");
            var navbarHeight = header.outerHeight();
            var topbarHeight = $(".js-topbar").outerHeight();

            if (scrolledPosition > navbarHeight) {
                header.addClass('compress').css('top', -topbarHeight);
                if (window.innerWidth < 768) {
                    $category_controls.css('top', (navbarHeight - topbarHeight - 2) );
                }
            } else {
                header.removeClass('compress').css('top', 0);
                if (window.innerWidth < 768) {
                    $category_controls.css('top', navbarHeight );
                }
            }
        });
            
    {% endif %}      


    {# /* // Utilities */ #}

        $(".js-utilities-item").hover(function(e) {
            e.preventDefault();
            $(this).toggleClass("active");
        });


    {# /* // Nav */ #}

        var $top_nav = $(".js-mobile-nav");
        var $page_main_content = $(".js-main-content");
        var $search_backdrop = $(".js-search-backdrop");

        $top_nav.addClass("move-down").removeClass("move-up");


        {# Nav subitems #}

        $(".js-toggle-page-accordion").click(function (e) {
            e.preventDefault();
            $(this).toggleClass("active").closest(".js-nav-list-toggle-accordion").next(".js-pages-accordion").slideToggle(300);
        });

        var win_height = window.innerHeight;
        var head_height = $(".js-head-main").height();

        $(".js-desktop-dropdown").css('max-height', win_height - head_height - 50);

        $(".js-item-desktop").hover(function (e) {
            $(this).addClass("active");
        }, function() {
            $(this).removeClass("active");
        });

        $(".js-item-desktop").on("mouseenter", function (e) {
            $('.js-nav-desktop-list').children(".selected").removeClass("selected");
            $(e.currentTarget).addClass("selected");
        }).on("mouseleave", function(e) {
            const self = $(this);
            setTimeout(function(){
                self.removeClass("selected");
            },500);
        });

        {# Avoid megamenu dropdown flickering when mouse leave #}

        $(".js-desktop-dropdown").on("mouseleave", function (e) {
            const self = $(this);
            self.css("pointer-events" , "none");
            setTimeout(function(){
                self.css("pointer-events" , "initial");
            },1000);
        });

        {# Focus search #}

        $(".js-toggle-search").click(function (e) {
            e.preventDefault;
            $(".js-search-input").focus();
        });


    {# /* // Search suggestions */ #}

        LS.search($(".js-search-input"), function (html, count) {
            $search_suggests = $(this).closest(".js-search-container").next(".js-search-suggest");
            if (count > 0) {
                $search_suggests.html(html).show();
            } else {
                $search_suggests.hide();
            }
            if ($(this).val().length == 0) {
                $search_suggests.hide();
            }
        }, {
            snipplet: 'header/header-search-results.tpl'
        });

        if ($(window).width() > 768) {

            {# Hide search suggestions if user click outside results #}

            $("body").click(function () {
                $(".js-search-suggest").hide();
            });

            {# Maintain search suggestions visibility if user click on links inside #}

            $(document).on("click", ".js-search-suggest a", function () {
                $(".js-search-suggest").show();
            });
        }

        $(".js-search-suggest").on("click", ".js-search-suggest-all-link", function (e) {
            e.preventDefault();
            $this_closest_form = $(this).closest(".js-search-suggest").prev(".js-search-form");
            $this_closest_form.submit();
        });


	{#/*============================================================================
	  #Sliders
	==============================================================================*/ #}

	{% if template == 'home' %}

		{# /* // Home slider */ #}


        var width = window.innerWidth;
        if (width > 767) {
            var slider_autoplay = {delay: 6000,};
        } else {
            var slider_autoplay = false;
        }

        var preloadImagesValue = false;
        var lazyValue = true;
        var loopValue = true;
        var paginationClickableValue = true;

        createSwiper(
            '.js-home-slider', {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
            },
            function(swiperInstance) {
                window.homeSwiper = swiperInstance;
            }
        );

        createSwiper(
            '.js-home-slider-mobile', {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider_mobile | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
            },
            function(swiperInstance) {
                window.homeMobileSwiper = swiperInstance;
            }
        );

        {% if settings.slider | length == 1 %}
            $('.js-swiper-home .swiper-wrapper').addClass( "disabled" );
            $('.js-swiper-home-pagination, .js-swiper-home-prev, .js-swiper-home-next').remove();
        {% endif %}

        {% set columns = settings.grid_columns %}


        {# /* // Products slider */ #}

        {% set has_featured_products_slider = sections.primary.products and settings.featured_products_format != 'grid' %}
        {% set has_new_products_slider = sections.new.products and settings.new_products_format != 'grid' %}
        {% set has_sale_products_slider = sections.sale.products and settings.sale_products_format != 'grid' %}

        {% if has_featured_products_slider or has_new_products_slider or has_sale_products_slider %}

            var lazyVal = true;
            var watchOverflowVal = true;
            var centerInsufficientSlidesVal = true;
            var slidesPerViewDesktopVal = {% if columns == 2 %}4{% else %}3{% endif %};
            var slidesPerViewMobileVal = 1.5;

            {% if has_featured_products_slider %}

                window.swiperLoader('.js-swiper-featured', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    centerInsufficientSlides: centerInsufficientSlidesVal,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                {% if sections.primary.products | length > 3 %}
                    loop: true,
                {% endif %}
                    navigation: {
                        nextEl: '.js-swiper-featured-next',
                        prevEl: '.js-swiper-featured-prev',
                    },
                    slidesPerView: slidesPerViewMobileVal,
                    breakpoints: {
                        768: {
                            slidesPerView: slidesPerViewDesktopVal,
                        }
                    }
                });

            {% endif %}

            {% if has_new_products_slider %}

                window.swiperLoader('.js-swiper-new', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    centerInsufficientSlides: centerInsufficientSlidesVal,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                {% if sections.new.products | length > 3 %}
                    loop: true,
                {% endif %}
                    navigation: {
                        nextEl: '.js-swiper-new-next',
                        prevEl: '.js-swiper-new-prev',
                    },
                    slidesPerView: slidesPerViewMobileVal,
                    breakpoints: {
                        768: {
                            slidesPerView: slidesPerViewDesktopVal,
                        }
                    }
                });

            {% endif %}

            {% if has_sale_products_slider %}

                window.swiperLoader('.js-swiper-sale', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    centerInsufficientSlides: centerInsufficientSlidesVal,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                {% if sections.sale.products | length > 3 %}
                    loop: true,
                {% endif %}
                    navigation: {
                        nextEl: '.js-swiper-sale-next',
                        prevEl: '.js-swiper-sale-prev',
                    },
                    slidesPerView: slidesPerViewMobileVal,
                    breakpoints: {
                        768: {
                            slidesPerView: slidesPerViewDesktopVal,
                        }
                    }
                });

            {% endif %}

        {% endif %}

        {# /* // Home demo products slider */ #}

        ['featured', 'sale', 'new'].forEach(setting => {
            createSwiper(`.js-swiper-featured-demo-${setting}`, {
                lazy: true,
                loop: true,
                watchOverflow: true,
                centerInsufficientSlides: true,
                slidesPerView: 1.5,
                navigation: {
                    nextEl: `.js-swiper-featured-demo-next-${setting}`,
                    prevEl: `.js-swiper-featured-demo-prev-${setting}`
                },
                breakpoints: {
                    640: {
                        slidesPerView: {% if columns == 2 %}4{% else %}3{% endif %},
                    }
                }
            });
        });


        {# /* // Brands slider */ #}

        createSwiper('.js-swiper-brands', {
            lazy: true,
            {% if settings.brands | length > 4 %}
                loop: true,
            {% endif %}
            watchOverflow: true,
            centerInsufficientSlides: true,
            spaceBetween: 30,
            slidesPerView: 1.5,
            navigation: {
                nextEl: '.js-swiper-brands-next',
                prevEl: '.js-swiper-brands-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: 5,
                }
            }
        },function(swiperInstance) {
            window.brandsSwiper = swiperInstance;
        });


	{% endif %}

    {% if template == 'product' %}

        {# /* // Product Related */ #}

        {% set related_products_ids = product.metafields.related_products.related_products_ids %}
        {% if related_products_ids %}
            {% set related_products = related_products_ids | get_products %}
            {% set show = (related_products | length > 0) %}
        {% endif %}
        {% if not show %}
            {% set related_products = category.products | shuffle | take(8) %}
            {% set show = (related_products | length > 1) %}
        {% endif %}

        {% set columns = settings.grid_columns %}
         createSwiper('.js-swiper-related', {
            lazy: true,
            {% if related_products | length > 3 %}
                loop: true,
            {% endif %}
            watchOverflow: true,
            centerInsufficientSlides: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: 1.5,
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: {% if columns == 2 %}4{% else %}3{% endif %},
                }
            }
        });

    {% endif %}



	{% set has_banner_services = settings.banner_services %}

	{% if has_banner_services %}

		{# /* // Banner services slider */ #}

        var width = window.innerWidth;
        if (width < 767) {
            createSwiper('.js-informative-banners', {
                slidesPerView: 1.2,
                watchOverflow: true,
                centerInsufficientSlides: true,
                pagination: {
                    el: '.js-informative-banners-pagination',
                    clickable: true,
                },
                breakpoints: {
                    640: {
                        slidesPerView: 3,
                    }
                }
            });
        }

    {% endif %}

	{#/*============================================================================
	  #Social
	==============================================================================*/ #}

    {% if template == 'home' %}
        {% set video_url = settings.video_embed %}
    {% elseif template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
    {% endif %}

	{% if video_url %}

        {# /* // Youtube or Vimeo video for home or each product */ #}

        LS.loadVideo('{{ video_url }}');

    {% endif %}

	{#/*============================================================================
	  #Product grid
	==============================================================================*/ #}

    {# /* // Secondary image on mouseover */ #}

    {% if settings.product_hover %}
        if (window.innerWidth > 767) {
            $(document).on("mouseover", ".js-item-with-secondary-image:not(.item-with-two-images)", function(e) {
                var secondary_image_to_show = $(this).find(".js-item-image-secondary");
                secondary_image_to_show.show();
                secondary_image_to_show.on('lazyloaded', function(e){
                    $(this).closest(".js-item-with-secondary-image").addClass("item-with-two-images");
                });
            });
        }
    {% endif %}

    var $category_controls = $(".js-category-controls");
    var mobile_nav_height = $(".js-head-main").innerHeight();

	{% if template == 'category' %}

        {# /* // Fixed category controls */ #}

        if ($(window).width() < 768) {

            {% if settings.head_fix %}
                $category_controls.css("top" , mobile_nav_height);
            {% else %}
                $(".js-category-controls").css("top" , 0);
            {% endif %}

            {# Detect if category controls are sticky and add css #}

            var observer = new IntersectionObserver(function(entries) {
                if(entries[0].intersectionRatio === 0)
                    $(".js-category-controls").addClass("is-sticky");
                else if(entries[0].intersectionRatio === 1)
                    $(".js-category-controls").removeClass("is-sticky");
                }, { threshold: [0,1]
            });

            observer.observe(document.querySelector(".js-category-controls-prev"));
        }

        {# /* // Filters */ #}

        $(document).on("click", ".js-apply-filter, .js-remove-filter", function(e) {
            e.preventDefault();
            var filter_name = $(this).data('filter-name');
            var filter_value = $(this).data('filter-value');
            if($(this).hasClass("js-apply-filter")){
                $(this).find("[type=checkbox]").prop("checked", true);
                LS.urlAddParam(
                    filter_name,
                    filter_value,
                    true
                );
            }else{
                $(this).find("[type=checkbox]").prop("checked", false);
                LS.urlRemoveParam(
                    filter_name,
                    filter_value
                );
            }

            {# Toggle class to avoid adding double parameters in case of double click and show applying changes feedback #}

            if ($(this).hasClass("js-filter-checkbox")){
                if ($(window).width() < 768) {
                    $(".js-filters-overlay").show();
                    if($(this).hasClass("js-apply-filter")){
                        $(".js-applying-filter").show();
                    }else{
                        $(".js-removing-filter").show();
                    }
                }
                $(this).toggleClass("js-apply-filter js-remove-filter");
            }
        });

        $(document).on("click", ".js-remove-all-filters", function(e) {
            e.preventDefault();
            LS.urlRemoveAllParams();
        });

		{# /* // Sort by */ #}

		$('.js-sort-by').change(function () {
            var params = LS.urlParams;
            params['sort_by'] = $(this).val();
            var sort_params_array = [];
            for (var key in params) {
                if ($.inArray(key, ['results_only', 'page']) == -1) {
                    sort_params_array.push(key + '=' + params[key]);
                }
            }
            var sort_params = sort_params_array.join('&');
            window.location = window.location.pathname + '?' + sort_params;
        });

	{% endif %}

    {% if template == 'category' or template == 'search' %}

        $(function() {

        	{# /* // Infinite scroll */ #}

            {% if pages.current == 1 and not pages.is_last %}
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: 12
                });
            {% endif %}
        });

	{% endif %}

    {% if settings.quick_shop %}

        {# /* // Quickshop */ #}

        $(document).on("click", ".js-item-buy-open", function(e) {
            e.preventDefault();
            $(this).toggleClass("btn-primary btn-secondary");
            $(this).closest(".js-quickshop-container").find(".js-item-variants").fadeToggle(300);

            var elementTop = $(this).closest(".js-product-container").offset().top;
            var viewportTop = $(window).scrollTop();

            if(elementTop < viewportTop){
                $([document.documentElement, document.body]).animate({
                    scrollTop: $(this).closest(".js-product-container").offset().top - 180
                }, 400);
            }

        });

        $(document).on("click", ".js-item-buy-close", function(e) {
            e.preventDefault();
            $(this).closest(".js-item-variants").fadeToggle(300);
            $(this).closest(".js-quickshop-container").find(".js-item-buy-open").toggleClass("btn-primary btn-secondary");
        });

    {% endif %}

    {% if settings.product_color_variants %}

        {# Product color variations #}

        $(document).on("click", ".js-color-variant", function(e) {
            e.preventDefault();
            $this = $(this);

            var option_id = $this.data('option');
            $selected_option = $this.closest('.js-item-product').find('.js-variation-option option').filter(function() {
                return this.value == option_id;
            });
            $selected_option.prop('selected', true).trigger('change');
            var available_variant = $(this).closest(".js-quickshop-container").data('variants');

            var available_variant_color = $(this).closest('.js-color-variant-active').data('option');

            for (var variant in available_variant) {
                if (option_id == available_variant[variant]['option'+ available_variant_color ]) {

                    if (available_variant[variant]['stock'] == null || available_variant[variant]['stock'] > 0 ) {

                        var otherOptions = getOtherOptionNumbers(available_variant_color);

                        var otherOption = available_variant[variant]['option' + otherOptions[0]];
                        var anotherOption = available_variant[variant]['option' + otherOptions[1]];

                        changeSelect($(this), otherOption, otherOptions[0]);
                        changeSelect($(this), anotherOption, otherOptions[1]);
                        break;

                    }
                }
            }

            $this.siblings().removeClass("selected");
            $this.addClass("selected");
        });

        function getOtherOptionNumbers(selectedOption) {
            switch (selectedOption) {
                case 0:
                    return [1, 2];
                case 1:
                    return [0, 2];
                case 2:
                    return [0, 1];
            }
        }

        function changeSelect(element, optionToSelect, optionIndex) {
            if (optionToSelect != null) {
                var selected_option_attribute = element.closest('.js-item-product').find('.js-color-variant-available-' + (optionIndex + 1)).data('value');
                var selected_option = element.closest('.js-item-product').find('#' + selected_option_attribute + " option").filter(function() {
                    return this.value == optionToSelect;
                });

                selected_option.prop('selected', true).trigger('change');
            }
        }
    {% endif %}

    {% if settings.quick_shop or settings.product_color_variants %}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}
            var current_image = $('.js-item-image', '.js-item-product[data-product-id="'+variant.product_id+'"]');
            current_image.attr('srcset', variant.image_url);

            {% if settings.product_hover %}
                {# Remove secondary feature on image updated from changeVariant #}
                current_image.closest(".js-item-with-secondary-image").removeClass("item-with-two-images");
            {% endif %}
        });

    {% endif %}

    {#/*============================================================================
	  #Product detail functions
	==============================================================================*/ #}

	{# /* // Installments */ #}

	{# Installments without interest #}

	function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
	        if (installment_data.without_interests) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_without_interests;
	}

	{# Installments with interest #}

	function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
	        if (installment_data.without_interests == false) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_with_interests;
	}

	{# Updates installments on payment popup for native integrations #}

	function refreshInstallmentv2(price){
	    $(".js-modal-installment-price" ).each(function( index ) {
	        const installment = Number($(this).data('installment'));
	        $(this).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
	    });
	}

	{# /* // Change variant */ #}

	{# Updates price, installments, labels and CTA on variant change #}

	function changeVariant(variant) {
	    $(".js-product-detail .js-shipping-calculator-response").hide();
	    $("#shipping-variant-id").val(variant.id);

	    var parent = $("body");
	    if (variant.element) {
	        parent = $(variant.element);
	    }

	    var sku = parent.find('#sku');
	    if(sku.length) {
	        sku.text(variant.sku).show();
	    }

	    {% if settings.product_stock or settings.latest_products_available %}
	        var stock = parent.find('.js-product-stock');
	        const stock_qty = variant.stock ?? '';
	        stock.text(stock_qty).show();
	    {% endif %}

        {# Updates installments on list item and inside payment popup for Payments Apps #}

	    var installment_helper = function($element, amount, price){
	        $element.find('.js-installment-amount').text(amount);
	        $element.find('.js-installment-price').attr("data-value", price);
	        $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
	            $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        } else {
	            $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        }
	    };

	    if (variant.installments_data) {
	        var variant_installments = JSON.parse(variant.installments_data);
	        var max_installments_without_interests = [0,0];
	        var max_installments_with_interests = [0,0];

	        {# Hide all installments rows on payments modal #}
	        $('.js-payment-provider-installments-row').hide();

	        $.each(variant_installments, function(payment_method, installments) {

	            {# Identifies the minimum installment value #}
	            var paymentMethodId = '#installment_' + payment_method.replace(" ", "_") + '_1';
	            var minimumInstallmentValue = $(paymentMethodId).closest('.js-info-payment-method').attr("data-minimum-installment-value");

	            $.each(installments, function(number_of_installment, installment_data) {
	                max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
	                max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
	                var installment_container_selector = '#installment_' + payment_method.replace(" ", "_") + '_' + number_of_installment;

	                {# Shows installments rows on payments modal according to the minimum value #}
	                if(minimumInstallmentValue <= installment_data.installment_value) {
	                    $(installment_container_selector).show();
	                }

	                if(!parent.hasClass("js-quickshop-container")){
	                    installment_helper($(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
	                }
	            });
	        });
	        var $installments_container = $(variant.element + ' .js-max-installments-container .js-max-installments');
	        var $installments_modal_link = $(variant.element + ' #btn-installments');
	        var $payments_module = $(variant.element + ' .js-product-payments-container');
	        var $installmens_card_icon = $(variant.element + ' .js-installments-credit-card-icon');

	        {% if product.has_direct_payment_only %}
	        var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 0 ) {
	        {%  else %}
	        var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 1 ) {
	        {% endif %}
	            $installments_container.hide();
	            $installments_modal_link.hide();
	            $payments_module.hide();
	            $installmens_card_icon.hide();
	        } else {
	            $installments_container.show();
	            $installments_modal_link.show();
	            $payments_module.show();
	            $installmens_card_icon.show();
	            installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
	        }
	    }

	    if (variant.contact) {
	        $payments_module.hide();
	    }

	    if(!parent.hasClass("js-quickshop-container")){
	    	$('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
		}

	    if (variant.price_short){

            var variant_price_clean = variant.price_short.replace('$', '').replace('R', '').replace(',', '').replace('.', '');
            var variant_price_raw = parseInt(variant_price_clean, 10);

	        parent.find('.js-price-display').text(variant.price_short).show();
	        parent.find('.js-price-display').attr("content", variant.price_number).data('product-price', variant_price_raw);
	    } else {
	        parent.find('.js-price-display').hide();
	    }

        if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
            parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();

            if(variant.compare_at_price_number > variant.price_number){
                const saved_compare_price_money = variant.compare_at_price_number - variant.price_number;
                parent.find('.js-offer-saved-money').text(LS.formatToCurrency(saved_compare_price_money));
                parent.find(".js-saved-money-message").show();
            }else {
                parent.find(".js-saved-money-message").hide();
            }
        } else {
            parent.find('.js-compare-price-display, .js-saved-money-message').hide();
        }

	    var button = parent.find('.js-addtocart');
	    button.removeClass('cart').removeClass('contact').removeClass('nostock');
	    var $product_shipping_calculator = parent.find("#product-shipping-container");

        {# Update CTA wording and status #}

	    {% if not store.is_catalog %}
	    if (!variant.available){
	        button.val('{{ "Sin stock" | translate }}');
	        button.addClass('nostock');
	        button.attr('disabled', 'disabled');
	        $product_shipping_calculator.hide();
	    } else if (variant.contact) {
	        button.val('{{ "Consultar precio" | translate }}');
	        button.addClass('contact');
	        button.removeAttr('disabled');
	        $product_shipping_calculator.hide();
	    } else {
	        button.val('{{ "Agregar al carrito" | translate }}');
	        button.addClass('cart');
	        button.removeAttr('disabled');
	        $product_shipping_calculator.show();
	    }

	    {% endif %}

        {% if template == 'product' %}
            const base_price = Number($("#price_display").attr("content"));
            refreshInstallmentv2(base_price);

            {% if settings.last_product and product.variations %}
                if(variant.stock == 1) {
                    $('.js-last-product').show();
                } else {
                    $('.js-last-product').hide();
                }
                {% if settings.latest_products_available %}
                    const stock_limit = $(".js-latest-products-available").attr("data-limit");
                    if(variant.stock < stock_limit && variant.stock != null && variant.stock != 1 && variant.stock != 0) {
                        $('.js-latest-products-available').show();
                    } else {
                        $('.js-latest-products-available').hide();
                    }
                {% endif %}
            {% endif %}
        {% endif %}


        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        zipcode_on_changevariant = $("#product-shipping-container .js-shipping-input").val();
        $("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true, parent);

        {% endif %}
	}

	{# /* // Trigger change variant */ #}

	$(document).on("change", ".js-variation-option", function(e) {
        var $parent = $(this).closest(".js-product-variants");
        var $variants_group = $(this).closest(".js-product-variants-group");
        var quick_id = $(this).closest(".js-quickshop-container").attr("id");
        if($parent.hasClass("js-product-quickshop-variants")){
            {% if template == 'home' %}
                LS.changeVariant(changeVariant, '.js-swiper-slide-visible #' + quick_id);
            {% else %}
                LS.changeVariant(changeVariant, '#' + quick_id);
            {% endif %}

            {% if settings.product_color_variants %}
                {# Match selected color variant with selected quickshop variant #}
                if(($variants_group).hasClass("js-color-variants-container")){
                    var selected_option_id = $(this).find("option:selected").val();
                    $('#' + quick_id).find('.js-color-variant').removeClass("selected");
                    $('#' + quick_id).find('.js-color-variant[data-option="'+selected_option_id+'"]').addClass("selected");
                }
            {% endif %}
        } else {
            LS.changeVariant(changeVariant, '#single-product');
        }

        {# Offer and discount labels update #}

        var $this_product_container = $(this).closest(".js-product-container");
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart =  $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

        if ($this_compare_price.css("display") == "none" || !percentageDifference) {
            $this_product_container.find(".js-offer-label").hide();
        }
        if ($this_add_to_cart.hasClass("nostock")) {
            $this_product_container.find(".js-stock-label").show();
        }
        else {
            $this_product_container.find(".js-stock-label").hide();
	    }
	    if ($this_price.css('display') == 'none'){
	        $installment_container.hide();
	        $installment_text.hide();
	    }else{
	        $installment_text.show();
	    }
	});

	{# /* // Submit to contact */ #}

	{# Submit to contact form when product has no price #}

	$(".js-product-form").submit(function (e) {
	    var button = $(this).find(':submit');
	    button.attr('disabled', 'disabled');
	    if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
	        e.preventDefault();
	        var product_id = $(this).find("input[name='add_to_cart']").val();
	        window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
	    } else if (button.hasClass('cart')) {
	        button.val('{{ "Agregando..." | translate }}');
	    }
	});

	{% if template == 'product' %}

        {% set has_multiple_slides = product.images_count > 1 or video_url %}

	    {# /* // Product slider */ #}

            var width = window.innerWidth;
            if (width > 767) {
                var speedVal = 0;
                var spaceBetweenVal = 0;
                var slidesPerViewVal = 1;
            } else {
                var speedVal = 300;
                var spaceBetweenVal = 10;
                var slidesPerViewVal = 1.2;
            }

            var productSwiper = null;
            createSwiper(
                '.js-swiper-product', {
                    lazy: true,
                    speed: speedVal,
                    {% if has_multiple_slides %}
                    slidesPerView: slidesPerViewVal,
                    centeredSlides: true,
                    spaceBetween: spaceBetweenVal,
                    {% endif %}
                    pagination: {
                        el: '.js-swiper-product-pagination',
                        type: 'fraction',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.js-swiper-product-next',
                        prevEl: '.js-swiper-product-prev',
                    },
                    on: {
                        init: function () {
                            $(".js-product-slider-placeholder").hide();
                            $(".js-swiper-product").css({"visibility" : "visible" , "height" : "auto"});
                            {% if product.video_url %}
                                if ($(window).width() < 768) {
                                    productSwiperHeight = $(".js-swiper-product").height();
                                    $(".js-product-video-slide").height(productSwiperHeight);
                                }
                            {% endif %}
                        },
                        {% if product.video_url %}
                            slideChangeTransitionEnd: function () {
                                if($(".js-product-video-slide").hasClass("swiper-slide-active")){
                                    $(".js-labels-group").fadeOut(100);
                                }else{
                                    $(".js-labels-group").fadeIn(100);
                                }
                                $('.js-video').show();
                                $('.js-video-iframe').hide().find("iframe").remove();
                            },
                        {% endif %}
                    },
                },
                function(swiperInstance) {
                    productSwiper = swiperInstance;
                }
            );

            $().fancybox({
                selector : '[data-fancybox="product-gallery"]',
                toolbar  : false,
                smallBtn : true,
                beforeClose : function(instance) {
                    // Update position of the slider
                    productSwiper.slideTo( instance.currIndex, 0 );
                    $(".js-product-thumb").removeClass("selected");

                    var $product_thumbnail = $(".js-product-thumb[data-thumb-loop='"+instance.currIndex+"']").addClass("selected");
                    if($product_thumbnail.length){
                        $product_thumbnail.addClass("selected");
                    }else{
                        $(".js-product-thumb[data-thumb-loop='4']").addClass("selected");
                    }
                },
            });

	    {% if has_multiple_slides %}
	        LS.registerOnChangeVariant(function(variant){
	            var liImage = $('.js-swiper-product').find("[data-image='"+variant.image+"']");
	            var selectedPosition = liImage.data('image-position');
                var slideToGo = parseInt(selectedPosition);
                productSwiper.slideTo(slideToGo);
                $(".js-product-slide-img").removeClass("js-active-variant");
                liImage.find(".js-product-slide-img").addClass("js-active-variant");
	        });

            $(".js-product-thumb").click(function(e){
                e.preventDefault();
                $(".js-product-thumb").removeClass("selected");
                $(this).addClass("selected");
                var thumbLoop = $(this).data("thumb-loop");
                var slideToGo = parseInt(thumbLoop);
                productSwiper.slideTo(slideToGo);
                if($(this).hasClass("js-product-thumb-modal")){
                    $('.js-swiper-product').find("[data-image-position='"+slideToGo+"'] .js-product-slide-link").click();
                }
            });
	    {% endif %}

        {# /* // Pinterest sharing */ #}

        $('.js-pinterest-share').click(function(e){
            e.preventDefault();
            $(".pinterest-hidden a")[0].click();
        });

        {# Product show description and relocate on mobile #}

        if (window.innerWidth > 767) {
            $("#product-description").show();
        }else{
            $("#product-description").insertAfter("#product_form").show();
        }

	{% endif %}

    {# Product quantitiy #}

    $('.js-quantity .js-quantity-up').on('click', function() {
        $quantity_input = $(this).closest(".js-quantity").find(".js-quantity-input");
        $quantity_input.val( parseInt($quantity_input.val(), 10) + 1);
    });

    $('.js-quantity .js-quantity-down').on('click', function() {
        $quantity_input = $(this).closest(".js-quantity").find(".js-quantity-input");
        quantity_input_val = $quantity_input.val();
        if (quantity_input_val>1) {
            $quantity_input.val( parseInt($quantity_input.val(), 10) - 1);
        }
    });


	{#/*============================================================================
	  #Cart
	==============================================================================*/ #}

    {# /* // Free shipping bar */ #}
    
    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}

    {# /* // Position of cart page summary */ #}

    var head_height = $(".js-head-main").outerHeight();

    if ($(window).width() > 768) {
        {% if settings.head_fix %}
            $("#cart-sticky-summary").css("top" , head_height + 10);
        {% else %}
            $("#cart-sticky-summary").css("top" , 10);
        {% endif %}
    }


    {# /* // Add to cart */ #}

    function getQuickShopImgSrc(element){
        const image = $(element).closest('.js-quickshop-container').find('img');
        return String(image.attr('srcset')); 
    }

	$(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {

        {# Button variables for transitions on add to cart #}

        var $productContainer = $(this).closest('.js-product-container');
        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("input[type='submit'].js-addtocart");
        var $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder");
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Define if event comes from quickshop or product page #}

        var isQuickShop = $productContainer.hasClass('js-quickshop-container');

         {# Added item information for notification #}

        if (!isQuickShop) {
            if($(".js-product-slide-img.js-active-variant").length) {
                var imageSrc = $($productContainer.find('.js-product-slide-img.js-active-variant')[0]).data('srcset').split(' ')[0];
            } else {
                var imageSrc = $($productContainer.find('.js-product-slide-img')[0]).data('srcset').split(' ')[0];
            }
            var quantity = $productContainer.find('.js-quantity-input').val();
            var name = $productContainer.find('.js-product-name').text();
            var price = $productContainer.find('.js-price-display').text();
            var addedToCartCopy = "{{ 'Agregar al carrito' | translate }}";
        } else {
            var imageSrc = getQuickShopImgSrc(this);
            var quantity = 1;
            var name = $productContainer.find('.js-item-name').text();
            var price = $productContainer.find('.js-price-display').text().trim();
            var addedToCartCopy = "{{ 'Comprar' | translate }}";
            if ($productContainer.hasClass("js-quickshop-has-variants")) {
                var addedToCartCopy = "{{ 'Agregar al carrito' | translate }}";
            }else{
                var addedToCartCopy = "{{ 'Comprar' | translate }}";
            }
        }

        if (!$(this).hasClass('contact')) {

            {% if settings.ajax_cart %}
                e.preventDefault();
            {% endif %}

            {# Hide real button and show button placeholder during event #}

            $productButton.hide();
            $productButtonPlaceholder.css('display' , 'inline-block');
            $productButtonText.fadeOut();
            $productButtonAdding.addClass("active");

            {% if settings.ajax_cart %}

                var callback_add_to_cart = function(){

                    {# Animate cart amount #}

                    $(".js-cart-widget-amount").addClass("swing");

                    setTimeout(function(){
                        $(".js-cart-widget-amount").removeClass("swing");
                    },6000);

                    {# Fill notification info #}

                    $('.js-cart-notification-item-img').attr('srcset', imageSrc);
                    $('.js-cart-notification-item-name').text(name);
                    $('.js-cart-notification-item-quantity').text(quantity);
                    $('.js-cart-notification-item-price').text(price);

                    if($productVariants.length){
                        var output = [];

                        $productVariants.each( function(){
                            var variants = $(this);
                            output.push(variants.val());
                        });
                        $(".js-cart-notification-item-variant-container").show();
                        $(".js-cart-notification-item-variant").text(output.join(', '))
                    }else{
                        $(".js-cart-notification-item-variant-container").hide();
                    }

                    {# Set products amount wording visibility #}

                    var cartItemsAmount = $(".js-cart-widget-amount").first().text();

                    if(cartItemsAmount > 1){
                        $(".js-cart-counts-plural").show();
                        $(".js-cart-counts-singular").hide();
                    }else{
                        $(".js-cart-counts-singular").show();
                        $(".js-cart-counts-plural").hide();
                    }

                    {# Show button placeholder with transitions #}

                    $productButtonAdding.removeClass("active");
                    $productButtonSuccess.addClass("active");
                    setTimeout(function(){
                        $productButtonSuccess.removeClass("active");
                        $productButtonText.fadeIn();
                    },2000);
                    setTimeout(function(){
                        $productButtonPlaceholder.removeAttr("style").hide();
                        $productButton.show();
                    },3000);

                    $productContainer.find(".js-added-to-cart-product-message").slideDown();

                    {# Show notification and hide it only after second added to cart #}

                    setTimeout(function(){
                        $(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");
                    },500);

                    if (!cookieService.get('first_product_added_successfully')) {
                        cookieService.set('first_product_added_successfully', 1, 7 );
                    } else{
                        setTimeout(function(){
                            $(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                            setTimeout(function(){
                                $('.js-cart-notification-item-img').attr('src', '');
                                $(".js-alert-added-to-cart").hide();
                            },2000);
                        },8000);
                    }


                    {# Update shipping input zipcode on add to cart #}

                    {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                    if ($("#product-shipping-container .js-shipping-input").val()) {
                        zipcode_on_addtocart = $("#product-shipping-container .js-shipping-input").val();
                        $("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                        $(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                    } else if (cookieService.get('calculator_zipcode')){
                        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                        $('.js-shipping-input').val(zipcode_from_cookie);
                        $(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                    }


                    {# Update free shipping wording #}

                    $(".js-fs-add-this-product").hide();
                    $(".js-fs-add-one-more").show();

                }
                var callback_error = function(){
                    {# Restore real button visibility in case of error #}

                    $productButtonAdding.removeClass("active");
                    $productButtonText.fadeIn();
                    $productButtonPlaceholder.removeAttr("style").hide();
                    $productButton.show();
                }
                $prod_form = $(this).closest("form");
                LS.addToCartEnhanced(
                    $prod_form,
                    addedToCartCopy,
                    '{{ "Agregando..." | translate }}',
                    '{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito." | translate }}',
                    {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                        callback_add_to_cart,
                        callback_error
                );
            {% endif %}
        }
    });


    {# /* // Cart quantitiy changes */ #}

    $(document).on("keypress", ".js-cart-quantity-input", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $(document).on("focusout", ".js-cart-quantity-input", function (e) {
        var itemID = $(this).attr("data-item-id");
        var itemVAL = $(this).val();
        if (itemVAL == 0) {
            var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
            if (r == true) {
                LS.removeItem(itemID, true);
            } else {
                $(this).val(1);
            }
        } else {
            LS.changeQuantity(itemID, itemVAL, true);
        }
    });

    {# /* // Empty cart alert */ #}

    $(".js-trigger-empty-cart-alert").click(function (e) {
        e.preventDefault();
        $(".js-mobile-nav-empty-cart-alert").fadeIn(100).delay(1500).fadeOut(500);
    });

    {# /* // Go to checkout */ #}

    {# Clear cart notification cookie after consumers continues to checkout #}

    $('form[action="{{ store.cart_url | escape('js') }}"]').submit(function() {
        cookieService.remove('first_product_added_successfully');
    });


	{#/*============================================================================
	  #Shipping calculator
	==============================================================================*/ #}

    {# /* // Update calculated cost wording */ #}

    {% if settings.shipping_calculator_cart_page %}
        if ($('.js-selected-shipping-method').length) {
            var shipping_cost = $('.js-selected-shipping-method').data("cost");
            var $shippingCost = $("#shipping-cost");
            $shippingCost.text(shipping_cost);
            $shippingCost.removeClass('opacity-40');
        }
    {% endif %}

	{# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        $(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        $(elem).addClass('js-selected-shipping-method');

        {% if settings.shipping_calculator_cart_page %}

            var shipping_cost = $(elem).data("cost");
            var shipping_price_clean = $(elem).data("price");

            if(shipping_price_clean = 0.00){
                var shipping_cost = '{{ Gratis | translate }}'
            }

            // Updates shipping (ship and pickup) cost on cart
            var $shippingCost = $("#shipping-cost");
            $shippingCost.text(shipping_cost);
            $shippingCost.removeClass('opacity-40');

        {% endif %}

        if (save_option) {
            LS.saveCalculatedShipping(true);
        }
        if ($(elem).hasClass("js-shipping-method-hidden")) {
            {# Toggle other options visibility depending if they are pickup or delivery for cart and product at the same time #}
            if ($(elem).hasClass("js-pickup-option")) {
                $(".js-other-pickup-options, .js-show-other-pickup-options .js-shipping-see-less").show();
                $(".js-show-other-pickup-options .js-shipping-see-more").hide();
            } else {
                $(".js-other-shipping-options, .js-show-more-shipping-options .js-shipping-see-less").show();
                $(".js-show-more-shipping-options .js-shipping-see-more").hide()
            }
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to triggert automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');

        {% if settings.ajax_cart %}

            {# If ajax cart is active, target only product input to avoid extra calulation on empty cart #}

            $('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);

        {% else %}

            {# If ajax cart is inactive, target the only input present on screen #}

            $('.js-shipping-input').val(zipcode_from_cookie);

        {% endif %}

        $(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        $(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        $(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        $(".js-shipping-calculator-spinner").show();
    } else {

        {# If there is no cookie saved, show calcualtor #}

        $(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = $(".js-modal-shipping-suboptions").attr("id");
        $("#" + shipping_suboptions_id).remove();
        $('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Calculate shipping function */ #}


	$(".js-calculate-shipping").click(function (e) {
	    e.preventDefault();

        {# Take the Zip code to all shipping calculators on screen #}
        let shipping_input_val = $(this).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        $(".js-shipping-input").val(shipping_input_val);

        {# Calculate on page load for both calculators: Product and Cart #}
        {% if template == 'product' %}
             if (!vanillaJS) {
                LS.calculateShippingAjax(
                    $('#product-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    $("#product-shipping-container").closest(".js-shipping-calculator-container") );
             }
        {% endif %}

        if ($(".js-cart-item").length) {
            LS.calculateShippingAjax(
            $('#cart-shipping-container').find(".js-shipping-input").val(),
            '{{store.shipping_calculator_url | escape('js')}}',
            $("#cart-shipping-container").closest(".js-shipping-calculator-container") );
        }

        $(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();
	});

	{# /* // Calculate shipping by submit */ #}

	$(".js-shipping-input").keydown(function (e) {
	    var key = e.which ? e.which : e.keyCode;
	    var enterKey = 13;
	    if (key === enterKey) {
	        e.preventDefault();
	        $(this).closest(".js-shipping-calculator-form").find(".js-calculate-shipping").click();
	        if ($(window).width() < 768) {
	            $(this).blur();
	        }
	    }
	});

    {# /* // Shipping and branch click */ #}

    $(document).on("change", ".js-shipping-method, .js-branch-method", function () {
        selectShippingOption(this, true);
        $(".js-shipping-method-unavailable").hide();
    });

    {# /* // Select shipping first option on results */ #}

    $('.js-shipping-method:checked').livequery(function () {
        let shippingPrice = $(this).attr("data-price");
        LS.addToTotal(shippingPrice);

        let total = (LS.data.cart.total / 100) + parseFloat(shippingPrice);
        $(".js-cart-widget-total").html(LS.formatToCurrency(total));

        selectShippingOption(this, false);
    });

    {# /* // Toggle branches link */ #}

    $(document).on("click", ".js-toggle-branches", function (e) {
        e.preventDefault();
        $(".js-store-branches-container").slideToggle("fast");
        $(".js-see-branches, .js-hide-branches").toggle();
    });

    {# /* // Toggle more shipping options */ #}

	$(document).on("click", ".js-toggle-more-shipping-options", function(e) {
	    e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if($(this).hasClass("js-show-other-pickup-options")){
            $(".js-other-pickup-options").slideToggle(600);
            $(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            $(".js-other-shipping-options").slideToggle(600);
            $(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
	});

    {# /* // Calculate shipping on page load */ #}

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function() {
        {# Triggers function when a zipcode input is filled #}
        if ($("#cart-shipping-container .js-shipping-input").val()) {
            // If user already had calculated shipping: recalculate shipping
            setTimeout(function() {
                LS.calculateShippingAjax(
                    $('#cart-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    $("#cart-shipping-container").closest(".js-shipping-calculator-container") );
                    removeShippingSuboptions();
            }, 100);
        }

        if ($(".js-branch-method").hasClass('js-selected-shipping-method')) {
            {% if store.branches|length > 1 %}
                $(".js-store-branches-container").slideDown("fast");
                $(".js-see-branches").hide();
                $(".js-hide-branches").show();
            {% endif %}
        }
    };

    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}


    {% if template == 'product' %}
        if (!vanillaJS) {
            {# /* // Calculate product detail shipping on page load */ #}

            if($('#product-shipping-container').find(".js-shipping-input").val()){
                setTimeout(function() {
                    LS.calculateShippingAjax(
                        $('#product-shipping-container').find(".js-shipping-input").val(),
                        '{{store.shipping_calculator_url | escape('js')}}',
                        $("#product-shipping-container").closest(".js-shipping-calculator-container") );

                    removeShippingSuboptions();
                }, 100);
            }
        }

        {# /* // Pitch login instead of zipcode helper if is returning customer */ #}

        {% if not customer %}
            if (cookieService.get('returning_customer')) {
                $('.js-shipping-zipcode-help').remove();
            } else {
                $('.js-product-quick-login').remove();
            }
        {% endif %}

    {% endif %}

    {# /* // Change CP */ #}

    $(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        $(".js-shipping-calculator-response").fadeOut(100);
        $(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        $(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        $(".js-shipping-calculator-form").addClass("transition-up-active");
    });

	{# /* // Shipping provinces */ #}

	{% if provinces_json %}
		$('select[name="country"]').change(function () {
		    var provinces = {{ provinces_json | default('{}') | raw }};
		    LS.swapProvinces(provinces[$(this).val()]);
		}).change();
	{% endif %}


    {# /* // Change store country: From invalid zipcode message */ #}

    $(document).on("click", ".js-save-shipping-country", function(e) {

        e.preventDefault();

        {# Change shipping country #}

        var selected_country_url = $(this).closest(".js-modal-shipping-country").find(".js-shipping-country-select option:selected").attr("data-country-url");
        location.href = selected_country_url;

        $(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });

    {#/*============================================================================
      #Forms
    ==============================================================================*/ #}

    $(".js-winnie-pooh-form").submit(function (e) {
        $(this).attr('action', '');
    });

    $(".js-form").submit(function (e) {
        $(this).find('.js-form-spinner').show();
    });

    {% if template == 'account.login' %}
        {% if result.invalid %}
            $(".js-account-input").addClass("alert-danger");
            $(".js-account-input.alert-danger").focus(function() {
              $(".js-account-input").removeClass("alert-danger");
            });
        {% endif %}
    {% endif %}

    {# Show the success or error message when resending the validation link #}

    {% if template == 'account.register' or template == 'account.login' %}
        $(".js-resend-validation-link").click(function(e){
            window.accountVerificationService.resendVerificationEmail('{{ customer_email }}');
        });
    {% endif %}

    $('.js-password-view').click(function () {
        $(this).toggleClass('password-view');

        if($(this).hasClass('password-view')){
           $(this).parent().find(".js-password-input").attr('type', '');
           $(this).find(".js-eye-open, .js-eye-closed").toggle();
        } else {
           $(this).parent().find(".js-password-input").attr('type', 'password');
           $(this).find(".js-eye-open, .js-eye-closed").toggle();
        }
    });

    {% if store.country == 'AR' and template == 'home' %}

        if (cookieService.get('returning_customer') && LS.shouldShowQuickLoginNotification()) {
            {# Make login link toggle quick login modal #}
            $(".js-login").removeAttr("href").attr("data-toggle", "#quick-login").addClass("js-modal-open js-trigger-modal-zindex-top");
        }
    {% endif %}


    {#/*============================================================================
      #Footer
    ==============================================================================*/ #}

    {% if store.afip %}

        {# Add alt attribute to external AFIP logo to improve SEO #}

        $('img[src*="www.afip.gob.ar"]').attr('alt', '{{ "Logo de AFIP" | translate }}');

    {% endif %}


    {#/*============================================================================
      #Empty placeholders
    ==============================================================================*/ #}

    {% if template == 'home' %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var slider_empty_autoplay = {delay: 6000,};
        } else {
            var slider_empty_autoplay = false;
        }

        window.homeEmptySlider = {
            getAutoRotation: function() {
                return slider_empty_autoplay;
            },
        };
        createSwiper('.js-home-empty-slider', {
            {% if not params.preview %}
            lazy: true,
            {% endif %}
            loop: true,
            autoplay: slider_empty_autoplay,
            pagination: {
                el: '.js-swiper-empty-home-pagination',
                clickable: true,
                renderBullet: function (index, className) {
                  return '<span class="' + className + '">' + (index + 1) + '</span>';
                },
            },
            navigation: {
                nextEl: '.js-swiper-empty-home-next',
                prevEl: '.js-swiper-empty-home-prev',
            },
            on: {
                init: function () {
                  $(".js-home-empty-slider").css({"visibility" : "visible" , "height" : "100%"});
                },
            },
        });


        {# /* // Banner services slider */ #}
        var width = window.innerWidth;
        if (width < 767) {
            createSwiper('.js-informative-banners', {
                slidesPerView: 1.2,
                watchOverflow: true,
                centerInsufficientSlides: true,
                pagination: {
                    el: '.js-informative-banners-pagination',
                    clickable: true,
                },
                breakpoints: {
                    640: {
                        slidesPerView: 3,
                    }
                }
            });
        }

        {# /* // Brands slider */ #}
        createSwiper('.js-swiper-brands', {
            lazy: true,
            loop: true,
            watchOverflow: true,
            centerInsufficientSlides: true,
            spaceBetween: 30,
            slidesPerView: 1.5,
            navigation: {
                nextEl: '.js-swiper-brands-next',
                prevEl: '.js-swiper-brands-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: 5,
                }
            }
        });

    {% endif %}

    {% set show_help = not has_products %}
    {% if template == '404' and show_help %}

        {# /* // Product Related */ #}

        {% set columns = settings.grid_columns %}
        createSwiper('.js-swiper-related', {
            lazy: true,
            loop: true,
            watchOverflow: true,
            centerInsufficientSlides: true,
            slidesPerView: 1.5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            slideVisibleClass: 'js-swiper-slide-visible',
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: {% if columns == 2 %}4{% else %}3{% endif %},
                }
            }
        });

        {# /* // Product slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var speedVal = 0;
            var loopVal = false;
            var spaceBetweenVal = 0;
            var slidesPerViewVal = 1;
        } else {
            var speedVal = 300;
            var loopVal = true;
            var spaceBetweenVal = 10;
            var slidesPerViewVal = 1.2;
        }

        createSwiper('.js-swiper-product', {
            lazy: true,
            speed: speedVal,
            {% if product.images_count > 1 %}
            loop: loopVal,
            slidesPerView: slidesPerViewVal,
            centeredSlides: true,
            spaceBetween: spaceBetweenVal,
            {% endif %}
            pagination: {
                el: '.js-swiper-product-pagination',
                type: 'fraction',
                clickable: true,
            },
            on: {
                init: function () {
                  $(".js-product-slider-placeholder").hide();
                  $(".js-swiper-product").css({"visibility" : "visible" , "height" : "auto"});
                },
            },
        });

        {# /* 404 handling to show the example product */ #}

        if ( window.location.pathname === "/product/example/" || window.location.pathname === "/br/product/example/" ) {
            document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
            $("#404").hide();
            $("#product-example").show();
        } else {
            $("#product-example").hide();
        }

    {% endif %}

});
