{% set selected_option = loop.first or cart.shipping_option == option.name %}
<div class="js-shipping-suboption {{suboptions.name}}">
    {% if suboptions.options %}

        {# Read only suboptions inside popup #}

        {% set modal_id_val = (suboptions.name | sanitize) ~ '-pickup-modal-' ~ random() %}

        <div data-toggle="#{{ modal_id_val }}" class="js-modal-open btn-link btn-link-primary">
            <svg class="icon-inline icon-lg mr-1"><use xlink:href="#map-marker-alt"/></svg>
            <span class="align-bottom">{{ 'Ver direcciones' | translate }}</span>
        </div>

        {% embed "snipplets/modal.tpl" with{modal_id: modal_id_val, modal_class: 'bottom modal-centered-small js-modal-shipping-suboptions', modal_position: 'center', modal_transition: 'slide', modal_header: true, modal_footer: false, modal_width: 'centered', modal_zindex_top: true} %}
            {% block modal_head %}
                {{ 'Puntos de retiro' | translate }}
            {% endblock %}
            {% block modal_body %}
                <ul class="list-unstyled py-2">
                    {% for option in suboptions.options %}
                        <li class="text-capitalize mb-3">
                            <svg class="icon-inline svg-icon-primary d-flex float-left mr-2"><use xlink:href="#map-marker-alt"/></svg>
                            <span class="d-flex">{{ option.name | lower }}</span>
                        </li>
                    {% endfor %}
                </ul>
                <div class="mt-4"><span class="opacity-50">{{ 'Cercanos al código postal:' | translate }}</span> <span class="text-primary font-weight-bold">{{cart.shipping_zipcode}}</span></div>
                <div class="mt-2 font-small">
                    <svg class="icon-inline svg-icon-text"><use xlink:href="#info-circle"/></svg>
                    <i>{{ "Vas a poder elegir estas opciones antes de finalizar tu compra" | translate }}</i>
                </div>
            {% endblock %}
        {% endembed %}

    {% else %}
        <input type="hidden" name="{{suboptions.name}}"/>
        <div>{{ suboptions.no_options_message | translate }}</div>
    {% endif %}
</div>