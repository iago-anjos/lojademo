<div class="js-promotional-banner-fullwidth container{% if settings.banner_promotional_full %}-fluid{% endif %}">
    <div class="row">
        {% set section_first = settings.home_order_position_0 == 'promotional' %}

        {% set num_banners = 0 %}
        {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_title = attribute(settings,"#{banner}_title") %}
            {% set has_banner =  banner_show and (banner_title or "#{banner}.jpg" | has_custom_image) %}
            {% if has_banner %}
                {% set num_banners = num_banners + 1 %}
            {% endif %}
        {% endfor %}

        {% set priority_assigned = false %}

        {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_image_src = "#{banner}.jpg" | static_url %}
            {% set banner_title = attribute(settings,"#{banner}_title") %}
            {% set banner_button_text = attribute(settings,"#{banner}_button") %}
            {% set banner_url = attribute(settings,"#{banner}_url") %}
            {% set has_banner = banner_show and (banner_title or banner_image) %}
            {% set has_banner_text = banner_title or banner_button_text %}

            {# Assign priority to the first banner (no matter banner order) #}

            {% set has_priority = has_banner and banner_image and not priority_assigned %}
            {% if has_priority %}
                {% set priority_assigned = true %}
            {% endif %}

            {% set apply_lazy_load = 
                not section_first 
                or not has_priority
            %}

            {% if apply_lazy_load %}
                {% set banner_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
            {% else %}
                {% set banner_src = banner_image_src | settings_image_url('large') %}
            {% endif %}
            
            {% if has_banner or params.preview %}
                <div class="js-promotional-banner-container js-promotional-banner-container-{{ loop.index }}  col-md-{% if num_banners == 1 %}6 offset-md-3{% elseif num_banners == 2 %}6{% elseif num_banners == 3 %}4{% endif %}" {% if not has_banner %}style="display:none"{% endif %} data-visible="{{ has_banner ? 'true' : 'false' }}">
                    <div class="textbanner{% if settings.theme_rounded %} box-rounded textbanner-shadow{% endif %}">
                        {% if banner_url %}
                            <a class="textbanner-link" href="{{ banner_url | setting_url }}"{% if banner_title %} title="{{ banner_title }}" aria-label="{{ banner_title }}"{% else %} title="{{ 'Banner de' | translate }} {{ store.name }}" aria-label="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %}>
                        {% endif %}
                            <div class="js-textbanner-image textbanner-image {% if has_banner_text %}overlay{% endif %}">
                                <img 
                                    {% if not apply_lazy_load %}fetchpriority="high"{% endif %}
                                    {% if banner_image %}
                                        {% if apply_lazy_load %}data-{% endif %}src="{{ banner_src }}"
                                        {% if apply_lazy_load %}data-{% endif %}srcset="{{ banner_image_src | settings_image_url('large') }} 480w, {{ banner_image_src | settings_image_url('huge') }} 640w"
                                    {% endif %}
                                    {% if apply_lazy_load %}
                                    data-sizes="auto" 
                                    data-expand="-10"
                                    {% endif %}
                                    class="js-promotional-banner-img-{{ loop.index }} textbanner-image-background {% if apply_lazy_load %}lazyload lazyautosizes fade-in{% endif %}" 
                                    {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} 
                                    {% if not banner_image %}style="display:none"{% endif %}
                                />
                                {% if apply_lazy_load and banner_image %}
                                    <div class="placeholder-fade"></div>
                                {% endif %}
                                <div class="textbanner-text over-image">
                                    <h3 class="h2 mb-0 js-promotional-banner-title js-promotional-banner-title-{{ loop.index }}">{{ banner_title }}</h3>
                                    <div class="btn btn-secondary btn-small invert mt-3 js-promotional-banner-button js-promotional-banner-button-{{ loop.index }}" {% if not (banner_url and banner_button_text) %}style="display:none"{% endif %} data-has-url="{{ banner_url ? 'true' : 'false' }}">{{ banner_button_text }}</div>
                                </div>
                            </div>
                        {% if banner_url %}
                            </a>
                        {% endif %}
                    </div>
                </div>
            {% endif %}
        {% endfor %}
    </div>
</div>
