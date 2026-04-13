<div class="{% if store.branches|length > 1 %}js-toggle-branches{% endif %} w-100 {% if not product_detail %}container-fluid{% endif %}" data-store="branches">
    <span class="form-row {% if store.branches|length == 1 %}align-items-end{% endif %}">
        <div class="col-1 col-md-auto form-label">
            <svg class="icon-inline icon-lg icon-w-20 svg-icon-text align-text-bottom"><use xlink:href="#store-alt"/></svg>
        </div>
        <div class="col-11 form-label">
            <div {% if store.branches|length > 1 %}class="mb-1"{% endif %}> 
                {% if store.branches|length > 1 %}
                    {{ 'Nuestros locales' | translate }}
                {% else %}
                    {{ 'Nuestro local' | translate }}
                {% endif %}
            </div>
            {% if store.branches|length > 1 %}
                <div class="btn-link btn-link-primary float-left">
                    <span class="js-see-branches">
                        {{ 'Ver opciones' | translate }}
                        <svg class="icon-inline"><use xlink:href="#chevron-down"/></svg>
                    </span>
                    <span class="js-hide-branches" style="display: none;">
                        {{ 'Ocultar opciones' | translate }}
                        <svg class="icon-inline icon-flip-vertical"><use xlink:href="#chevron-down"/></svg>
                    </span>
                </div>
            {% endif %}
        </div>
    </span>
</div>

{# Store branches #}

<div class="js-store-branches-container {% if not product_detail %}container-fluid{% endif %}" {% if store.branches|length > 1 %}style="display: none;"{% endif %}>
    <div class="box mt-3 p-0">
        {% if not product_detail %}
            <div class="radio-buttons-group">
        {% endif %}
                <ul class="list-unstyled radio-button-container">

                    {% for branch in store.branches %}
                        <li class="{% if product_detail %}list-item list-item-box{% else %}radio-button-item{% endif %}" data-store="branch-item-{{ branch.code }}">

                            {# If cart use radiobutton #}

                            {% if not product_detail %}
                                <label class="js-shipping-radio js-branch-radio radio-button" data-loop="branch-radio-{{loop.index}}">
                            
                                    <input 
                                    class="js-branch-method {% if cart.shipping_data.code == branch.code %} js-selected-shipping-method {% endif %} shipping-method" 
                                    data-price="0" 
                                    {% if cart.shipping_data.code == branch.code %}checked{% endif %} type="radio" 
                                    value="{{branch.code}}" 
                                    data-name="{{ branch.name }} - {{ branch.extra }}"
                                    data-code="{{branch.code}}" 
                                    data-cost="{{ 'Gratis' | translate }}"
                                    name="option" 
                                    style="display:none">
                                    <div class="shipping-option row-fluid radio-button-content">
                                       <div class="radio-button-icons-container">
                                            <span class="radio-button-icons">
                                                <span class="radio-button-icon unchecked"></span>
                                                <span class="radio-button-icon checked">
                                                    <svg class="icon-inline icon-sm svg-icon-primary"><use xlink:href="#check"/></svg>
                                                </span>
                                            </span>
                                        </div>
                            {% endif %}
                                        <div class="{% if product_detail %}list-item-content{% else %}radio-button-label{% endif %}">
                                            <div class="row">
                                                <div class="col-9 font-small">
                                                    <div>{{ branch.name }} - {{ branch.extra }}</div>
                                                </div>
                                                <div class="col-3 text-right">
                                                    <h5 class="text-primary mb-0 d-inline-block">{{ 'Gratis' | translate }}</h5>
                                                </div>
                                            </div>
                                        </div>
                            {% if not product_detail %}
                                    </div>
                                </label>
                            {% endif %}
                        </li>
                    {% endfor %}
                </ul>
        {% if not product_detail %}
            </div>
        {% endif %}
    </div>
</div>
