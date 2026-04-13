{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings,"#{banner}_show") %}
    {% set product_informative_banner_image = "#{banner}.jpg" | has_custom_image %}
    {% set product_informative_banner_icon = attribute(settings,"#{banner}_icon") %}
    {% set product_informative_banner_title = attribute(settings,"#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings,"#{banner}_description") %}
    {% set has_product_informative_banner =  product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %}
        <div class="form-row mb-4 {% if loop.first %}mt-4 {% if store.branches %}pt-2{% endif %}{% endif %}">
            {% if product_informative_banner_icon != 'none' %}
                <div class="col-1 col-md-auto form-label">
                    {% if product_informative_banner_icon == 'image' and product_informative_banner_image %}
                        <img class="product-banner-service-image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src='{{ "#{banner}.jpg" | static_url | settings_image_url("thumb") }}' {% if product_informative_banner_title %}alt="{{ product_informative_banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                    {% elseif product_informative_banner_icon == 'security' %}
                        <svg class="icon-inline icon-lg svg-icon-text align-text-bottom"><use xlink:href="#security"/></svg>
                    {% elseif product_informative_banner_icon == 'returns' %}
                        <svg class="icon-inline icon-lg svg-icon-text align-text-bottom"><use xlink:href="#returns"/></svg>
                    {% elseif product_informative_banner_icon == 'delivery' %}
                        <svg class="icon-inline icon-lg icon-w-20 svg-icon-text align-text-bottom"><use xlink:href="#delivery"/></svg>
                    {% elseif product_informative_banner_icon == 'whatsapp' %}
                        <svg class="icon-inline icon-lg svg-icon-text align-text-bottom"><use xlink:href="#whatsapp"/></svg>
                    {% elseif product_informative_banner_icon == 'cash' %}
                        <svg class="icon-inline icon-lg svg-icon-text align-text-bottom"><use xlink:href="#cash"/></svg>
                    {% elseif product_informative_banner_icon == 'credit_card' %}
                        <svg class="icon-inline icon-lg svg-icon-text align-text-bottom"><use xlink:href="#credit-card"/></svg>
                    {% elseif product_informative_banner_icon == 'promotions' %}
                        <svg class="icon-inline icon-lg svg-icon-text align-text-bottom"><use xlink:href="#tag"/></svg>
                    {% endif %}
                </div>
            {% endif %}
            <div class="col form-label">
                {% if product_informative_banner_title %}
                    <div class="mb-1 font-weight-bold">{{ product_informative_banner_title }}</div>
                {% endif %}
                {% if product_informative_banner_description %}
                    <div>{{ product_informative_banner_description }}</div> 
                {% endif %}
            </div>
        </div>
    {% endif %}
{% endfor %}