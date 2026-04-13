{% if template == 'home' %}

    {# Preload home LCP image of first section #}

    {% set has_main_slider = settings.slider and settings.slider is not empty %}
    {% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
    {% set has_auto_height_slider = not settings.slider_viewport_height %}
    {% set use_smaller_thumbs = (has_auto_height_slider and not has_mobile_slider) or has_mobile_slider %}

    {% if has_mobile_slider %}
        {% set slider = settings.slider_mobile %}
    {% else %}
        {% set slider = settings.slider %}
    {% endif %}

    {% if settings.home_order_position_0 == 'slider' and (has_main_slider or has_mobile_slider) %}
        {% for slide in slider %}
            {% set slide_image = slide.image | static_url %}
            {% if loop.first %}
                <link rel="preload" fetchpriority="high" as="image" href="{{ slide_image | settings_image_url('large') }}" imagesrcset="{% if use_smaller_thumbs %}{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {% endif %}{{ slide_image | settings_image_url('original') }} 1024w, {{ slide_image | settings_image_url('1080p') }} 1920w">
            {% endif %}
        {% endfor %}
    {% endif %}

    {% if settings.home_order_position_0 == 'categories' %}

        {% set priority_assigned = false %}
        
        {% for banner in ['banner_01', 'banner_02', 'banner_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_image_src = "#{banner}.jpg" | static_url %}
            {% if banner_show and banner_image and not priority_assigned %}
                {% set priority_assigned = true %}
                <link rel="preload" fetchpriority="high" as="image" href="{{ banner_image_src | settings_image_url('large') }}" imagesrcset="{{ banner_image_src | settings_image_url('large') }} 480w, {{ banner_image_src | settings_image_url('huge') }} 640w">
            {% endif %}
        {% endfor %}
    {% endif %}

    {% if settings.home_order_position_0 == 'promotional' %}

        {% set priority_assigned = false %}
        
        {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_image_src = "#{banner}.jpg" | static_url %}
            {% if banner_show and banner_image and not priority_assigned %}
                {% set priority_assigned = true %}
                <link rel="preload" as="image" href="{{ banner_image_src | settings_image_url('large') }}" imagesrcset="{{ banner_image_src | settings_image_url('large') }} 480w, {{ banner_image_src | settings_image_url('huge') }} 640w">
            {% endif %}
        {% endfor %}
    {% endif %}

    {% set has_module_banner = settings.module and settings.module is not empty %}

    {% if settings.home_order_position_0 == 'modules' and has_module_banner %}
        {% for slide in settings.module %}
            {% if loop.first %}
                <link rel="preload" fetchpriority="high" as="image" href="{{ slide.image | static_url | settings_image_url('large') }}" imagesrcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w">
            {% endif %}
        {% endfor %}
    {% endif %}

{% elseif template == 'product' %}

    {# Preload product LCP image #}

    {% for image in product.images %}
        {% if loop.first %}
            <link rel="preload" fetchpriority="high" as="image" href="{{ image | product_image_url('large') }}" imagesrcset="{{ image | product_image_url('large') }} 480w, {{ image | product_image_url('huge') }} 640w, {{ image | product_image_url('original') }} 1024w">
        {% endif %}
    {% endfor %}

{% elseif template == 'category' %}

    {# Preload category LCP image #}

    {% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
    
    {% if category_banner %}

        {% set image_sizes = ['large', 'huge', 'original', '1080p'] %}
        {% set category_images = [] %}
        {% set has_category_images = category.images is not empty %}

        {% for size in image_sizes %}
            {% if has_category_images %}
                {# Define images for admin categories #}
                {% set category_images = category_images|merge({(size):(category.images | first | category_image_url(size))}) %}
            {% else %}
                {# Define images for general banner #}
                {% set category_images = category_images|merge({(size):('banner-products.jpg' | static_url | settings_image_url(size))}) %}
            {% endif %}
        {% endfor %}

        <link rel="preload" fetchpriority="high" as="image" href="{{ category_images['large'] }}" imagesrcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w">

    {% endif %}

{% endif %}
