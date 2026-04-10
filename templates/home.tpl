{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_banners = settings.banner and settings.banner is not empty %}
{% set has_mobile_banners = settings.toggle_banner_mobile and settings.banner_mobile and settings.banner_mobile is not empty %}
{% set has_promotional_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
{% set has_mobile_promotional_banners = settings.toggle_banner_promotional_mobile and settings.banner_promotional_mobile and settings.banner_promotional_mobile is not empty %}
{% set has_news_banners = settings.banner_news and settings.banner_news is not empty %}
{% set has_mobile_news_banners = settings.toggle_banner_news_mobile and settings.banner_news_mobile and settings.banner_news_mobile is not empty %}
{% set has_image_and_text_module = settings.module and settings.module is not empty %}
{% set has_institutional_01 = settings.institutional_01_description or settings.institutional_01_title or settings.institutional_01_button %}
{% set has_institutional_02 = settings.institutional_02_description or settings.institutional_02_title or settings.institutional_02_button %}
{% set has_institutional_03 = settings.institutional_03_description or settings.institutional_03_title or settings.institutional_03_button %}
{% set has_institutional = has_institutional_01 or has_institutional_02 or has_institutional_03 %}
{% set has_main_categories = settings.slider_categories and settings.slider_categories is not empty %}
{% set has_video = settings.video_embed %}
{% set has_brands = settings.brands and settings.brands is not empty %}
{% set has_testimonial_01 = settings.testimonial_01_title or settings.testimonial_01_description or settings.testimonial_01_name or "testimonial_01.jpg" | has_custom_image %}
{% set has_testimonial_02 = settings.testimonial_02_title or settings.testimonial_02_description or settings.testimonial_02_name or "testimonial_02.jpg" | has_custom_image %}
{% set has_testimonial_03 = settings.testimonial_03_title or settings.testimonial_03_description or settings.testimonial_03_name or "testimonial_03.jpg" | has_custom_image %}
{% set has_testimonial_04 = settings.testimonial_04_title or settings.testimonial_04_description or settings.testimonial_04_name or "testimonial_04.jpg" | has_custom_image %}
{% set has_testimonial_05 = settings.testimonial_05_title or settings.testimonial_05_description or settings.testimonial_05_name or "testimonial_05.jpg" | has_custom_image %}
{% set has_testimonials = has_testimonial_01 or has_testimonial_02 or has_testimonial_03 or has_testimonial_04 or has_testimonial_05 %}
{% set has_newsletter = "home_news_image.jpg" | has_custom_image or "home_news_image_mobile.jpg" | has_custom_image %}
{% set has_instafeed = store.instagram and settings.show_instafeed and store.hasInstagramToken() %}
{% set has_informative_banners = settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_04_title or settings.banner_services_01_description or settings.banner_services_02_description or settings.banner_services_03_description or settings.banner_services_04_description %}
{% set has_timer_offers = settings.timer_offers_start_datetime and settings.timer_offers_end_datetime %}


{% set show_help = not (has_main_slider or has_mobile_slider or has_banners or has_mobile_banners or has_promotional_banners or has_mobile_promotional_banners or has_news_banners or has_image_and_text_module or has_mobile_news_banners or has_institutional or has_main_categories or has_video or has_brands or has_testimonials or has_newsletter or has_instafeed or has_timer_offers) and not has_products and not params.preview %}

{% set show_component_help = params.preview %}

{% if show_component_help %}
	{% include "snipplets/svg/empty-placeholders.tpl" %}
{% endif %}

{#  **** Features Order ****  #}
{% set newArray = [] %}

<div class="js-home-sections-container">
	{% for i in 1..18 %}
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
			{% for section_select in ['slider', 'categories', 'promotional', 'news_banners', 'institutional', 'main_categories', 'video', 'timer_offers', 'brands', 'testimonials', 'newsletter', 'instafeed', 'products', 'new', 'sale', 'informatives', 'main_product', 'modules'] %}
				{% if section_select not in newArray %}
					{% include 'snipplets/home/home-section-switch.tpl' %}
				{% endif %}
			{% endfor %}
		</div>
	{% endif %}
</div>

{% if settings.home_promotional_popup and ("home_popup_image.jpg" | has_custom_image or settings.home_popup_title or settings.home_popup_txt or settings.home_news_box or (settings.home_popup_btn and settings.home_popup_url)) %}
	{% include 'snipplets/home/home-popup.tpl' %}
{% endif %}