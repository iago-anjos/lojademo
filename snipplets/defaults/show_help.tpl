{# Only remove this if you want to take away the theme onboarding advices #}

{% if not params.preview %}
	{% if is_theme_draft %}
		{% set admin_link = '/admin/themes/settings/draft/' %}
	{% else %}
		{% set admin_link = '/admin/themes/settings/active/' %}
	{% endif %}
{% endif %}

{% include "snipplets/svg/empty-placeholders.tpl" %}

{# Slider that work as example #}
{% snipplet 'defaults/home/slider_help.tpl' %}

{# Informative banners that work as examples #}
{% snipplet 'defaults/home/informative_banners_help.tpl' %}

{# Categories banners that work as examples #}
{% snipplet 'defaults/home/category_banners_help.tpl' %}

{# Products featured that work as examples #}
{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Destacados' | translate, data_store: 'home-products-featured' }  %}

{# Slider brands that work as examples #}
{% snipplet 'defaults/home/brands_help.tpl' %}

{# Products featured that work as examples #}
{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Novedades' | translate, data_store: 'home-products-new' }  %}

{# Promotional banners that work as examples #}
{% snipplet 'defaults/home/promotional_banners_help.tpl' %}

{# Products featured that work as examples #}
{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Ofertas' | translate, data_store: 'home-products-sale' }  %}

{# Instagram feed that work as examples #}
{% snipplet 'defaults/home/instafeed_help.tpl' %}

{# Video that work as examples #}
{% snipplet 'defaults/home/video_help.tpl' %}
