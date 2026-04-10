{# Cookie validation #}

{% if show_cookie_banner and not params.preview %}
    <div class="js-notification js-notification-cookie-banner notification notification-fixed-bottom notification-above notification-primary col-12 col-lg-6 offset-lg-3 opacity-90" style="display: none;">
        <div class="row no-gutters justify-content-center align-items-center font-smallest font-md-small px-md-3">
            <span class="col col-md-auto text-left mr-2 mr-md-3">{{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}</span>
            <div class="col-auto text-right">
                <a href="#" class="js-notification-close js-acknowledge-cookies btn btn-secondary btn-small p-2 invert" data-amplitude-event-name="cookie_banner_acknowledge_click">{{ "Entendido" | translate }}</a>
            </div>
        </div>
    </div>
{% endif %}

{# Quick login when store is not AR #}

{% if show_quick_login and not customer and store.country != 'AR' and template == 'home' %}
    <div class="js-notification js-notification-quick-login notification notification-fixed-bottom notification-primary col-12 col-lg-4 offset-lg-4 opacity-90" style="display: none;">
        <div class="container">
            <div class="row my-1">
                <div class="col p-0">
                    <div class="mb-3 mr-2">{{ '<strong>¡Comprá más rápido</strong> y seguí tus pedidos!' | translate }}</div>
                    <a data-toggle="#quick-login" class="js-modal-open btn btn-secondary btn-small invert">{{ "Iniciá sesión" | translate }}</a>
                </div>
                <div class="col-auto p-0">
                    <a class="js-notification-close js-dismiss-quicklogin mr-1" href="#">
                        <svg class="icon-inline svg-icon-invert icon-lg"><use xlink:href="#times"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}

{# Success notification for quick login (all countries) #}

{% if show_quick_login and customer and just_logged_in  %}
    <div class="js-notification js-notification-quick-login js-quick-login-success notification notification-fixed-bottom notification-primary col-12 col-lg-4 offset-lg-4 opacity-90">
         <div class="container">
            <div class="row">
                <div class="col">
                    <svg class="icon-inline icon-lg svg-icon-invert mr-2"><use xlink:href="#heart"/></svg>
                    <span>
                        {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
                        {{ "<strong>¡Hola, {1}!</strong> Ya podés seguir con tu compra" | t(customer_short_name) }}
                    </span> 
                </div>
                <div class="col-auto">
                    <a class="js-notification-close mr-1" href="#">
                        <svg class="icon-inline svg-icon-invert icon-lg pull-left"><use xlink:href="#times"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}

{% if order_notification and status_page_url_notification %}
    <div class="js-notification js-notification-status-page notification notification-primary" style="display:none;" data-url="{{ status_page_url_notification }}">
        <div class="container">
            <div class="row">
                <div class="col">
                    <a class="d-block d-sm-inline mr-2" href="{{ status_page_url_notification }}"><strong>{{ "Seguí acá" | translate }}</strong> {{ "tu última compra" | translate }}</a>
                    <a class="js-notification-close js-notification-status-page-close notification-close position-relative-md" href="#">
                        <svg class="icon-inline svg-icon-text icon-lg"><use xlink:href="#times"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}

{% if add_to_cart %}
    {% include "snipplets/notification-cart.tpl" %}
{% endif %}
