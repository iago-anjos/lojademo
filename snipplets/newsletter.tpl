{% set newsletter_contact_error = contact.type == 'newsletter' and not contact.success %}

<section data-store="home-newsletter">
    {{ component('nubesdk-slot', { type: 'before_section_newsletter' }) }}
    <div class="section-newsletter-home bg-primary js-home-newsletter" {% if not settings.news_show %}style="display: none"{% endif %}>
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 text-center">
                    <div class="js-newsletter newsletter">
                        <h3 class="mb-4 font-body font-weight-normal text-uppercase">{{ 'Newsletter' | translate }}</h3>
                        <h2 class="h1 mb-4 js-home-newstetter-title">{{ settings.news_title }}</h2>
                        <p class="js-home-newstetter-text">{{ settings.news_text }}</p>

                        {% if contact and contact.type == 'newsletter' %}
                            {% if contact.success %}
                                <div class="alert alert-success">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                            {% else %}
                                <div class="alert alert-danger">{{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}</div>
                            {% endif %}
                        {% endif %}

                        <form class="mt-5" method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-form">
                            <div class="input-append">

                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_placeholder: 'Email' | translate, input_custom_class: "form-control-big", input_aria_label: 'Email' | translate } %}
                                {% endembed %}

                            <div class="winnie-pooh" style="display: none;">
                                <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                                <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                            </div>
                            <input type="hidden" name="name" value="{{ "Sin nombre" | translate }}" />
                            <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                            <input type="hidden" name="type" value="newsletter" />
                            <input type="submit" name="contact" class="btn newsletter-btn" value="{{ "Enviar" | translate }}" />
                            <svg class="icon-inline newsletter-btn svg-icon-primary"><use xlink:href="#arrow"/></svg>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {{ component('nubesdk-slot', { type: 'after_section_newsletter' }) }}
</section>
