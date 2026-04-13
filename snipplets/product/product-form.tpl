{# Product name and breadcrumbs #}

{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
{% endembed %}

{# Product price #}
{% set is_subscription_only_product = product.isSubscribable() and product.isSubscriptionOnly() %}

{{ component('nubesdk-slot', { type: "before_product_detail_price" }) }}

{% if not is_subscription_only_product %}
    <div class="js-price-container price-container mb-4" data-store="product-price-{{ product.id }}">
        <span class="d-inline-block">
            <h4 id="compare_price_display" class="js-compare-price-display price-compare font-weight-normal mb-0" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</h4>
        </span>
        <span class="d-inline-flex align-items-center">
            <h2 class="js-price-display text-primary mb-0" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">{% if product.display_price %}{{ product.price | money }}{% endif %}</h2>
            {{ component('promotional-price-details', {
                promotional_price_details_classes: {
                    container: 'tooltip-container position-relative ml-1',
                    trigger: 'tooltip-trigger text-accent',
                    icon: 'icon-inline icon-lg',
                    detail_container: 'tooltip-card',
                    detail_row: 'd-flex justify-content-between align-items-center py-1 font-small',
                    detail_divider: 'divider mt-2 mb-2',
                    detail_total: 'font-weight-bold opacity-60'
                },
                promotional_price_details_icon_svg_id: 'tag',
            }) }}
        </span>

        {% set show_compare_price_saved_amount = not (settings.payment_discount_price and product.maxPaymentDiscount.value > 0) and settings.compare_price_saved_money %}

        {% set price_discount_disclaimer_margin_class = show_compare_price_saved_amount ? 'mt-2' : 'mt-1' %}

        {{ component('price-discount-disclaimer', {
            container_classes: 'font-small opacity-60 ' ~ price_discount_disclaimer_margin_class ~ ' mb-2',
        }) }}

        {{ component('price-without-taxes', {
                container_classes: "mt-1 mb-2 font-small opacity-60",
            })
        }}

        {{ component('payment-discount-price', {
                visibility_condition: settings.payment_discount_price,
                location: 'product',
                container_classes: "h4 text-accent font-weight-bold mt-1",
            })
        }}

        {{ component('compare-price-saved-amount', {
                visibility_condition: show_compare_price_saved_amount,
                discount_percentage_wording: 'OFF',
                container_classes: "d-flex align-items-center mt-2",
                text_classes: {
                    amount_message_container: 'd-inline-block',
                    amount_message: 'font-small',
                },
                discount_percentage_classes: 'ml-2 label label-small label-accent m-0',
            })
        }}
    </div>
{% endif %}

{{ component('nubesdk-slot', { type: "after_product_detail_price" }) }}

{{ component('subscriptions/subscription-price', {
    subscription_classes: {
        container: 'mb-4',
        price_compare: 'price-compare h4 font-weight-normal mb-0',
        price_with_subscription: 'h2 text-primary mb-0',
        discount_container: 'h4 text-accent font-weight-bold mt-1 pb-1',
        price_without_taxes_container: 'mt-1 font-small opacity-60',
    },
}) }}

{{ component('promotions-details', {
    promotions_details_classes: {
        container: 'js-product-promo-container mb-4',
        promotion_title: 'h4 mb-2 text-accent',
        valid_scopes: 'mb-0',
        categories_combinable: 'mb-0',
        not_combinable: 'font-small opacity-60 mt-1 mb-0',
        progressive_discounts_table: 'table mb-2 mt-3',
        progressive_discounts_hidden_table: 'table-body-inverted',
        progressive_discounts_show_more_link: 'btn-link btn-link-primary mb-4',
        progressive_discounts_show_more_icon: 'icon-inline',
        progressive_discounts_hide_icon: 'icon-inline icon-flip-vertical',
        progressive_discounts_promotion_quantity: 'font-weight-light text-lowercase'
    },
    accordion_show_svg_id: 'chevron-down',
    accordion_hide_svg_id: 'chevron-down',
}) }}

{# Product installments #}

{% set installments_info = product.installments_info_from_any_variant %}
{% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
{% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}

{% if show_payments_info or hasDiscount %}
    <div data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments" class="js-modal-open js-fullscreen-modal-open js-product-payments-container row mb-4" {% if not product.display_price or not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>

        {% if show_payments_info %}
            {% set max_installments_without_interests = product.get_max_installments(false) %}
            {% set installments_without_interests = max_installments_without_interests and max_installments_without_interests.installment > 1 %}
            {% set card_icon_color = installments_without_interests ? 'svg-icon-accent' : 'svg-icon-text' %}

            <div class="js-product-installments-container col-12 mb-2">
                <span class="float-left mr-2">
                    <svg class="icon-inline icon-lg {{ card_icon_color }}"><use xlink:href="#credit-card"/></svg>
                </span>
                {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "product-detail-installments d-table"}}) }}
            </div>
        {% endif %}

        {% set discountContainerStyle = not (hasDiscount and product.showMaxPaymentDiscount) ? "display: none" %}
        <div class="js-product-discount-container w-100" style="{{ discountContainerStyle }}">
            <div class="col-12 mb-2 d-flex">
                <span class="mr-2">
                    <svg class="icon-inline svg-icon-accent icon-lg"><use xlink:href="#money-bill"/></svg>
                </span>
                <span>
                    <div><strong class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}</div>
                    {% set discountDisclaimerStyle = not product.showMaxPaymentDiscountNotCombinableDisclaimer ? "display: none" %}
                    <div class="js-product-discount-disclaimer font-small opacity-60 mt-1" style="{{ discountDisclaimerStyle }}">
                        {{ (product.showMaxPaymentDiscountCombinesWithSomeDiscounts
                            ? "No acumulable con algunas promociones"
                            : "No acumulable con otras promociones")
                        | translate }}
                    </div>
                </span>
            </div>
        </div>
        <a id="btn-installments" class="btn-link btn-link-primary font-small col mt-1" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
            <span class="d-table">
                {% if not hasDiscount and not settings.product_detail_installments %}
                    <svg class="icon-inline icon-lg svg-icon-primary mr-1"><use xlink:href="#credit-card"/></svg>
                    {{ "Ver medios de pago" | translate }}
                {% else %}
                    {{ "Ver más detalles" | translate }}
                {% endif %}
            </span>
        </a>
    </div>
{% endif %}

{# Product availability #}

{% set show_product_quantity = product.available and product.display_price %}

{# Free shipping minimum message #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_product_free_shipping = product.free_shipping %}

{% if not product.is_non_shippable and show_product_quantity and (has_free_shipping or has_product_free_shipping) %}
    <div class="js-free-shipping-message free-shipping-message mb-4">
        <span class="float-left mr-2">
            <svg class="icon-inline svg-icon-accent icon-lg"><use xlink:href="#truck"/></svg>
        </span>
        <span>
            <strong class="text-accent">{{ "Envío gratis" | translate }}</strong>
            <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                {{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
            </span>
        </span>
        {% if not has_product_free_shipping %}
            <div class="js-free-shipping-discount-not-combinable font-small opacity-60 mt-1">
                {{ "No acumulable con otras promociones" | translate }}
            </div>
        {% endif %}
    </div>
{% endif %}

{# Product form, includes: Variants, CTA and Shipping calculator #}

 <form id="product_form" class="js-product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
	<input type="hidden" name="add_to_cart" value="{{product.id}}" />
 	{% if product.variations %}
        {% include "snipplets/product/product-variants.tpl" with {show_size_guide: true} %}
    {% endif %}

    {% if settings.last_product and show_product_quantity %}
        <div class="{% if product.variations %}js-last-product {% endif %}text-accent font-weight-bold mb-4"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
            {{ settings.last_product_text }}
        </div>
        {% if settings.latest_products_available %}
            {% set latest_products_limit = settings.latest_products_available %}
            <div class="{% if product.variations %}js-latest-products-available {% endif %}text-accent font-weight-bold mb-4" data-limit="{{ latest_products_limit }}" {% if product.selected_or_first_available_variant.stock > latest_products_limit or product.selected_or_first_available_variant.stock == null or product.selected_or_first_available_variant.stock == 1 %} style="display: none;"{% endif %}>
                {{ "¡Solo quedan" | translate }} <span class="js-product-stock">{{ product.selected_or_first_available_variant.stock }}</span> {{ "en stock!" | translate }}
            </div>
        {% endif %}
    {% endif %}

    {{ component('nubesdk-slot', { type: "before_product_detail_add_to_cart" }) }}

    <div class="form-row mb-2">
        {% if show_product_quantity %}
            {% include "snipplets/product/product-quantity.tpl" %}
        {% endif %}

        {{ component('subscriptions/subscription-selector', {
            subscription_classes: {
                container: 'radio-buttons-group box p-0 mt-2 mx-2 mb-3',
                subscription_only_container: 'p-3',

                radio_button: 'radio-button-item',
                radio_button_text: 'row no-gutters',
                radio_button_icon: 'radio-button-icons',
                radio_button_icon_svg: 'icon-inline icon-sm svg-icon-primary',
                purchase_option_info_container: 'col-8 col-md-9 font-small pr-0',
                purchase_option_price: 'col-4 col-md-3 text-right font-weight-bold',
                purchase_option_single_frequency: 'mt-2 pt-1 font-small opacity-60',
                purchase_option_discount: 'label label-accent label-small ml-1',

                dropdown_container: 'row no-gutters mt-2 pt-1 position-relative',
                dropdown_button: 'form-select position-relative p-2',
                dropdown_icon: 'form-select-icon icon-inline icon-w-14 icon-lg',
                dropdown_options: 'form-select-options',
                dropdown_option: 'form-select-option row no-gutters',
                dropdown_option_info: 'col pr-4',
                dropdown_option_price: 'col-auto font-weight-bold',
                dropdown_option_discount: 'text-accent mt-1 font-weight-bold',

                cart_alert: 'font-small text-center subscription-btn-alert float-left w-100',
                cart_alert_icon: 'icon-inline mr-1',
                shipping_message: 'mt-3',
                shipping_message_icon: 'icon-inline icon-lg icon-w-20 svg-icon-text mr-1 align-text-bottom',
                shipping_message_title: 'ml-1 font-weight-bold',
                shipping_message_text: 'font-small mt-2 ml-4 pl-2',

                legal_message: 'font-smallest text-center mb-1 px-3',
                legal_link: 'font-smallest d-inline-block btn-link btn-link-primary p-0',
                legal_modal: 'bottom modal-centered-small modal-centered transition-soft',
                legal_modal_header: 'modal-header row no-gutters',
                legal_modal_title: 'col',
                legal_modal_close_button: 'col-auto mr-3 mr-md-0 ml-md-2 order-first order-md-last',
                legal_modal_close_icon: 'icon-inline modal-close-icon icon-w-10',
                legal_modal_body: 'mb-4',
                legal_modal_details_title: 'font-body mb-2',
                legal_modal_details_paragraph: 'font-small pb-4 mb-0',
                legal_modal_details_link: 'font-small d-inline-block btn-link btn-link-primary p-0'
            },
            allow_subscription_only: is_subscription_only_product,

            radio_button_checked_icon: true,
            radio_button_checked_icon_svg_id: 'check',

            dropdown_icon: true,
            dropdown_icon_svg_id: 'chevron-down',

            cart_alert_icon: true,
            cart_alert_icon_svg_id: 'info-circle',

            shipping_message_icon: true,
            shipping_message_icon_svg_id: 'truck',

            legal_modal_close_icon_id: 'times',
        }) }}

        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
        <div class="{% if product.isSubscribable() %}col-12 mt-2{% else %}col-8 pr-0{% endif %}">

            {# Add to cart CTA #}

            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block mb-4 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart"/>

            {# Fake add to cart CTA visible during add to cart event #}

            {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "mb-4"} %}

        </div>

        {% if settings.ajax_cart %}
            <div class="col-12">
                <div class="js-added-to-cart-product-message mb-4" style="display: none;">
                    <svg class="icon-inline svg-icon-text mr-2 d-table float-left"><use xlink:href="#check-double"/></svg>
                    <span class="d-table">
                        {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-fullscreen-modal-open btn btn-link ml-1 text-primary" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                    </span>
                </div>
            </div>
        {% endif %}
    </div>

    {{ component('nubesdk-slot', { type: "after_product_detail_add_to_cart" }) }}

    {# Free shipping visibility message #}

    {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

    {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

    {% if not product.is_non_shippable and show_product_quantity and has_free_shipping and not has_product_free_shipping %}

        {# Free shipping add to cart message #}

        {% if include_product_free_shipping_min_wording %}

            {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

        {% endif %}

        {# Free shipping achieved message #}

        <div class="js-product-form-free-shipping-message {% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} text-accent font-weight-bold mb-4" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
            {{ "¡Genial! Tenés envío gratis" | translate }}
        </div>

    {% endif %}

    {# Define contitions to show shipping calculator and store branches on product page #}

    {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

    {% if show_product_fulfillment %}

        {# Shipping calculator and branch link #}

        <div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

            {% if store.has_shipping %}
                {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
            {% endif %}
            {% if store.branches %}

                {# Link for branches #}
                {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
            {% endif %}
        </div>
    {% endif %}

    {# Product informative banners #}

    {% include 'snipplets/product/product-informative-banner.tpl' %}
 </form>

{# Product payments details #}

{% include 'snipplets/product/product-payment-details.tpl' %}

