<section class="category-header section-margin">
	<div class="container">
		<div class="row d-md-none">
			<div class="col-12 d-md-none">
				{% include "snipplets/breadcrumbs.tpl" %}
			</div>
			<div class="col">
				{% embed "snipplets/page-header.tpl" %}
					{% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
				{% endembed %}
			</div>
		</div>
		<div class="row align-items-center mb-md-5 mb-3">
			<div class="col-9 d-none d-md-block">
				{% include "snipplets/breadcrumbs.tpl" %}
			</div>
			<div class="col-8 offset-2 offset-md-0 col-md-3">
				{{ component(
                    'sort-by',{
                        label: false,
                        sort_by_classes: {
                            select_group: "mb-0",
                            select_label: "h2 font-extra-large mb-3 d-block",
                            select: "font-weight-bold",
                            select_svg: "icon-inline icon-w-14 icon-lg",
                        },
                        select_svg_id: 'sort-alt'
                    })
                }} 
			</div> 
		</div>
	</div>
</section>
<section class="category-body">
	<div class="container">
		<div class="row">
			{% if settings.product_filters %} 
				<div class="col col-md-2 d-none d-md-block">
					<h3 class="title-section mb-4">{{ category.name }}</h3>
				</div>
			{% endif %}
			<div class="col">
				<div class="js-product-table row">
					{% include "snipplets/svg/empty-placeholders.tpl" %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_3': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_4': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_5': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_6': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_7': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_8': true} %}
					{% include 'snipplets/defaults/help_item.tpl' with {'help_item_1': true} %}
				</div>
			</div>
		</div>
	</div>
</section>