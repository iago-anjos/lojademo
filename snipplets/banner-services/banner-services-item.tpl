<div class="js-informative-banner-container service-item-container col-md h-auto swiper-slide p-0 px-md-3" {% if not banner_show %}style="display: none"{% endif %}>
    <div class="service-item mx-4 mx-md-0">
        {% if banner_services_url %}
            <a href="{{ banner_services_url | setting_url }}">
        {% endif %}
        <div class="row align-items-center">
            <div class="js-informative-banner-icon-{{ banner_index }} col-auto">
                {% if banner_services_icon == 'image' and banner_services_image %}
                    <img class="js-informative-banner-img js-informative-banner-img-{{ banner_index }} service-item-image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src='{{ "#{banner}.jpg" | static_url | settings_image_url("small") }}' {% if banner_services_title %}alt="{{ banner_services_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                {% elseif banner_services_icon == 'shipping' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#shipping-circle"/></svg>
                {% elseif banner_services_icon == 'card' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#credit-card-circle"/></svg>
                {% elseif banner_services_icon == 'security' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#security-circle"/></svg>
                {% elseif banner_services_icon == 'returns' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#returns-circle"/></svg>
                {% elseif banner_services_icon == 'whatsapp' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#whatsapp-circle"/></svg>
                {% elseif banner_services_icon == 'promotions' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#promotions-circle"/></svg>
                {% elseif banner_services_icon == 'hand' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#clean-hands-circle"/></svg>
                {% elseif banner_services_icon == 'home' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#stay-home-circle"/></svg>
                {% elseif banner_services_icon == 'office' %}
                    <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#home-office-circle"/></svg>
                {% elseif banner_services_icon == 'cash' %}
                    {% if store.country == 'BR' %}
                        <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#barcode-circle"/></svg>
                    {% else %}
                        <svg class="js-informative-banner-icon-svg icon-inline icon-5x svg-icon-text"><use xlink:href="#cash-circle"/></svg>
                    {% endif %}
                {% endif %}
            </div>
            <div class="col p-0">
                <h3 class="js-informative-banner-title js-informative-banner-title-{{ banner_index }} h5 m-0">{{ banner_services_title }}</h3>
                <p class="js-informative-banner-description-{{ banner_index }} m-0">{{ banner_services_description }}</p>
            </div>
        </div>
        {% if banner_services_url %}
            </a>
        {% endif %}
    </div>
</div>
