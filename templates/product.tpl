<div id="single-product" class="js-product-detail js-product-container js-has-new-shipping js-shipping-calculator-container" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
	<div class="container pt-3 pt-md-4 pb-4">
		<div class="product-columns mb-md-4">
			<div class="product-images mb-4 mb-md-0" data-store="product-image-{{ product.id }}">
				{% include 'snipplets/product/product-image.tpl' %}
			</div>
			<div class="product-info" data-store="product-info-{{ product.id }}">
				{% include 'snipplets/product/product-form.tpl' %}
			</div>
		</div>
		{% include 'snipplets/product/product-description.tpl' %}
	</div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}