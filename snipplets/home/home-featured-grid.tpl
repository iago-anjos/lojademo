{# /*============================================================================
  #Home featured grid
==============================================================================*/

#Properties

#Featured Slider

#}

{% set featured_products = featured_products | default(false) %}
{% set new_products = new_products | default(false) %}
{% set sale_products = sale_products | default(false) %}

{# Check if slider is used #}

{% set has_featured_products_and_slider = featured_products and settings.featured_products_format != 'grid' %}
{% set has_new_products_and_slider = new_products and settings.new_products_format != 'grid' %}
{% set has_sale_products_and_slider = sale_products and settings.sale_products_format != 'grid' %}
{% set use_slider = has_featured_products_and_slider or has_new_products_and_slider or has_sale_products_and_slider %}

{% if featured_products %}
    {% set sections_products = sections.primary.products %}
    {% set section_name = 'primary' %}
    {% set highlighted_products_setting_name = 'featured' %}
    {% set section_title = settings.featured_products_title %}
    {% set section_format = settings.featured_products_format %}
{% endif %}
{% if new_products %}
    {% set sections_products = sections.new.products %}
    {% set section_name = 'new' %}
    {% set highlighted_products_setting_name = 'new' %}
    {% set section_title = settings.new_products_title %}
    {% set section_format = settings.new_products_format %}
{% endif %}
{% if sale_products %}
    {% set sections_products = sections.sale.products %}
    {% set section_name = 'sale' %}
    {% set highlighted_products_setting_name = 'sale' %}
    {% set section_title = settings.sale_products_title %}
    {% set section_format = settings.sale_products_format %}
{% endif %}

<div class="container">
    <div class="row js-products-{{ highlighted_products_setting_name }}-container" data-format="{{ section_format }}" data-desktop-columns="{% if settings.grid_columns == 2 %}4{% else %}3{% endif %}">
        
        <div class="col-12 text-center">
            <h2 class="h1 js-products-{{ highlighted_products_setting_name }}-title {% if settings.theme_rounded %}text-primary{% endif %}" {% if not section_title %}style="display: none"{% endif %}>{{ section_title }}</h2>
        </div>

        {% if use_slider %}
            <div class="col-12 p-0">
                <div class="js-swiper-{{ highlighted_products_setting_name }} swiper-container p-md-1">
                    <div class="swiper-wrapper">
        {% endif %}

        {% for product in sections_products %}
            {% if use_slider %}
                {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name} %}
            {% else %}
                {% include 'snipplets/grid/item.tpl' %}
            {% endif %}
        {% endfor %}

        {% if use_slider %}
                    </div>
                </div>
            </div>
        {% endif %}

        {% if show_help %}
            {% for i in 1..4 %}
                {% if loop.index % 4 == 1 %}
                    <div class="grid-row">
                {% endif %}

                <div class="span3">
                    <div class="item">
                        <div class="item-image-container">
                            <a href="/admin/products/new" target="_top">{{'placeholder-product.png' | static_url | img_tag}}</a>
                        </div>
                        <div class="item-info-container">
                            <div class="title"><a href="/admin/products/new" target="_top">{{"Producto" | translate}}</a></div>
                            <div class="price">{{"$0.00" | translate}}</div>
                        </div>
                    </div>
                </div>

                {% if loop.index % 4 == 0 or loop.last %}
                    </div>
                {% endif %}
            {% endfor %}
        {% endif %}

        {% if use_slider %}
            <div class="js-swiper-{{ highlighted_products_setting_name }}-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
                <svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-swiper-{{ highlighted_products_setting_name }}-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
                <svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
            </div>
        {% endif %}
    </div>
</div>