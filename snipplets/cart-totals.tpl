{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

{% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}
  
  {# includes free shipping progress bar: only if store has free shipping with a minimum #}
  
  {% include "snipplets/shipping/shipping-free-rest.tpl" %}
{% endif %}

{# IMPORTANT Do not remove this hidden subtotal, it is used by JS to calculate cart total #}
<div class="js-subtotal-price subtotal-price hidden" data-priceraw="{{ cart.total }}"></div>

{# Used to assign currency to total #}
<div id="store-curr" class="hidden">{{ cart.currency }}</div>

{# Define contitions to show shipping calculator and store branches on cart #}

{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}

{# Cart subtotals for cart popup #}

{% set price_without_taxes_container_classes = "row mt-1 mb-2 pb-1 font-small opacity-60" %}
{% set price_without_taxes_label_classes = "col-7" %}
{% set price_without_taxes_price_classes = "col text-right" %}

{% if not cart_page %}

  {# Cart popup subtotal #}

  <div class="js-visible-on-cart-filled h5 row mb-1" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-subtotal">
    <span {% if not cart_page %}class="col-7"{% endif %}>
      {{ "Subtotal" | translate }}
      
      <small class="js-subtotal-shipping-wording" {% if not (cart.has_shippable_products or show_calculator_on_cart) %}style="display: none"{% endif %}>{{ " (sin envío)" | translate }}</small>
      :
    </span>
    <strong class="js-ajax-cart-total js-cart-subtotal {% if not cart_page %}col{% endif %} text-right" data-priceraw="{{ cart.subtotal }}" data-component="cart.subtotal" data-component-value='{{ cart.subtotal }}'>{{ cart.subtotal | money }}</strong>
  </div>

  {{ component('price-without-taxes', {
      location: 'cart',
      container_classes: price_without_taxes_container_classes,
      text_classes: {
        label: price_without_taxes_label_classes,
        price: price_without_taxes_price_classes,
      },
    })
  }}

  {# Cart popup promos #}

  <div class="js-total-promotions text-accent font-weight-bold">
    <span class="js-promo-discount" style="display:none;"> {{ "Descuento" | translate }}</span>
    <span class="js-promo-in" style="display:none;">{{ "en" | translate }}</span>
    <span class="js-promo-all" style="display:none;">{{ "todos los productos" | translate }}</span>
    <span class="js-promo-buying" style="display:none;"> {{ "comprando" | translate }}</span>
    <span class="js-promo-units-or-more" style="display:none;"> {{ "o más" | translate }}</span>
    {% for promotion in cart.promotional_discount.promotions_applied %}
      {% if not promotion.is_subscription_promotion %}
        {% if(promotion.scope_value_id) %}
          {% set id = promotion.scope_value_id %}
        {% else %}
          {% set id = 'all' %}
        {% endif %}
          <span class="js-total-promotions-detail-row row" id="{{ id }}">
            <span class="col">
              {% if promotion.discount_script_type != "custom" %}
                {% if promotion.discount_script_type == "NAtX%off" %}
                  {{ promotion.selected_threshold.discount_decimal_percentage * 100 }}% OFF
                {% elseif promotion.isBuyXPayY %}
                  {{ promotion.buy }}x{{ promotion.pay }}
                {% elseif promotion.isCrossSelling %}
                  {{ "Descuento" | translate }}
                {% else %}
                  {{ promotion.discount_script_type }}
                {% endif %}

                {{ "en" | translate }} {% if id == 'all' %}{{ "todos los productos" | translate }}{% else %}{{ promotion.scope_value_name }}{% endif %}

                {% if promotion.discount_script_type == "NAtX%off" %}
                  <span>{{ "Comprando {1} o más" | translate(promotion.selected_threshold.quantity) }}</span>
                {% endif %}
              {% else %}
                {{ promotion.scope_value_name }}
              {% endif %}
              :
            </span>
            <span class="col text-right">-{{ promotion.total_discount_amount_short }}</span>
          </span>
      {% endif %}
    {% endfor %}
  </div>
{% endif %}

{% if cart_page %}
  <div class="container p-0">
    <div class="row">
{% endif %}
    {% if cart_page %}
      <div class="col-12 col-md-4">
    {% endif %}
    {{ component('nubesdk-slot', { type: "after_cart_summary" }) }}
    {% if show_cart_fulfillment %}
      
      <div class="js-fulfillment-info js-allows-non-shippable" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>
      
        {% if not cart_page %}
          <div class="js-visible-on-cart-filled divider" {% if cart.items_count == 0 %}style="display:none;"{% endif %}></div>
        {% endif %}
          <div class="js-visible-on-cart-filled js-has-new-shipping js-shipping-calculator-container">

            {# Saved shipping not available #}

            <div class="js-shipping-method-unavailable alert alert-warning row m-1" style="display: none;">
             <div class="col-11 text-left"><strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible para este carrito. ' | translate }}</strong></br>
              {{ '¡No te preocupes! Podés elegir otro.' | translate}}</div>
            </div>

            {# Shipping calculator and branch link #}

            <div id="cart-shipping-container" class="row" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

              {# Used to save shipping #}

              <span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hidden">{{ cart.shipping_data.name }}</span>

              {# Shipping Calculator #}

              {% if store.has_shipping %}
                {% include "snipplets/shipping/shipping-calculator.tpl" with { 'product_detail': false} %}
              {% endif %}

              {# Store branches #}

              {% if store.branches %}
                {% include "snipplets/shipping/branches.tpl" with {'product_detail': false} %}
              {% endif %}
            </div>
          </div>
        {% if not cart_page %}
          <div class="js-visible-on-cart-filled divider {% if not store.branches %} mt-0{% endif %}" {% if cart.items_count == 0 %}style="display:none;"{% endif %}></div>
        {% endif %}
      </div>
    {% endif %}
    {% if cart_page %}
      </div>
    {% endif %}

    {% if cart_page %}

      <div class="col-12 col-md-8" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>
        <div id="cart-sticky-summary" class="position-sticky-md row justify-content-end mt-3 mt-md-0">
          <div class="col-12 col-md-6">
            <div class="box box-border float-right">

              {# Cart page subtotal #}

              <div class="js-visible-on-cart-filled h5 row font-weight-normal mb-0" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-subtotal">
                <span class="col-7">
                  {{ "Subtotal" | translate }}:
                </span>
                <span class="js-ajax-cart-total js-cart-subtotal col text-right" data-priceraw="{{ cart.subtotal }}">{{ cart.subtotal | money }}</span>
              </div>

              {{ component('price-without-taxes', {
                location: 'cart',
                container_classes: price_without_taxes_container_classes,
                text_classes: {
                  label: price_without_taxes_label_classes,
                  price: price_without_taxes_price_classes,
                },
              })
            }}

              {# Cart page promos #}

              <div class="js-total-promotions mt-2">
                <span class="js-promo-discount" style="display:none;">{{ "Descuento" | translate }}</span>
                <span class="js-promo-in" style="display:none;">{{ "en" | translate }}</span>
                <span class="js-promo-all" style="display:none;">{{ "todos los productos" | translate }}</span>
                <span class="js-promo-buying" style="display:none;"> {{ "comprando" | translate }}</span>
                <span class="js-promo-units-or-more" style="display:none;"> {{ "o más" | translate }}</span>
                {% for promotion in cart.promotional_discount.promotions_applied %}
                  {% if not promotion.is_subscription_promotion %}
                    {% if(promotion.scope_value_id) %}
                      {% set id = promotion.scope_value_id %}
                    {% else %}
                      {% set id = 'all' %}
                    {% endif %}
                      <span class="js-total-promotions-detail-row row" id="{{ id }}">
                        <span class="col">
                          {% if promotion.discount_script_type != "custom" %}
                            {% if promotion.discount_script_type == "NAtX%off" %}
                              {{ promotion.selected_threshold.discount_decimal_percentage * 100 }}% OFF
                            {% elseif promotion.isBuyXPayY %}
                              {{ promotion.buy }}x{{ promotion.pay }}
                            {% elseif promotion.isCrossSelling %}
                              {{ "Descuento" | translate }}
                            {% else %}
                              {{ promotion.discount_script_type }}
                            {% endif %}

                            {{ "en" | translate }} {% if id == 'all' %}{{ "todos los productos" | translate }}{% else %}{{ promotion.scope_value_name }}{% endif %}

                            {% if promotion.discount_script_type == "NAtX%off" %}
                              <span>{{ "Comprando {1} o más" | translate(promotion.selected_threshold.quantity) }}</span>
                            {% endif %}
                          {% else %}
                            {{ promotion.scope_value_name }}
                          {% endif %}
                          :
                        </span>
                        <span class="col text-right">-{{ promotion.total_discount_amount_short }}</span>
                      </span>
                  {% endif %}
                {% endfor %}
              </div>

              {# Cart page shipping costs #}

              {% if show_calculator_on_cart %}
                <div id="shipping-cost-container" class="js-fulfillment-info js-visible-on-cart-filled js-shipping-cost-table h5 font-weight-normal row mt-2 mb-0" {% if cart.items_count == 0 or (not cart.has_shippable_products) %}style="display:none;"{% endif %}>
                  <span class="col-auto">{{ 'Envío:' | translate }}</span>
                  <span id="shipping-cost" class="col text-right opacity-40">
                    {{ "Calculalo para verlo" | translate }}
                  </span>
                  <span class="js-calculating-shipping-cost col text-right opacity-40" style="display: none">
                    {{ "Calculando" | translate }}...
                  </span>
                  <span class="js-shipping-cost-empty col text-right opacity-40" style="display: none">
                    {{ "Calculalo para verlo" | translate }}
                  </span>
                </div>
              {% endif %}
              <div class="divider"></div>
    {% endif %}

              {# Cart page and popup total #}

              <div class="js-cart-total-container js-visible-on-cart-filled mb-3" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-total">
                <div class="h2 row text-primary mb-0">
                  <span class="col">{{ "Total" | translate }}:</span>
                  <span class="js-cart-total {% if cart.free_shipping.cart_has_free_shipping %}js-free-shipping-achieved{% endif %} {% if cart.shipping_data.selected %}js-cart-saved-shipping{% endif %} col text-right" data-component="cart.total" data-component-value='{{ cart.total }}'>{{ cart.total | money }}</span>
                </div>

                {# IMPORTANT Do not remove this hidden total, it is used by JS to calculate cart total #}
                <div class='total-price hidden'>
                  {{ "Total" | translate }}: {{ cart.total | money }}
                </div>
                
                <div class="text-right">
                  {{ component('payment-discount-price', {
                      visibility_condition: settings.payment_discount_price,
                      location: 'cart',
                      container_classes: 'text-accent font-weight-bold mt-1',
                    }) 
                  }}
                  {% if not settings.payment_discount_price %}
                    {{ component('installments', {'location': 'cart', container_classes: { installment: 'text-accent font-small font-weight-bold mt-1'}}) }}
                  {% endif %}
                </div>
              </div>

              {{ component('nubesdk-slot', { type: "before_go_to_checkout" }) }}

              <div class="js-visible-on-cart-filled container-fluid" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

                {# No stock alert #}

                <div id="error-ajax-stock" class='alert alert-warning mt-1' role='alert' style="display:none;">
                   {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link ml-1">{{ "ver otros acá" | translate }}</a>
                </div>
                <div>

                  {# Cart page and popup CTA Module #}

                  {% set has_validation_messages = cart.checkout_enabled_validation_messages | length > 0 %}
                  {% set should_show_checkout_button = cart.checkout_enabled and not has_validation_messages %}
                  {% if cart_page %}

                    {# Cart page CTA and minimum alert: Always render button to ensure it exists in DOM, control visibility via CSS/JS #}

                    <div class="row mb-3">
                      <input id="go-to-checkout" class="btn btn-primary btn-block" {{ not should_show_checkout_button ? 'style="display:none"' }} type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}"/>
                    </div>

                    <div class="row">
                      {# Cart alert messages #}
                      {{ component(
                        'checkout-enabled-validation-messages', {
                          alert_classes: 'alert alert-warning mb-2',
                          cart_minimum_value: settings.cart_minimum_value
                        })
                      }}
                    </div>
                  {% else %}

                    {# Cart popup CTA and minimum alert #}

                    <div class="js-ajax-cart-submit row mb-3" {{ not should_show_checkout_button ? 'style="display:none"' }} id="ajax-cart-submit-div" >
                      <input class="btn btn-primary btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" data-component="cart.checkout-button"/>
                    </div>
                    <div class="row">
                      {# Cart alert messages #}
                      {{ component(
                          'checkout-enabled-validation-messages', {
                            alert_classes: 'alert alert-warning mb-2',
                            cart_minimum_value: settings.cart_minimum_value
                          })
                      }}
                    </div>
                  {% endif %}

                  {# Cart panel continue buying link #}

                  {% if settings.continue_buying %}
                    <div class="row mb-2">
                      <div class="text-center w-100">
                        <a href="{% if cart_page %}{{ store.products_url }}{% else %}#{% endif %}" class="{% if not cart_page %}js-modal-close js-fullscreen-modal-close{% endif %} btn-link">{{ 'Ver más productos' | translate }}</a>
                      </div>
                    </div>
                  {% endif %}
                </div>
              </div>
              {{ component('nubesdk-slot', { type: "after_go_to_checkout" }) }}
{% if cart_page %}
          </div>
        </div>
      </div>
    </div>
  </div>
{% endif %}
