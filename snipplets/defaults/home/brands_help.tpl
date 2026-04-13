{# Slider brands that work as examples #}

{% set brand_logo_view_box = '0 0 576 512' %}

<section class="section-brands-home" data-store="home-brands">
	<div class="container">
		<div class="row">
			<div class="col p-0 px-md-3">
				<div class="js-swiper-brands swiper-container">
				    <div class="swiper-wrapper">
		                <div class="swiper-slide slide-container">
		                	<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
		            	<div class="swiper-slide slide-container">
	                		<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
		            	<div class="swiper-slide slide-container">
	                		<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
		            	<div class="swiper-slide slide-container">
	                		<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
		            	<div class="swiper-slide slide-container">
	                		<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
		            	<div class="swiper-slide slide-container">
	                		<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
		            	<div class="swiper-slide slide-container">
	                		<svg class="icon-inline icon-4x brand-image svg-icon-text" viewBox="{{ brand_logo_view_box }}"><use xlink:href="#help-logo"/></svg>
		            	</div>
				    </div>
				</div>
			</div>
		</div>
	</div>
	{% if admin_user %}
		<div class="placeholder-overlay placeholder-slider transition-soft">
	        <div class="placeholder-info">
	        	<svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
	            <div class="placeholder-description font-small-xs">
	                {{ "Podés subir logos para el" | translate }} </br><strong>"{{ "Carrusel de marcas" | translate }}"</strong>
	            </div>
	            {% if not params.preview %}
	                <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
	            {% endif %}
	        </div>
	    </div>
	{% endif %}
	<div class="js-swiper-brands-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
		<svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
	</div>
    <div class="js-swiper-brands-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
    	<svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
    </div>
</section>