{% set empty_placeholder_image = 'images/empty-placeholder.png' | static_url %}
{% if payments %}
	{% for payment in settings.payments %}
		<img src="{{ empty_placeholder_image }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}" width="40" height="25">
    {% endfor %}
{% elseif shipping %}
	{% for shipping in settings.shipping %}
		<img src="{{ empty_placeholder_image }}" data-src="{{ shipping | shipping_logo }}" class="icon-logo lazyload" alt="{{ shipping }}" width="40" height="25">
    {% endfor %}
{% endif %}