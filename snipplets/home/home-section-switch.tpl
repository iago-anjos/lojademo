{% if section_select == 'slider' %}

    {#  **** Home slider ****  #}
    <section data-store="home-slider">
        {% if show_help or (show_component_help and not (has_main_slider or has_mobile_slider)) %}
            {% snipplet 'defaults/home/slider_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-slider.tpl' %}
            {% if has_mobile_slider %}
                {% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
            {% endif %}
        {% endif %}
    </section>

{% elseif section_select == 'products' %}

    {#  **** Featured products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Destacados' | translate, data_store: 'home-products-featured', highlighted_products_setting_name: 'featured' }  %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_featured': true} %}
    {% endif %}

{% elseif section_select == 'informatives' %}

    {#  **** Informative banners ****  #}
    <section data-store="banner-services">
        {% if show_help or (show_component_help and not has_informative_banners) %}
            {% snipplet 'defaults/home/informative_banners_help.tpl' %}
        {% else %}
            {% include 'snipplets/banner-services/banner-services.tpl' %}
        {% endif %}
    </section>

{% elseif section_select == 'categories' %}

    {#  **** Categories banners ****  #}
    <section class="section-banners-home" data-store="home-banner-categories">
        {% if show_help or (show_component_help and not has_category_banners) %}
            {% snipplet 'defaults/home/category_banners_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-banners.tpl' %}
        {% endif %}
    </section>

{% elseif section_select == 'welcome' %}

    {#  **** Welcome message ****  #}
    {% if show_help or (show_component_help and not has_welcome) %}
        {% include 'snipplets/defaults/home/welcome_help.tpl' with { section: 'welcome', title: 'Escribí sobre tu marca' | translate, data_store: 'home-welcome-message' } %}
    {% else %}
        {% include 'snipplets/home/home-welcome-message.tpl' %}
    {% endif %}

{% elseif section_select == 'institutional' %}

    {#  **** Institutional message ****  #}
    {% if show_help or (show_component_help and not has_institutional_message) %}
        {% include 'snipplets/defaults/home/welcome_help.tpl' with { section: 'institutional', title: 'Mensaje institucional' | translate, data_store: 'home-institutional-message' } %}
    {% else %}
        {% include 'snipplets/home/home-welcome-message.tpl' with {institutional: true} %}
    {% endif %}

{% elseif section_select == 'brands' %}

    {#  **** Brands ****  #}
    {% if show_help or (show_component_help and not has_brands) %}
        {% snipplet 'defaults/home/brands_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-brands.tpl' %}
    {% endif %}

{% elseif section_select == 'new' %}

    {#  **** New products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Novedades'| translate, data_store: 'home-products-new', highlighted_products_setting_name: 'new' }  %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_new': true} %}
    {% endif %}

{% elseif section_select == 'video' %}

    {#  **** Video embed ****  #}
    <section class="section-video-home" data-store="home-video">
        {% if show_help or (show_component_help and not has_video) %}
            {% snipplet 'defaults/home/video_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-video.tpl' %}
        {% endif %}
    </section>

{% elseif section_select == 'sale' %}

    {#  **** Sale products ****  #}
    {% if show_help or (show_component_help and not has_products) %}
        {% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Ofertas' | translate, data_store: 'home-products-sale', highlighted_products_setting_name: 'sale' }  %}
    {% else %}
        {% include 'snipplets/home/home-featured-products.tpl' with {'has_sale': true} %}
    {% endif %}

{% elseif section_select == 'instafeed' %}

    {#  **** Instafeed ****  #}
    {% if show_help or (show_component_help and not has_instafeed) %}
        {% snipplet 'defaults/home/instafeed_help.tpl' %}
    {% else %}
        {% include 'snipplets/home/home-instafeed.tpl' %}
    {% endif %}

{% elseif section_select == 'promotional' %}

    {#  **** Promotional banners ****  #}
    <section class="section-banners-home" data-store="home-banner-promotional">
        {% if show_help or (show_component_help and not has_promotional_banners) %}
            {% snipplet 'defaults/home/promotional_banners_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-promotional.tpl' %}
        {% endif %}
    </section>

{% elseif section_select == 'modules' %}

    {#  **** Modules ****  #}
    <section class="section-banners-home position-relative overflow-none" data-store="home-image-text-module">
        {% if show_help or (show_component_help and not has_image_and_text_module) %}
            {% include 'snipplets/defaults/home/image_text_modules_help.tpl' %}
        {% else %}
            {% include 'snipplets/home/home-modules.tpl' with {'has_module': true} %}
        {% endif %}
    </section>


{% elseif section_select == 'newsletter' %}

    {#  **** Newsletter ****  #}
    {% include 'snipplets/newsletter.tpl' %}

{% endif %}