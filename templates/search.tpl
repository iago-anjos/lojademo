{% paginate by 12 %}
{% set has_filters_available = products and has_filters_enabled and product_filters is not empty %}
{% set search_page_filters = template == 'search' and search_filter %}
{% embed "snipplets/page-header.tpl" with { breadcrumbs: false } %}
	{% block page_header_text %}{{ "Resultados de búsqueda" | translate }}{% endblock page_header_text %}
{% endembed %}

{% include "snipplets/grid/filters-controls.tpl" %}

<section class="category-body">
	<div class="container">
		<div class="row">
			{% if has_filters_available and product_filters is not empty and search_page_filters %}
			<div class="col col-md-2 d-none pr-0 d-md-block visible-when-content-ready">
				{% include "snipplets/grid/filters.tpl" %}
			</div>
			{% endif %}
			<div class="col" data-store="category-grid-{{ category.id }}">
				{% include 'snipplets/grid/products-list.tpl' %}
			</div>
		</div>
	</div>
</section>