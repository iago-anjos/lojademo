{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ "Mi cuenta" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h4 class="mb-1 mt-2">{{ 'Datos' | translate }}</h4>
                <div class="divider mt-0"></div>
                <div class="box p-3"> 
                    <h6 class="mb-0">{{ 'Datos Personales' | translate }} {{ 'Editar' | translate | a_tag(store.customer_info_url, '', 'btn-link btn-link-primary font-small float-right') }}</h6>
                    <div class="divider mx-0 mt-1 mb-2"></div>
                    <p class="font-small mb-0">
                        <strong>
                            {{customer.name}}
                        </strong>
                        <span class="d-block">
                            {{customer.email}}
                        </span>
                        {% if customer.cpf_cnpj %}
                            <span class="d-block">
                                <strong>{{ 'DNI / CUIT' | translate }}:</strong> {{ customer.cpf_cnpj | format_id_number(customer.billing_country) }}
                            </span>
                        {% endif %}

                        {% if customer.business_name %}
                            <span class="d-block">
                                <strong>{{ 'Razón social' | translate }}:</strong> {{ customer.business_name }}
                            </span>
                        {% endif %}
                        {% if customer.trade_name %}
                            <span class="d-block">
                                <strong>{{ 'Nombre comercial' | translate }}:</strong> {{ customer.trade_name }}
                            </span>
                        {% endif %}
                        {% if customer.state_registration %}
                            <span class="d-block">
                                <strong>{{ 'Inscripción estatal' | translate }}:</strong> {{ customer.state_registration }}
                            </span>
                        {% endif %}
                        {# Giro business activity used only by CL stores #}
                        {% if customer.business_activity %}
                            <span class="d-block">
                                <strong>{{ 'Giro' | translate }}:</strong> {{ customer.business_activity }}
                            </span>
                        {% endif %}
                        {% if customer.fiscal_regime %}
                            <span class="d-block">
                                <strong>{{ 'Régimen fiscal' | translate }}:</strong> {{ customer.fiscal_regime | format_fiscal_regime }}
                            </span>
                        {% endif %}

                        {% if customer.phone %}
                            <span class="d-block">
                               <strong>{{ 'Teléfono' | translate }}:</strong> {{ customer.phone }}
                            </span>
                        {% endif %}
                    </p>
                </div>
                {% if customer.default_address %}
                    <div class="box p-3">
                        <h6 class="mb-0">{{ 'Mis direcciones' | translate }} {{ 'Editar' | translate | a_tag(store.customer_address_url(customer.default_address), '', 'btn-link btn-link-primary font-small float-right') }}</h6>
                        <div class="divider mx-0 mt-1 mb-2"></div>

                        <p class="mb-0">
                            <span class="d-block font-small my-2">
                                {{ customer.default_address | format_address_short }}
                            </span>
                            {{ 'Otras direcciones' | translate | a_tag(store.customer_addresses_url, '', 'btn-link btn-link-primary font-small') }}
                        </p>
                    </div>
                {% endif %}
            </div>
            <div class="col-md-8">
                <div class="mb-1 mt-2">
                    <span class="h4">
                        {{ 'Mis Compras' | translate }}
                    </span>
                    {% if customer.ordersCount > 50 %}
                        <span class="font-small ml-1">
                            ({{ 'últimas 50 órdenes' | translate }})
                        </span>
                    {% endif %}
                </div>
                <div class="divider mt-0"></div>
                <div class="row" data-store="account-orders">
                    {% if customer.orders %}
                        {% for order in customer.orders %}
                            {% set add_checkout_link = order.pending %}
                            {% set card_active = add_checkout_link ? true : false  %}
                            <div class="col-md-6" data-store="account-order-item-{{ order.id }}">
                                {% embed "snipplets/card.tpl" with{card_footer: true, card_custom_class: 'box card-collapse', card_active: card_active, card_collapse: true} %}
                                    {% block card_head %}
                                        <div class="row">
                                            <div class="col">
                                                <h4 class="m-0">
                                                     <a class="btn-link-primary" href="{{ store.customer_order_url(order) }}"><strong>{{'Orden' | translate}}: #{{order.number}}</strong></a>
                                                </h4>
                                            </div>
                                            <div class="col text-right">
                                                <p class="m-0"><small>{{ order.date | i18n_date('%d/%m/%Y') }}</small></p>
                                            </div>
                                        </div>
                                        <span class="card-collapse-toggle d-none d-md-block">
                                            <a class="btn-link-primary" href="{{ store.customer_order_url(order) }}">  
                                                <svg class="icon-inline icon-w-14 icon-lg"><use xlink:href="#eye"/></svg>
                                            </a>
                                        </span>
                                    {% endblock %}
                                    {% block card_body %}
                                    <div class="container container-fluid p-0">
                                        <div class="row">
                                            <div class="col-7">
                                                <p class="font-small mb-2">
                                                    <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#credit-card"/></svg> {{'Pago' | translate}}: <span class="{{ order.payment_status }}"> <strong>{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}</strong></span>
                                                </p>
                                                <p class="font-small">
                                                    <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#truck"/></svg>
                                                    {{'Envío' | translate}}: <strong> {{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }} </strong>
                                                </p>
                                                <h4 class="m-0 mt-4">
                                                    <strong>{{'Total' | translate}}</strong> {{ order.total | money }}
                                                </h4>
                                                <a class="btn-link-primary font-small" href="{{ store.customer_order_url(order) }}">{{'Ver detalle >' | translate}}</a>
                                            </div>

                                            <div class="col-5">
                                                <div class="card-img-square-container">
                                                    {% for item in order.items %}
                                                        {% if loop.first %} 
                                                            {% if loop.length > 1 %} 
                                                                <span class="card-img-pill">{{ loop.length }} {{'Productos' | translate }}</span>
                                                            {% endif %}
                                                            {{ item.featured_image | product_image_url("") | img_tag(item.featured_image.alt, {class: 'card-img-square'}) }}
                                                        {% endif %}
                                                    {% endfor %}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {% endblock %}
                                    {% block card_foot %}
                                        {% if add_checkout_link %}
                                            <a class="btn btn-primary btn-small d-block" href="{{ order.checkout_url | add_param('ref', 'orders_list') }}" target="_blank">{{'Realizar el pago' | translate}}</a>
                                        {% elseif order.order_status_url != null %}
                                            <a class="btn btn-primary btn-small d-block" href="{{ order.order_status_url | add_param('ref', 'orders_list') }}" target="_blank">{% if 'Correios' in order.shipping_name %}{{'Seguí la entrega' | translate}}{% else %}{{'Seguí tu orden' | translate}}{% endif %}</a>
                                        {% endif %}
                                    {% endblock %}
                                {% endembed %}
                            </div>
                        {% endfor %}
                    {% else %}
                    <div class="col text-center">
                        <svg class="icon-inline mr-1 icon-lg svg-icon-primary"><use xlink:href="#cart"/></svg>
                        <p class="mt-2">{{ '¡Hacé tu primera compra!' | translate }}</p>
                        {{ 'Ir a la tienda' | translate | a_tag(store.url, '', 'btn btn-primary btn-small w-100 mt-2') }}
                    </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
</section>
