{{ component('nubesdk-slot', { type: "before_line_item", pick: item.id }) }}
<div class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} {% if cart_page %}row align-items-md-center{% else %}cart-item form-row{% endif %}" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item">

  {% set compare_at_price = item.compare_at_price %}
  {% set hide_compare_price_subtotal = not item.compare_at_price_subtotal or item.is_subscription_item %}

  {# Cart item image #}
  <div class="{% if cart_page %}col-3 col-md-1{% else %}col-2{% endif %}">
    <a href="{{ item.url }}">
      <img src="{{ item.featured_image | product_image_url('medium') }}" class="img-fluid{% if settings.theme_rounded %} box-rounded-small{% endif %}" />
    </a>
  </div>
  <div class="{% if cart_page %}col-9 col-md-10 pl-0 pl-md-3{% else %}col-10 d-flex align-items-center{% endif %}">
    <div class="{% if cart_page %}row align-items-md-center{% else %}w-100{% endif %}">
      {# Cart item name #}
      <h6 class="{% if cart_page %}col-10 col-md-5 h4-md font-weight-normal mb-3 mb-md-0{% else %}cart-item-name{% endif %}" data-component="line-item.name">
        <a href="{{ item.url }}" data-component="name.short-name">
          {{ item.short_name }}
        </a>
        <small data-component="name.short-variant-name">{{ item.short_variant_name }}</small>
        {{ component(
          'cart-labels', {
            group: true,
            subscription_label: true,
            labels_classes: {
              group: 'mt-2',
              label: 'd-inline-block label label-accent label-small font-smallest mb-1',
              subscription: 'font-smallest opacity-80 mt-1 mb-2',
            },
          })
        }}
      </h6>

      {% if cart_page %}
        {% set cart_quantity_class = 'float-md-none m-auto ' %}
      {% else %}
        {% set cart_quantity_class = 'float-left ' %}
      {% endif %}

      {# Cart item quantity controls #}
      <div class="cart-item-quantity {% if cart_page %}col-auto col-md-3 text-center{% endif %}" data-component="line-item.subtotal">
        {% embed "snipplets/forms/form-input.tpl" with{
          type_number: true, 
          input_value: item.quantity, 
          input_name: 'quantity[' ~ item.id ~ ']', 
          input_data_attr: 'item-id',
          input_data_val: item.id,
          input_group_custom_class: cart_quantity_class ~ 'form-quantity cart-item-quantity small mb-0', 
          input_custom_class: 'js-cart-quantity-input text-center h6', 
          input_label: false, input_append_content: true, 
          data_component: 'quantity.value',
          form_control_container_custom_class: 'col'} %}
            {% block input_prepend_content %}
            <div class="row m-0 align-items-center ">
              <span class="js-cart-quantity-btn form-quantity-icon btn" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.minus">
                <svg class="icon-inline icon-w-12 svg-icon-primary"><use xlink:href="#minus"/></svg>
              </span>
            {% endblock input_prepend_content %}
            {% block input_append_content %}
              
              {# Always place this spinner before the quantity input #}
        
              <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                <svg class="icon-inline icon-spin svg-icon-primary"><use xlink:href="#circle-notch"/></svg>
              </span>

              <span class="js-cart-quantity-btn form-quantity-icon btn" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.plus">
                <svg class="icon-inline icon-w-12 svg-icon-primary"><use xlink:href="#plus"/></svg>
              </span>
            </div>
            {% endblock input_append_content %}
        {% endembed %}
      </div>

      {% if cart_page %}
        {# Cart item unit price #}
        <div class="cart-item-subtotal-short col-2 mb-0 {% if not compare_at_price %}mt-2{% endif %} text-center font-weight-normal d-none d-md-block">
          <div class="js-cart-item-unit-price-compare-price-container" data-line-item-id="{{ item.id }}"{% if not compare_at_price %} style="display: none"{% endif %}>
            <span class="text-accent font-small font-weight-bold mr-1">-{{ item.product.promotional_price_percentage | round }}%</span>
            <span class="js-cart-item-unit-price-compare-price price-compare font-small opacity-50 mr-0" data-line-item-id="{{ item.id }}" data-component="compare_price.value" data-component-value='{{ compare_at_price | money }}'>{{ compare_at_price | money }}</span>
          </div>
          <div class="js-cart-item-unit-price h4 font-weight-normal {% if compare_at_price %}mt-1{% endif %}" data-line-item-id="{{ item.id }}">{{ item.unit_price | money }}</div>
        </div>
      {% endif %}

      {# Cart item subtotal #}

      <div class="{% if cart_page %}col col-md-2 text-right text-md-center mb-0{% else %}cart-item-subtotal{% endif %} {% if cart_page and hide_compare_price_subtotal %}mt-2{% elseif not hide_compare_price_subtotal %}m-0{% endif %}">
        <div class="js-cart-item-subtotal-compare-price-container" data-line-item-id="{{ item.id }}"{% if hide_compare_price_subtotal %} style="display: none"{% endif %}>
          <span class="text-accent font-small font-weight-bold mr-1">-{{ item.product.promotional_price_percentage | round }}%</span>
          <span class="js-cart-item-subtotal-compare-price price-compare font-small opacity-50 mr-0" data-line-item-id="{{ item.id }}" data-component="subtotal_compare_price.value" data-component-value='{{ item.compare_at_price_subtotal | money }}'>{{ item.compare_at_price_subtotal | money }}</span>
        </div>
        <div class="js-cart-item-subtotal {% if cart_page %}h5 h4-md{% else %}h6{% endif %} {% if not hide_compare_price_subtotal %}mt-1{% endif %}" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value='{{ item.subtotal | money }}'>{{ item.subtotal | money }}</div>
      </div>
    </div>
  </div>

  {# Cart item delete #}
  <div class="cart-item-delete {% if cart_page %}position-relative-md col-auto col-md-1{% else %}col-1{% endif %} text-right" >
    <button type="button" class="btn {% if cart_page %}h6 h5-md mb-0{% endif %}" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
      <svg class="icon-inline svg-icon-text icon-lg"><use xlink:href="#trash-alt"/></svg>
    </button>
  </div>

  {% if cart_page %}
    <div class="col-12"><div class="divider"></div></div>
  {% endif %}
</div>