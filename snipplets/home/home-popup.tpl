{% embed "snipplets/modal.tpl" with{modal_id: 'home-modal', modal_position: 'bottom', modal_transition: 'slide', modal_header: false, modal_footer: false, modal_width: 'centered-md h-auto', modal_class: 'centered-small bg-primary', modal_close_class: 'invert'  } %}

    {% block modal_body %}
        {% if "home_popup_image.jpg" | has_custom_image %}
            {% if settings.home_popup_url %}
            <a href="{{ settings.home_popup_url | setting_url }}">
            {% endif %}
                {% set home_popup_image = "home_popup_image.jpg" | static_url %}
                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ home_popup_image | settings_image_url('huge') }} 640w, {{ home_popup_image | settings_image_url('original') }} 1024w' class="lazyload fade-in modal-img-full"/>
            {% if settings.home_popup_url %}
            </a>
            {% endif %}
        {% endif %}

        {% if settings.home_popup_txt or settings.home_news_box %}
        <div class="row align-items-center {% if not 'home_popup_image.jpg' | has_custom_image %}mt-3{% endif %}">
            {% if settings.home_popup_txt %}
                <div class="col-12">
                    {% if settings.home_popup_url %}
                    <a href="{{ settings.home_popup_url | setting_url }}">
                    {% endif %}
                    <h3 class="text-center mt-3 {% if not settings.home_news_box %}mb-0{% endif %}">{{ settings.home_popup_txt }}</h3>
                    {% if settings.home_popup_url %}
                    </a>
                    {% endif %}
                </div>
            {% endif %}

            {% if settings.home_news_box %}
                <div class="col-12 newsletter">
                    <div id="news-popup-form-container">
                        <form id="news-popup-form" method="post" action="/winnie-pooh" class="js-news-form" data-store="newsletter-form-popup">
                            <div class="input-append">
                              
                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_placeholder: 'Email', input_custom_class: "js-mandatory-field form-control-big", input_aria_label: 'Email' | translate } %}
                                {% endembed %}

                            <div class="winnie-pooh" style="display: none;">
                                <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                                <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                            </div>
                            <input type="hidden" name="name" value="{{ "Sin nombre" | translate }}" />
                            <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                            <input type="hidden" name="type" value="newsletter" />
                            <input type="submit" name="contact" class="js-news-popup-submit btn newsletter-btn" value="{{ "Enviar" | translate }}" />
                            <span class="js-news-send">
                                <svg class="icon-inline newsletter-btn svg-icon-primary"><use xlink:href="#arrow"/></svg>
                            </span>
                            <span class="js-news-spinner" style="display: none;">
                                <svg class="icon-inline newsletter-btn svg-icon-primary icon-spin"><use xlink:href="#circle-notch"/></svg>
                            </span>
                            </div>
                            <div style='display: none;' class="js-news-spinner h6 text-center m-top"></div>
                            <div style='display: none;' class="js-news-popup-success alert alert-success">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                            <div style='display: none;'class="js-news-popup-failed alert alert-danger">{{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}</div>
                        </form>
                    </div>
                </div>
            {% endif %}
        </div>
        {% endif %}

    {% endblock %}
{% endembed %}