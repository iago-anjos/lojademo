{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ 'Orden #{1}' | translate(order.number) }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page">
    <div class="container" data-store="account-order-detail-{{ order.id }}">
    	<div class="row">
            <div class="col-md-4">
                <div class="box p-3">
                    {% if log_entry %}
                        <h4>{{ 'Estado actual del envío' | translate }}:</h4>{{ log_entry }}
                    {% endif %}
                    <h4 class="mb-0">{{ 'Detalles' | translate }}</h4>
                    <div class="divider mx-0 mt-1 mb-3"></div>
                    <p class="font-small">
                        <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#calendar"/></svg> {{'Fecha' | translate}}: <strong>{{ order.date | i18n_date('%d/%m/%Y') }}</strong> 
                    </p>
                    <p class="font-small">
                        <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#info-circle"/></svg>
                        {{'Estado' | translate}}: <strong>{{ (order.status == 'open'? 'Abierta' : (order.status == 'closed'? 'Cerrada' : 'Cancelada')) | translate }}</strong>
                    </p>
                    <p class="font-small">
                        <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#credit-card"/></svg> {{'Pago' | translate}}: <strong>{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }} </strong>
                    </p>
                    <p class="font-small">
                        <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#usd-circle"/></svg> {{'Medio de pago' | translate}}: <strong>{{ order.payment_name }}</strong>
                    </p>

                    {% if order.address %}
                        <p class="font-small">
                            <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#truck"/></svg>
                             {{'Envío' | translate}}: <strong>{{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }}</strong>
                        </p>
                        <p class="font-small">
                            <svg class="icon-inline mr-1 icon-w svg-icon-primary"><use xlink:href="#map-marker-alt"/></svg>
                            <strong>{{ 'Dirección de envío' | translate }}:</strong>
                            <span class="d-block">
                                {{ order.address | format_address }}
                            </span>
                        </p>
                    {% endif %}
                </div>
            </div>
            <div class="col-md-8 mt-2">
                <h4 class="d-lg-none d-md-block">{{ 'Productos' | translate }}</h4>
                <div class="d-none d-md-block">
                    <div class="row">
                        <div class="col-6">
                            <p><strong>{{ 'Producto' | translate }}</strong></p>
                        </div>
                        <div class="col-2">
                            <p><strong>{{ 'Precio' | translate }}</strong></p>
                        </div>
                        <div class="col-2">
                            <p><strong>{{ 'Cantidad' | translate }}</strong></p>
                        </div>
                        <div class="col-2">
                            <p><strong>{{ 'Total' | translate }}</strong></p>
                        </div>
                    </div>
                </div>
                <div class="order-detail">
                    {% for item in order.items %}
                        <div class="order-item">
                            <div class="row align-items-center">
                                <div class="col-7 col-md-6">
                                    <div class="row align-items-center">
                                        <div class="col-4 pr-0 pr-md-3">
                                            <div class="card-img-square-container">
                                                {{ item.featured_image | product_image_url("small") | img_tag(item.featured_image.alt, {class: 'd-block card-img-square'}) }} 
                                            </div>
                                        </div>
                                        <div class="col-8">
                                            <p>
                                                <strong>{{ item.name }}</strong> <span class="d-inline-block d-md-none text-center">x{{ item.quantity }}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2 d-none d-md-block">
                                    <p>
                                        {{ item.unit_price | money }}
                                    </p>
                                </div>
                                <div class="col-2 d-none d-md-block text-center">
                                    <p>
                                        {{ item.quantity }}
                                    </p>
                                </div>
                                <div class="col-5 col-md-2">
                                    <p>
                                        {{ item.subtotal | money }}
                                    </p>
                                </div>
                            </div>
                        </div>
                    {% endfor %}
                    {% if order.show_shipping_price %}
                        <p class="mt-3">
                            <strong class="font-small">{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</strong>
                            {% if order.shipping == 0  %}
                                {{ 'Gratis' | translate }}
                            {% else %}
                                {{ order.shipping | money_long }}
                            {% endif %}
                        </p>
                    {% else %}
                        <p class="mt-3">
                            <strong class="font-small">{{ 'Costo de envío ({1})' | translate(order.shipping_name) }}:</strong>
                            {{ 'A convenir' | translate }}
                        </p>
                    {% endif %}
                    {% if order.discount %}
                        <p class="mt-3">
                           <strong class="font-small">{{ 'Descuento ({1})' | translate(order.coupon) }}:</strong>
                            - {{ order.discount | money }}
                        </p>
                    {% endif %}
                    {% if order.shipping or order.discount %}
                        <p class="mt-3">
                            <strong class="font-small">{{ 'Subtotal' | translate }}:</strong>
                            {{ order.subtotal | money }}
                        </p>
                    {% endif %}  
                    <h3 class="text-center font-primary">
                       <strong>{{ 'Total' | translate }}:</strong>
                        <strong>{{ order.total | money }}</strong>
                    </h3>
                    {% if order.pending %}
                        <a class="btn btn-primary btn-small w-100" href="{{ order.checkout_url | add_param('ref', 'orders_details') }}" target="_blank">{{ 'Realizar el pago' | translate }}</a>
                    {% endif %}
                </div>
            </div>
    	</div>
    </div>
</section>