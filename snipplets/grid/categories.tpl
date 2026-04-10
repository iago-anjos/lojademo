{% if not mobile %}
    <div class="visible-when-content-ready mb-4 pb-1">
        {% if parent_category and parent_category.id!=0 %}
            <a href="{{ parent_category.url }}" title="{{ parent_category.name }}" class="category-back d-block{% if filter_categories %} mb-4{% endif %}">
                <svg class="icon-inline icon-flip-horizontal mr-2 svg-icon-text"><use xlink:href="#chevron"/></svg>{{ parent_category.name }}
            </a>
        {% endif %}
{% endif %}

        {% if filter_categories %}

            {% if mobile %}
                {% set btn_classes = 'btn-small py-1 px-2' %}
            {% else %}
                {% set btn_classes = 'btn-extra-small' %}
            {% endif %}
            
            <div class="{% if mobile %}mb-5{% else %}d-none d-md-block{% endif %}">
                {% if mobile %}
                    <div class="mb-3 mt-4 h5">{{ "Categorías" | translate }}</div>
                {% else %}
                    <h3 class="title-section mb-4">{{ category.id!=0 ? category.name :("Categorías" | translate) }}</h3>
                {% endif %}
                <ul class="list-unstyled"> 
                    {% for category in filter_categories %}
                        <li data-item="{{ loop.index }}" class="mb-3"><a href="{{ category.url }}" title="{{ category.name }}" class="btn-link {% if mobile %}btn-link-primary font-weight-normal{% endif %}">{{ category.name }}</a></li>
                        {% set hidden_items_threshold = filter_categories | length > 8 %}
                        {% if hidden_items_threshold %}
                            {% if loop.index == 8 %}
                                <div class="js-accordion-container" style="display: none;">
                            {% endif %}
                            {% if loop.last %}
                                </div>
                                <a href="#" class="js-accordion-toggle d-inline-block btn btn-secondary {{ btn_classes }} mt-2">
                                    <span class="js-accordion-toggle-inactive">{{ 'Ver más' | translate }}</span>
                                    <span class="js-accordion-toggle-active" style="display: none;">{{ 'Ver menos' | translate }}</span>
                                </a>
                            {% endif %}
                        {% endif %}
                    {% endfor %}
                </ul>
            </div>
        {% endif %}
{% if not mobile %}
    </div>
{% endif %}