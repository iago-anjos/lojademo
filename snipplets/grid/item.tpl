{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set empty_placeholder_image = 'images/empty-placeholder.png' | static_url %}

{% set slide_item = slide_item | default(false) %}
{% set columns = settings.grid_columns %}

{% if slide_item %}
    <div class="swiper-slide{% if settings.theme_rounded and not reduced_item %} p-3{% endif %}">
{% endif %}

{% set grid_classes = columns == 1 ? 'col-12 col-md-6 col-lg-4' : 'col-6 col-md-4 col-lg-3' %}
{% set reduced_item_class = reduced_item ? 'item-product-reduced m-0 p-0' %}

{# Item image slider #}

{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider 
    and not slide_item
    and not reduced_item 
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'item-slider-controls-container svg-circle svg-icon-text d-none d-md-block' %}
    {% set slider_controls_thickness_class = settings.icons_solid ? 'svg-solid' %}
    {% set control_next_svg_id = 'chevron' %}
    {% set control_prev_svg_id = 'chevron' %}    
{% endif %}

{# Secondary images #}

{% set show_secondary_image = settings.product_hover %}

{% if settings.theme_rounded %}
    <div class="js-item-product {% if highlighted_products_setting_name %}js-products-{{ highlighted_products_setting_name }}-product{% endif %} {% if not slide_item %}{{ grid_classes }}{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}" data-grid-classes="{{ grid_classes }}">
        <div class="item item-rounded item-product box-rounded p-0 {{ reduced_item_class }}">
{% else %}
    <div class="js-item-product {% if highlighted_products_setting_name %}js-products-{{ highlighted_products_setting_name }}-product{% endif %} {% if not slide_item %}{{ grid_classes }}{% endif %} item item-product {{ reduced_item_class }}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}" data-grid-classes="{{ grid_classes }}">
{% endif %}

        {% if (settings.quick_shop or settings.product_color_variants) and not reduced_item %}
            <div id="quick{{ product.id }}{% if slide_item and section_name %}-{{ section_name }}{% endif %}" class="js-product-container js-quickshop-container position-relative {% if product.variations %}js-quickshop-has-variants{% endif %}" data-variants="{{ product.variants_object | json_encode }}">
        {% endif %}

        {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

        {% set image_classes = 'js-item-image lazyautosizes ' ~ (not image_priority_high ? 'lazyload') ~ ' fade-in img-absolute img-absolute-centered' %}
            
        {% set data_expand = show_image_slider ? '50' : '-10' %}
            
        {% set floating_elements %}

            {% if not reduced_item %}
                {% if settings.product_color_variants %}
                    {% include 'snipplets/labels.tpl' with {color: true} %}
                    {% include 'snipplets/grid/item-colors.tpl' %}
                {% else %}
                    {% include 'snipplets/labels.tpl' %}
                {% endif %}
            {% endif %}
            {% if (settings.quick_shop or settings.product_color_variants) and product.available and product.display_price and product.variations and not reduced_item %}
                <div class="item-buy{% if settings.product_color_variants and not settings.quick_shop %} hidden{% endif %}">
                    <div class="js-item-variants item-buy-variants{% if settings.theme_rounded %} px-1 py-2 p-md-3{% endif %}">
                        <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                            {% if product.variations %}
                                {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                            {% endif %}
                            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                            {# Add to cart CTA #}

                            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-small w-100 mb-2 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                            {# Fake add to cart CTA visible during add to cart event #}

                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-small w-100 mb-2"} %}
                        </form>
                        <a href="#" class="js-item-buy-close">
                            <svg class="icon-inline icon-lg svg-circle svg-icon-text"><use xlink:href="#times"/></svg>
                        </a>
                    </div>
                </div>
            {% endif %}

        {% endset %}

        {{ component(
            'product-item-image', {
                image_lazy: true,
                image_lazy_js: true,
                image_thumbs: ['small', 'medium', 'large'],
                image_data_expand: data_expand,
                image_secondary_data_sizes: 'auto',
                secondary_image: show_secondary_image,
                slider: show_image_slider,
                placeholder: true,
                image_priority_high: image_priority_high,
                custom_content: floating_elements,
                slider_pagination_container: true,
                product_item_image_classes: {
                    image_container: 'item-image' ~ (columns == 1 ? ' item-image-big') ~ (show_image_slider ? ' item-image-slider'),
                    image: image_classes,
                    image_featured: 'item-image-featured',
                    image_secondary: 'item-image-secondary',
                    slider_container: 'swiper-container position-absolute h-100 w-100',
                    slider_wrapper: 'swiper-wrapper',
                    slider_slide: 'swiper-slide item-image-slide',
                    slider_control_pagination_container: 'item-slider-pagination-container d-md-none ' ~ (product.images_count == 2 ? 'two-bullets'),
                    slider_control_pagination: 'swiper-pagination item-slider-pagination',
                    slider_control: 'icon-inline icon-lg',
                    slider_control_prev_container: 'swiper-button-prev ' ~ slider_controls_container_class ~ ' ' ~ slider_controls_thickness_class,
                    slider_control_prev: 'icon-flip-horizontal',
                    slider_control_next_container: 'swiper-button-next ' ~ slider_controls_container_class ~ ' ' ~ slider_controls_thickness_class,
                    more_images_message: 'item-more-images-message',
                    placeholder: 'placeholder-fade',
                },
                control_next_svg_id: control_next_svg_id,
                control_prev_svg_id: control_prev_svg_id,
            })
        }}

        {# Subscription data - calculate only is_subscription_only for the CTA button #}
        {% set is_subscription_only = product.isSubscriptionOnly() %}

        <div class="item-description {% if reduced_item %}py-3{% else %}py-4{% endif %}{% if settings.theme_rounded %} px-3{% else %} px-1{% endif %}" data-store="product-item-info-{{ product.id }}">
            <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link">
                {{ component('nubesdk-slot', { type: "before_product_grid_item_name" }) }}
                <div class="js-item-name item-name {% if reduced_item %}mb-2{% else %}mb-3{% endif %}" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                {{ component('nubesdk-slot', { type: "after_product_grid_item_name" }) }}
                {{ component('nubesdk-slot', { type: "before_product_grid_item_price" }) }}
                {% if product.display_price %}
                    {% if is_subscription_only %}
                        {# Subscription only products: use subscription-price component with product_list location #}
                        {{ component('subscriptions/subscription-price', {
                            location: 'product_list',
                            subscription_classes: {
                                container: 'item-price-container mb-1',
                                price_compare: 'price-compare',
                                price_with_subscription: 'item-price',
                            },
                        }) }}
                    {% else %}
                        {# Normal products: original price display #}
                        <div class="item-price-container mb-1" data-store="product-item-price-{{ product.id }}">
                            {% if not reduced_item %}
                                <span class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %}>
                                    {{ product.compare_at_price | money }}
                                </span>
                            {% endif %}
                            <span class="js-price-display item-price" data-product-price="{{ product.price }}">
                                {{ product.price | money }}
                            </span>
                        </div>
                    {% endif %}
                {% endif %}
                {{ component('nubesdk-slot', { type: "after_product_grid_item_price" }) }}
            </a>

            {% if not reduced_item %}
                {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.product_installments and not is_subscription_only %}

                {% set discount_price_spacing_classes = product_can_show_installments ? 'mt-1 mb-2' %}

                {{ component('payment-discount-price', {
                        visibility_condition: settings.payment_discount_price and not is_subscription_only,
                        location: 'product',
                        container_classes: discount_price_spacing_classes ~ " font-small font-md-normal text-accent font-weight-bold",
                    }) 
                }}

                {% if product_can_show_installments %}
                    {{ component('installments', {'location' : 'product_item', container_classes: { installment: "item-installments"}}) }}
                {% endif %}

                {% if not reduced_item %}
                
                    {{ component('subscriptions/subscription-message', {
                        subscription_icon: true,
                        subscription_icon_svg_id: 'returns' ~ (not settings.icons_solid ? '-alt'),
                        subscription_classes: {
                            container: 'mt-2 font-small text-accent font-weight-bold ' ~ (product_can_show_installments ? 'mb-2'),
                            icon: 'icon-inline svg-icon-accent mr-1',
                        },
                    }) }}

                {% endif %}
               
            {% endif %}
        </div>
        {% if not reduced_item %}
            {% if settings.quick_shop %}
                <div class="item-actions row justify-content-center{% if settings.theme_rounded %} m-0 mb-3{% endif %}">
                    {% if product.available and product.display_price %}
                        <div class="col-8 col-md-6 pr-1">

                            {% set quickshop_button_primary_classes = 'btn btn-primary btn-small w-100 mb-2' %}
                            {% set quickshop_button_js_classes = not product.isSubscribable() ? 'js-item-buy-open' %}
                            {% set quickshop_href = product.isSubscribable() ? product_url_with_selected_variant : '#' %}

                            {% if product.isSubscribable() or product.variations %}
                                {% set button_text = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) : ('Comprar' | translate) %}
                                {% set button_title = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) ~ ' ' ~ product.name : ('Compra rápida de' | translate) ~ ' ' ~ product.name %}
                                <a href="{{ quickshop_href }}" class="{{ quickshop_button_js_classes }} {{ quickshop_button_primary_classes }} d-block item-buy-open" title="{{ button_title }}" aria-label="{{ button_title }}" {% if not product.isSubscribable() %}data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"{% endif %}>{{ button_text }}</a>
                            {% else %}
                                <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                    {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                                    {% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                                    <input type="submit" class="js-addtocart js-prod-submit-form {{ quickshop_button_primary_classes }} {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}"/>

                                    {# Fake add to cart CTA visible during add to cart event #}

                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-small w-100 mb-2", direct_add: true} %}
                                </form>
                            {% endif %}
                        </div>
                    {% endif %}
                    <div class="{% if product.available and product.display_price %}col-4 col-md-6 pl-1{% else %}col-12 col-md-6{% endif %}">
                        <a href="{{ product.url }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="d-block btn btn-secondary btn-small">
                            <svg class="icon-inline svg-icon-primary icon-w-19"><use xlink:href="#eye"/></svg>
                            <span class="{% if product.available and product.display_price %}d-none d-md-inline-block{% endif %}">{{ "Ver" | translate }}</span></a>
                    </div>
                </div>
            {% endif %}
            {% if settings.quick_shop or settings.product_color_variants %}
                </div>{# This closes the quickshop tag #}
            {% endif %}
        {% endif %}

        {# Structured data to provide information for Google about the product content #}
        {{ component('structured-data', {'item': true}) }}
    </div>
{% if settings.theme_rounded %}
    </div>
{% endif %}
{% if slide_item %}
    </div>
{% endif %}
