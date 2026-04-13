{% set contact_list_class = centered_info ? 'text-center list-unstyled' %}
{% set contact_icon_class = not centered_info ? 'contact-item-icon' %}
{% set contact_item_class = centered_info ? 'mb-3' : 'contact-item' %}

<ul class="contact-info {{ contact_list_class }}">
	{% if store.whatsapp %}
		<li class="{{ contact_item_class }}">
			<svg class="icon-inline icon-lg icon-w {{ contact_icon_class }}"><use xlink:href="#whatsapp"/></svg>
			<a href="{{ store.whatsapp }}" class="contact-link">{{ store.whatsapp |trim('https://wa.me/') }}</a>
		</li>
	{% endif %}
	{% if store.phone %}
		<li class="{{ contact_item_class }}">
			<svg class="icon-inline icon-lg icon-w {{ contact_icon_class }}"><use xlink:href="#phone"/></svg>
			<a href="tel:{{ store.phone }}" class="contact-link">{{ store.phone }}</a>
		</li>
	{% endif %}
	{% if store.email %}
		<li class="{{ contact_item_class }}">
			<svg class="icon-inline icon-lg icon-w {{ contact_icon_class }}"><use xlink:href="#email"/></svg>
			<a href="mailto:{{ store.email }}" class="contact-link">{{ store.email }}</a>
		</li>
	{% endif %}
	{% if not phone_and_mail_only %}
		{% if store.address and not is_order_cancellation %}
			<li class="{{ contact_item_class }}">
				<svg class="icon-inline icon-lg icon-w {{ contact_icon_class }}"><use xlink:href="#map-marker-alt"/></svg>
				{{ store.address }}
			</li>
		{% endif %}
		{% if store.blog %}
			<li class="{{ contact_item_class }}">
				<svg class="icon-inline icon-lg icon-w {{ contact_icon_class }}"><use xlink:href="#comments"/></svg>
				<a target="_blank" href="{{ store.blog }}" class="contact-link">{{ "Visita nuestro Blog!" | translate }}</a>
			</li>
		{% endif %}
	{% endif %}
</ul>