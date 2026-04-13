{% set search_page_filters = template == 'search' and search_filter %}
{% set category_page = template == 'category' %}
{% if (search_page_filters or category_page)  %}
    <section class="js-category-controls category-controls container visible-when-content-ready">
        <div class="row align-items-center {% if products %}mb-md-5{% endif %}">
            <div class="{% if products %}col-9{% else %}col-12{% endif %} d-none d-md-block">
                <div class="row">
                    {% if category_page %}
                    <div class="col-auto align-self-center">
                        {% include "snipplets/breadcrumbs.tpl" %}
                    </div>
                    {% endif %}
                    <div class="visible-when-content-ready col text-right">
                        {% include "snipplets/grid/filters.tpl" with {applied_filters: true} %}
                    </div>
                </div>
            </div>

            <div class="visible-when-content-ready col-6 col-md-3 d-md-none">
                {% if has_filters_available %}
                <a href="#" class="js-modal-open js-fullscreen-modal-open btn-default" data-toggle="#nav-filters" data-modal-url="modal-fullscreen-filters" data-component="filter-button">
                    <div class="row align-items-center">
                        <div class="col font-weight-bold">
                            {{ 'Filtrar' | t }}
                        </div>
                        <div class="col text-right">
                            <svg class="icon-inline"><use xlink:href="#filter"/></svg>
                        </div>
                    </div>
                </a>
                {% embed "snipplets/modal.tpl" with{modal_id: 'nav-filters', modal_class: 'filters', modal_position: 'right', modal_transition: 'slide', modal_header: true, modal_width: 'full', modal_mobile_full_screen: 'true' } %}
                    {% block modal_head %}
                        {{'Filtros ' | translate }}
                    {% endblock %}
                    {% block modal_body %}
                        {% include "snipplets/grid/categories.tpl" with {mobile: true} %}
                        {% include "snipplets/grid/filters.tpl" with {mobile: true} %}
                        <div class="js-filters-overlay filters-overlay" style="display: none;">
                            <div class="filters-updating-message">
                                <h3 class="js-applying-filter" style="display: none;">{{ 'Aplicando filtro...' | translate }}</h3>
                                <h3 class="js-removing-filter" style="display: none;">{{ 'Borrando filtro...' | translate }}</h3>
                            </div>
                        </div>
                    {% endblock %}
                {% endembed %}
                {% endif %}
            </div>
            {% if products %}
            <div class="{% if has_filters_available %}col-6{% else %}col-8 offset-2 offset-md-0{% endif %} col-md-3">
                
                {{ component(
                    'sort-by',{
                        label: false,
                        sort_by_classes: {
                            select_group: "mb-0",
                            select_label: "h2 font-extra-large mb-3 d-block",
                            select: "font-weight-bold",
                            select_svg: "icon-inline icon-w-14 icon-lg",
                        },
                        select_svg_id: 'sort-alt'
                    }) 
                }}
                
            </div>
            {% endif %}
        </div>
</section>
<div class="container visible-when-content-ready d-md-none">
    {% include "snipplets/grid/filters.tpl" with {mobile: true, applied_filters: true} %}
</div>
{% endif %}
