{% set has_module = has_module | default(false) %}

{% if has_module %}
    {% set section_name = 'module' %}
    {% set section_format = settings.module_slider ? 'slider' : 'grid' %}
    {% set section_image_size = settings.module_same_size ? 'same' : 'original' %}
{% endif %}

{% if has_module %}
    <div class="js-home-{{ section_name }} section-banners-home" data-format="{{ section_format }}" data-image="{{ section_image_size }}">
        {% if has_module %}
            {% include 'snipplets/home/home-modules-grid.tpl' with {'module': true} %}
        {% endif %}
    </div>
{% endif %}
