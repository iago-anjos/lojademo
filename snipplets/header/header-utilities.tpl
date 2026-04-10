<div class="utilities-container  {% if settings.icons_size_desktop == 'small' %}mr-0{% endif %}">
	{% set icon_desktop_class = '' %}
	{% if settings.icons_size_desktop == 'small' %}
		{% set icon_desktop_class = 'icon-desktop-lg' %}
	{% endif %}
	{% set attention_head = store.whatsapp or store.phone or store.email %}
	{% if attention_head %}
		
		<div class="js-utilities-item nav-dropdown utilities-item transition-soft d-none d-md-inline-block {% if settings.icons_size_desktop == 'small' %}w-md-auto ml-md-4{% endif %}">
			<div class="utility-head text-center">
				<svg class="icon-inline icon-2x icon-w-20 {{ icon_desktop_class }}"><use xlink:href="#chat"/></svg>
				<span class="utility-name transition-soft d-block{% if settings.icons_solid %} font-weight-bold{% endif %} {% if settings.icons_size_desktop == 'small' %}d-md-inline-block pt-0 ml-1{% endif %}">{{ 'Ayuda' | translate }}</span>
			</div>
			<ul class="js-subutility-list nav-dropdown-content subutility-list">
				{% if store.whatsapp %}
					<li class="subutility-list-item">
						<a href="{{ store.whatsapp }}" class="contact-link">
							<svg class="icon-inline icon-md mr-1"><use xlink:href="#whatsapp"/></svg> {{ store.whatsapp |trim('https://wa.me/') }}
						</a>
					</li>
				{% elseif store.phone %}
					<li class="subutility-list-item">
						<a href="tel:{{ store.phone }}" class="contact-link">
							<svg class="icon-inline icon-md mr-1"><use xlink:href="#phone"/></svg> {{ store.phone }}
						</a>
					</li>
				{% endif %}
				{% if store.email %}
					<li class="subutility-list-item">
						<a href="mailto:{{ store.email }}" class="contact-link">
							<svg class="icon-inline icon-md mr-1"><use xlink:href="#email"/></svg> {{ store.email }}
						</a>
					</li>
				{% endif %}
			</ul>
		</div>
	{% endif %}

	
	<div class="nav-dropdown utilities-item transition-soft d-none d-md-inline-block {% if settings.icons_size_desktop == 'small' %}w-md-auto ml-md-4{% endif %}" data-store="account-links">
		{% if store.country == 'AR'%}
			{# Tooltip for quick login on AR stores #}
			{% include "snipplets/tooltip-login.tpl" with {desktop: "true"} %}
		{% endif %}
		<div class="js-utilities-item">
			<div class="utility-head text-center">
				<svg class="icon-inline icon-2x icon-w-18 {{ icon_desktop_class }}"><use xlink:href="#user"/></svg>
				{% if store.country == 'AR'%}
					{# Notification tooltip for quick login on AR stores #}
					<a data-toggle="#quick-login" class="js-modal-open js-quick-login-badge" style="display: none;">
						<div class="badge badge-overlap swing"></div>
					</a>
				{% endif %}
				<span class="utility-name transition-soft d-block{% if settings.icons_solid %} font-weight-bold{% endif %} {% if settings.icons_size_desktop == 'small' %}d-md-inline-block pt-0 ml-1{% endif %}">
					{% if not customer %}
						{{ 'Mi cuenta' | translate }}
					{% else %}
						{% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
						{{ "¡Hola, {1}!" | t(customer_short_name) }}
					{% endif %}
				</span>
			</div>
			<ul class="js-subutility-list nav-dropdown-content subutility-list">
				{% if not customer %}
					{% if 'mandatory' not in store.customer_accounts %}
						<li class="subutility-list-item nav-accounts-item">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'nav-accounts-link') }}</li>
					{% endif %}
						<li class="subutility-list-item nav-accounts-item">{{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'js-login nav-accounts-link') }}</li>
					{% else %}
					<li class="subutility-list-item nav-accounts-item">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'nav-accounts-link') }}</li>
					<li class="subutility-list-item nav-accounts-item">{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'nav-accounts-link') }}</li>
				{% endif %}
			</ul>
		</div>
	</div>	
	{% if not store.is_catalog %}    
	<div class="utilities-item {% if settings.icons_size_desktop == 'small' %}w-md-auto ml-md-4{% endif %}">
		<div id="ajax-cart" class="cart-summary transition-soft utility-head text-center" data-component='cart-button'>
			<a {% if settings.ajax_cart and template != 'cart' %}href="#" class="js-modal-open js-toggle-cart js-fullscreen-modal-open" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% else %}href="{{ store.cart_url }}"{% endif %}>
				<svg class="icon-inline icon-2x icon-w-19 {{ icon_desktop_class }}"><use xlink:href="#cart"/></svg>
				<span class="utility-name transition-soft d-none {% if settings.icons_solid %} font-weight-bold{% endif %} {% if settings.icons_size_desktop == 'small' %}d-md-inline-block pt-0 ml-1{% else %}d-md-block{% endif %}">{{ 'Mi carrito' | translate }}</span>
				<span class="js-cart-widget-amount badge badge-amount">{{ "{1}" | translate(cart.items_count ) }}</span>
			</a>	
		</div>
	</div>
	{% endif %}
</div>
