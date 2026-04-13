{# Informative banners that work as examples #}

<div class="section-informative-banners js-informative-banners-placeholder">
	<div class="container">
		<div class="row">
			<div class="js-informative-banners swiper-container">
				<div class="swiper-wrapper">
					{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_3': true} %}
					{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_4': true} %}
				</div>
				<div class="js-informative-banners-pagination service-pagination swiper-pagination swiper-pagination-black"></div>
			</div>
		</div>
	</div>
</div>

{# Skeleton of "true" section accessed from instatheme.js #}
<div class="js-informative-banners-top" style="display:none">
	{% include 'snipplets/banner-services/banner-services.tpl' %}
</div>