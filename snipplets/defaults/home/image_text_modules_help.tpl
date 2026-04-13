{# Modules that work as examples #}

<div class="js-module-banner-placeholder">
	{% for i in 1..2 %}
		<div class="flexible-banner position-relative overflow-none h-auto mb-4 mb-md-5 pb-2 pb-md-3">
			<div class="row no-gutters align-items-center">
				<div class="textbanner-image position-relative p-0 col-md-6 overlay overflow-none {% if settings.theme_rounded %}box-rounded{% endif %}">
					{{ component('placeholders/banner-placeholder')}}
				</div>
				<div class="col-md-6 text-center p-3 px-md-5 {% if loop.index is even %}order-md-first{% endif %}">
					<div class="textbanner-title h3 h2-md mb-2 pb-1">{{ 'Módulo de imagen y texto' | translate }}</div>
					<p class="textbanner-paragraph mt-0 mb-3 pb-1">{{ 'Usá este texto para compartir información de tu negocio, dar la bienvenida a tus clientes o para contar lo increíble que son tus productos.' | translate }}</p>
				</div>
			</div>
			{% if not params.preview %}
				<div class="placeholder-overlay transition-soft">
					<div class="placeholder-info">
						<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
						<div class="placeholder-description font-small-xs">
							{{ "Podés contar más sobre tu tienda desde" | translate }} <strong>"{{ "Módulos de imagen y texto" | translate }}"</strong>
						</div>
						<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
					</div>
				</div>
			{% endif %}
		</div>
	{% endfor %}
</div>

{# Skeleton of "true" section accessed from instatheme.js #}
<div class="js-module-banner-top" style="display:none">    
	{% include 'snipplets/home/home-modules.tpl' with {'has_module': true} %}
</div>