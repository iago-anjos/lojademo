{# Products featured that work as examples #}
<section class="section-featured-home" data-store="{{ data_store }}">
	<div class="container">
		<div class="row js-products-{{ highlighted_products_setting_name }}-container" data-format="slider" data-desktop-columns="{% if settings.grid_columns == 2 %}4{% else %}3{% endif %}">
		    <div class="col-12 text-center">
		    	<h3 class="h1 js-products-{{ highlighted_products_setting_name }}-title">{{ products_title }}</h3>
		    </div>
		    <div class="col-12 p-0">
				<div class="js-swiper-featured-demo-{{ highlighted_products_setting_name }} swiper-container swiper-products p-md-1">
	                <div class="swiper-wrapper">
	                	{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_1': true}  %}
	                	{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_2': true}  %}
	                	{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_3': true}  %}
	                	{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_4': true}  %}
	                	{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_5': true}  %}
	                	{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_6': true}  %}
	                </div>
	            </div>
		    </div>

			<div class="js-swiper-featured-demo-prev-{{ highlighted_products_setting_name }} js-swiper-{{ highlighted_products_setting_name }}-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
				<svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
			</div>
			<div class="js-swiper-featured-demo-next-{{ highlighted_products_setting_name }} js-swiper-{{ highlighted_products_setting_name }}-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
				<svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
			</div>
		</div>
	</div>
</section>