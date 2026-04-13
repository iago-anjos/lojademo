{% set has_advertising_bar = false %}
{% set num_messages = 0 %}
{% for adbar in ['ad', 'ad_02', 'ad_03'] %}
    {% set advertising_text = attribute(settings,"#{adbar}_text") %}
    {% if advertising_text %}
        {% set has_advertising_bar = true %}
        {% set num_messages = num_messages + 1 %}
    {% endif %}
{% endfor %}
{% set adbar_text_classes = num_messages > 1 ? 'swiper-slide slide-container' : 'adbar-message' %}

<div class="col col-md-6 font-small text-center">
    {% if settings.ad_bar and has_advertising_bar %}
        {% if num_messages > 1 %}
            <div class="js-swiper-adbar swiper-container text-center">
                <div class="swiper-wrapper align-items-center">
        {% endif %}
                {% for adbar in ['ad', 'ad_02', 'ad_03'] %}
                    {% set advertising_text = attribute(settings,"#{adbar}_text") %}
                    {% set advertising_url = attribute(settings,"#{adbar}_url") %}
                    {% if advertising_text %}
                        <span class="{{ adbar_text_classes }}">
                            {% if advertising_url %}
                                <a href="{{ advertising_url }}" class="link-contrast">
                            {% endif %}
                                    {{ advertising_text }}
                            {% if advertising_url %}
                                </a>
                            {% endif %}
                        </span>
                    {% endif %}
                {% endfor %}
        {% if num_messages > 1 %}
                </div>
            </div>
            <div class="js-swiper-adbar-prev swiper-button-small swiper-button-prev svg-icon-text">
                <svg class="icon-inline icon-sm icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-swiper-adbar-next swiper-button-small swiper-button-next svg-icon-text">
                <svg class="icon-inline icon-sm"><use xlink:href="#chevron"/></svg>
            </div>
        {% endif %}
    {% endif %}
</div>