{% include "snipplets/svg/empty-placeholders.tpl" %}

{# Slider that work as example #}

<div class="section-slider js-home-slider-placeholder">
	<div class="js-home-empty-slider nube-slider-home swiper-container" style="visibility:hidden; height:0;">
		<div class="swiper-wrapper">
			<div class="swiper-slide slide-container">
				<div class="slider-slide slider-slide-empty"></div>
			</div>
			<div class="swiper-slide slide-container">
				<div class="slider-slide slider-slide-empty"></div>
			</div>
			<div class="swiper-slide slide-container">
				<div class="slider-slide slider-slide-empty"></div>
			</div>
		</div>
		<div class="placeholder-overlay placeholder-slider transition-soft">
            <div class="placeholder-info">
            	<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                <div class="placeholder-description font-small-xs">
                    {{ "Podés subir imágenes principales desde" | translate }} <strong>"{{ "Carrusel de imágenes" | translate }}"</strong>
                </div>
                {% if not params.preview %}
                    <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
                {% endif %}
            </div>
        </div>
		<div class="js-swiper-empty-home-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
			<svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
		</div>
	    <div class="js-swiper-empty-home-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
	    	<svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
	    </div>
	</div>
	{% snipplet 'placeholders/home-slider-placeholder.tpl' %}
</div>

{# Skeleton of "true" section accessed from instatheme.js #}
<div class="js-home-slider-top" style="display:none">
	{% include 'snipplets/home/home-slider.tpl' %}
	{% if has_mobile_slider %}
		{% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
	{% endif %}
</div>