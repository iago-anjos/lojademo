{% if applied_filters %}

    {# Applied filters chips #}

    {% if has_applied_filters %}
        {% if mobile %}
            {# Show subtitle only for mobile applied filters #}
            <div class="mt-4 mb-2">{{ 'Filtro aplicado:' | translate }}</div>
        {% endif %}
        {% for product_filter in product_filters %}
            {% for value in product_filter.values %}

                {# List applied filters as tags #}

                {% if value.selected %}
                    <button class="js-remove-filter chip" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.pill-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
                        {{ value.pill_label }}
                        <svg class="icon-inline chip-remove-icon"><use xlink:href="#times"/></svg>
                    </button>
                {% endif %}
            {% endfor %}
        {% endfor %}
        <a href="#" class="js-remove-all-filters btn-link btn-link-primary d-inline-block mt-1" data-component="filter-delete">{{ 'Borrar filtros' | translate }}</a>
    {% endif %}
{% else %}

    {% if product_filters is not empty %}

        <div id="filters" class="visible-when-content-ready" data-store="filters-nav">

            {% if not mobile %}
                <h3 class="title-section mb-2 d-none d-md-block">{{ "Filtrar por" | translate }}</h3>
            {% endif %}

            {# Filters list #}

            {% if mobile %}
                {% set btn_classes = 'btn-small' %}
                {% set btn_price_classes = 'btn-small' %}
            {% else %}
                {% set btn_classes = 'btn-extra-small' %}
                {% set btn_price_classes = 'btn-small-extra btn-circle btn-icon chevron' %}
            {% endif %}

            {% for product_filter in product_filters %}

                {% if product_filter.type == 'price' %}

                    {{ component(
                        'price-filter',
                        {'group_class': 'mb-5', 'title_class': 'h5 h6-md mb-3 mt-4', 'button_class': 'btn btn-secondary ' ~ btn_price_classes }
                    ) }}

                {% else %}
                    {% if product_filter.has_products %}
                        <div class="mb-5" data-store="filters-group" data-component="list.filter-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
                            <div class="mb-3 mt-4 {% if mobile %}h5{% else %}h6{% endif %}">{{product_filter.name}}</div>
                            {% set index = 0 %}
                            {% for value in product_filter.values %}
                                {% set hidden_items_threshold = product_filter.values_with_products > 8 %}
                                {% if value.product_count > 0 %}
                                    {% set index = index + 1 %}

                                    <label class="js-filter-checkbox {% if not value.selected %}js-apply-filter{% else %}js-remove-filter{% endif %} checkbox-container" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.option" data-component-value="{{ value.name }}">
                                        <input type="checkbox" autocomplete='off' {% if value.selected %}checked{% endif %}/>
                                        <span class="checkbox">
                                            <span class="checkbox-icon"></span>
                                            <span class="{% if not mobile %}font-small{% endif %} checkbox-text with-color">
                                                {{ value.name }} ({{ value.product_count }})
                                            </span>
                                            {% if product_filter.type == 'color' and value.color_type == 'insta_color' %}
                                                <span class="checkbox-color" style="background-color: {{ value.color_hexa }};"></span>
                                            {% endif %}
                                        </span>
                                    </label>
                                    {% if index == 8 and hidden_items_threshold %}
                                        <div class="js-accordion-container" style="display: none;">
                                    {% endif %}
                                {% endif %}
                                {% if loop.last and hidden_items_threshold %}
                                    </div>
                                    <a href="#" class="js-accordion-toggle d-inline-block btn btn-secondary {{ btn_classes }} mt-2">
                                        <span class="js-accordion-toggle-inactive">{{ 'Ver todos' | translate }}</span>
                                        <span class="js-accordion-toggle-active" style="display: none;">{{ 'Ver menos' | translate }}</span>
                                    </a>
                                {% endif %}
                            {% endfor %}
                        </div>
                    {% endif %}
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
{% endif %}
