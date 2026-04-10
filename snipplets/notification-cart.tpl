{% set notification_wrapper_classes = related_products ? 'row mb-4 mx-0' : 'js-alert-added-to-cart notification-floating notification-hidden' %}

<div class="{{ notification_wrapper_classes }} {% if add_to_cart_fixed %}notification-fixed{% endif %}" {% if not related_products %}style="display: none;"{% endif %}>
    <div class="{% if related_products %}col-md mb-3 mb-md-0{% else %}notification notification-primary notification-cart position-relative {% if not add_to_cart_mobile %}col-12 float-right{% endif %}{% endif %}">
    	{% if not related_products %}
	        <div class="js-cart-notification-arrow-up notification-arrow-up"></div>
	        <div class="js-cart-notification-close notification-close mt-2 mr-2">
	            <svg class="icon-inline icon-2x icon-w-12 svg-icon-primary notification-icon"><use xlink:href="#times"/></svg>
	        </div>
        {% endif %}
        <div class="js-cart-notification-item row{% if related_products %} align-items-center{% endif %}" data-store="cart-notification-item">
            <div class="col-2 {% if related_products %}p-0{% else %}pr-0{% endif %} notification-img">
                <img src="" class="js-cart-notification-item-img img-fluid" />
                <svg class="icon-inline icon-sm svg-icon-primary"><use xlink:href="#check-circle-filled"/></svg>
            </div>
            <div class="col-10 text-left">
                <div class="mb-1 mr-4">
                    <span class="js-cart-notification-item-name"></span>
                    <span class="js-cart-notification-item-variant-container" style="display: none;">
                        (<span class="js-cart-notification-item-variant"></span>)
                    </span>
                </div>
                <div class="mb-1">
                    <span class="js-cart-notification-item-quantity"></span>
                    <span> x </span>
                    <span class="js-cart-notification-item-price"></span>
                </div>
                {% if not related_products %}
                    <strong>{{ '¡Agregado al carrito!' | translate }}</strong>
                {% endif %}
            </div>
        </div>
        {% if related_products %}
        </div>
        <div class="col-md px-0">
        {% else %}
        <div class="divider my-3"></div>
        {% endif %}
        <div class="row text-primary h5 font-weight-normal {% if related_products %}font-md-normal mb-2 pb-1{% else %}mb-3{% endif %}">
            <span class="col{% if not related_products %}-auto{% endif %} text-left ml-2{% if related_products %} pr-0{% endif %}">
                <strong>{{ "Total" | translate }}</strong> 
                (<span class="js-cart-widget-amount">
                    {{ "{1}" | translate(cart.items_count ) }} 
                </span>
                <span class="js-cart-counts-plural" style="display: none;">
                    {{ 'productos' | translate }}):
                </span>
                <span class="js-cart-counts-singular" style="display: none;">
                    {{ 'producto' | translate }}):
                </span>
            </span>
            <strong class="js-cart-total col{% if related_products %}-auto{% endif %} text-right mr-2">{{ cart.total | money }}</strong>
        </div>
        <a href="#" class="{% if related_products and settings.ajax_cart %}js-modal-close{% endif %} btn btn-primary btn-medium w-100 d-inline-block {% if settings.ajax_cart %}js-modal-open js-cart-notification-close js-fullscreen-modal-open" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% else %}"{% endif %}>
            {{'Ver carrito' | translate }}
        </a>
    </div>
</div>