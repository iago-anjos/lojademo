{# Related products visibility conditions #}

{% set related_products = [] %}
{% set related_products_ids_from_app = product.metafields.related_products.related_products_ids %}
{% set has_related_products_from_app = related_products_ids_from_app | get_products | length > 0 %}
{% if has_related_products_from_app %}
    {% set related_products = related_products_ids_from_app | get_products %}
{% endif %}
{% if related_products is empty %}
    {% set max_related_products_length = 8 %}
    {% set max_related_products_achieved = false %}
    {% set related_products_without_stock = [] %}
    {% set max_related_products_without_achieved = false %}

    {% if related_tag %}
        {% set products_from_category = related_products_from_controller %}
    {% else %}
        {% set products_from_category = category.products | shuffle %}
    {% endif %}

    {% for product_from_category in products_from_category if not max_related_products_achieved and product_from_category.id != product.id %}
        {%  if product_from_category.stock is null or product_from_category.stock > 0 %}
            {% set related_products = related_products | merge([product_from_category]) %}
        {% elseif (related_products_without_stock | length < max_related_products_length) %}
            {% set related_products_without_stock = related_products_without_stock | merge([product_from_category]) %}
        {% endif %}
        {%  if (related_products | length == max_related_products_length) %}
            {% set max_related_products_achieved = true %}
        {% endif %}
    {% endfor %}
    {% if (related_products | length < max_related_products_length) %}
        {% set number_of_related_products_for_refill = max_related_products_length - (related_products | length) %}
        {% set related_products_for_refill = related_products_without_stock | take(number_of_related_products_for_refill) %}

        {% set related_products = related_products | merge(related_products_for_refill)  %}
    {% endif %}

{% endif %}

{% set complementary_products = complementary_product_list | length > 0 %}

{# Show alternative products when there are default category alternatives with no complementaries or manually selected alternatives #}
{% set alternative_products = related_products | length > 0 and not (complementary_products and source_alternative == 'default') %}

{# Set related products classes #}

{% set section_class = 'section-products-related position-relative mb-3' %}
{% set container_class = 'container px-0' %}
{% set title_container_class = 'text-center px-3' %}
{% set title_accent_class = settings.theme_rounded ? 'text-primary' %}
{% set title_class = 'h1' ~ title_accent_class %}
{% set products_container_class = 'products-slider swiper-container-horizontal p-relative' %}
{% set slider_container_class = 'swiper-container p-md-1' %}
{% set swiper_wrapper_class = 'swiper-wrapper' %}
{% set slider_control_class = 'icon-inline icon-2x' %}
{% set slider_controls_container_class = 'd-none d-md-block svg-circle svg-circle-big svg-icon-text' %}
{% set slider_controls_thickness_class = settings.icons_solid ? 'svg-solid' %}
{% set slider_control_prev_class = 'swiper-button-prev ' ~ slider_controls_container_class ~ ' ' ~ slider_controls_thickness_class %}
{% set slider_control_next_class = 'swiper-button-next ' ~ slider_controls_container_class ~ ' ' ~ slider_controls_thickness_class %}
{% set slider_control_pagination_class = 'swiper-pagination m-top' %}
{% set control_next_svg_id = 'chevron' %}
{% set control_prev_svg_id = 'chevron' %}

{# Alternative products #}

{% set alternative_data_component = source_alternative == 'default' ? 'related-products' : 'alternative-products' %}

{% if alternative_products %}
    {{ component(
        'products-section',{
            title: settings.products_related_title,
            id: 'related-products',
            data_component: alternative_data_component,
            products_amount: related_products | length,
            products_array: related_products,
            product_template_path: 'snipplets/grid/item.tpl',
            product_template_params: {'slide_item': true},
            slider_controls_position: 'bottom',
            section_classes: {
                section: 'js-related-products ' ~  section_class,
                container: container_class,
                title_container: title_container_class,
                title: title_class,
                slider_container: 'js-swiper-related ' ~ slider_container_class,
                slider_wrapper: swiper_wrapper_class,
                slider_control: slider_control_class,
                slider_control_prev_container: 'js-swiper-related-prev ' ~ slider_control_prev_class,
                slider_control_prev: 'icon-flip-horizontal',
                slider_control_next_container: 'js-swiper-related-next ' ~ slider_control_next_class,
            },
            control_next_svg_id: control_next_svg_id,
            control_prev_svg_id: control_prev_svg_id,
        })
    }}
{% endif %}

{# Complementary products #}

{% set complementary_section_id = 'complementary-products' %}

{% if complementary_products %}
    {{ component(
        'products-section',{
            title: settings.products_complementary_title,
            id: complementary_section_id,
            data_component: complementary_section_id,
            products_amount: complementary_product_list | length,
            products_array: complementary_product_list,
            product_template_path: 'snipplets/grid/item.tpl',
            product_template_params: {'slide_item': true},
            slider_controls_position: 'bottom',
            section_classes: {
                section: 'js-complementary-products ' ~ section_class,
                container: container_class,
                title_container: title_container_class,
                title: title_class,
                slider_container: 'js-swiper-complementary ' ~ slider_container_class,
                slider_wrapper: swiper_wrapper_class,
                slider_control: slider_control_class,
                slider_control_prev_container: 'js-swiper-complementary-prev ' ~ slider_control_prev_class,
                slider_control_prev: 'icon-flip-horizontal',
                slider_control_next_container: 'js-swiper-complementary-next ' ~ slider_control_next_class,
            },
            control_next_svg_id: control_next_svg_id,
            control_prev_svg_id: control_prev_svg_id,
        })
    }}
{% endif %}
</div>