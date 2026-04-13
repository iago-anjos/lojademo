{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_informative_banners = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_04_title) %}
{% set has_category_banners =  settings.banner_01_show or settings.banner_02_show or settings.banner_03_show %}
{% set has_welcome =  settings.welcome_message %}
{% set has_institutional_message = settings.institutional_message or settings.institutional_text %}
{% set has_brands = settings.brands and settings.brands is not empty %}
{% set has_video = settings.video_embed %}
{% set has_instafeed = store.instagram and settings.show_instafeed and store.hasInstagramToken() %}
{% set has_promotional_banners = settings.banner_promotional_01_show or settings.banner_promotional_02_show or settings.banner_promotional_03_show %}
{% set has_image_and_text_module = settings.module and settings.module is not empty %}

{% set show_help = not (has_main_slider or has_mobile_slider or has_informative_banners or has_category_banners or has_brands or has_video or has_instafeed or has_promotional_banners or has_image_and_text_module or has_institutional_message) and not has_products and not params.preview %}

{% set show_component_help = params.preview %}

{% if show_component_help %}
	{% include "snipplets/svg/empty-placeholders.tpl" %}
{% endif %}


{#  **** Features Order ****  #}
{% set newArray = [] %}

<div class="js-home-sections-container">
	{% for i in 0..14 %}
		{% set section = 'home_order_position_' ~ i %}
		{% set section_select = attribute(settings,"#{section}") %}

		{% if section_select not in newArray %}

			{% include 'snipplets/home/home-section-switch.tpl' %}
			{% set newArray = newArray|merge([section_select]) %}

		{% endif %}
	{% endfor %}

	{#  **** Hidden Sections ****  #}
	{% if show_component_help %}
		<div style="display:none">
			{% for section_select in ['slider', 'welcome', 'products', 'informatives', 'categories', 'promotional', 'brands', 'new', 'modules', 'video', 'sale', 'instafeed', 'newsletter', 'institutional'] %}
				{% if section_select not in newArray %}
					{% include 'snipplets/home/home-section-switch.tpl' %}
				{% endif %}
			{% endfor %}
		</div>
	{% endif %}
</div>

{% if settings.home_promotional_popup %}
	{% include 'snipplets/home/home-popup.tpl' %}
{% endif %}