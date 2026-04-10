{% set module = module | default(false) %}

{% set theme_editor = params.preview %}

{% set section_banner = settings.module %}
{% set section_slider = settings.module_slider %}
{% set section_id = 'modules' %}
{% set section_same_size = settings.module_same_size %}

<div class="js-{{ section_id }} position-relative">
	<div class="js-banner-container container {% if section_slider %}pr-0 px-md-4{% endif %}">

		{% if section_slider %}
			<div class="js-swiper-{{ section_id }} swiper-container mb-4 px-md-2">
				<div class="js-banner-row swiper-wrapper">
		{% elseif theme_editor %}
			<div class="js-banner-row">
		{% endif %}

			{% for slide in section_banner %}

				{% set has_banner_text = slide.title or slide.description or slide.button %}

				{% set banner_size_classes = section_same_size  ? 'textbanner-image-equal-size textbanner-image-equal-size-md' : 'p-0' %}
				{% set banner_image_size_classes =  section_same_size ? 'textbanner-image-background' : 'img-fluid d-block w-100' %}
				{% set banner_margin_classes = not section_slider ? 'mb-4 mb-md-5 pb-2 pb-md-0' %}
				{% set banner_info_columns_classes = 'col-md-6' ~ (not section_slider and loop.index is even ? ' order-md-first') %}
				{% set banner_description_spacing_classes =  slide.button and slide.link ? 'mt-0 mb-3 pb-1' %}

				<div class="js-banner flexible-banner {% if section_slider %}swiper-slide{% endif %} position-relative overflow-none">
					<div class="js-textbanner textbanner {{ banner_margin_classes }}">
					{% if slide.link %}
						<a href="{{ slide.link | setting_url }}" class="textbanner-link" aria-label="{{ 'Carrusel' | translate }} {{ loop.index }}">
					{% endif %}
							<div class="row no-gutters align-items-center">
								<div class="js-textbanner-image-container textbanner-image position-relative {{ banner_size_classes }} col-md-6 overflow-none {% if settings.theme_rounded %}box-rounded{% endif %}">
									
									{% set apply_lazy_load = 
										settings.home_order_position_0 != 'modules' 
										or not loop.first
									%}

									{% if apply_lazy_load %}
										{% set slide_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
									{% else %}
										{% set slide_src = slide.image | static_url | settings_image_url('large') %}
									{% endif %}
									
									<img 
										{% if not apply_lazy_load %}fetchpriority="high"{% endif %}
										{% if slide.width and slide.height %} width="{{ slide.width }}" height="{{ slide.height }}" {% endif %} 
										{% if apply_lazy_load %}data-{% endif %}src="{{ slide_src }}"
										{% if apply_lazy_load %}
										data-sizes="auto" 
										data-expand="-10" 
										{% endif %}
										{% if apply_lazy_load %}data-{% endif %}srcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w" 
										class="js-textbanner-image {{ banner_image_size_classes }} {% if apply_lazy_load %}lazyautosizes lazyload fade-in{% endif %}" 
										{% if slide.title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} 
									/>
									{% if apply_lazy_load %}
										<div class="placeholder-fade"></div>
									{% endif %}
								</div>
								{% if has_banner_text %}
									<div class="js-textbanner-text text-center {{ banner_info_columns_classes }} p-3 px-md-5">
										{% if slide.title %}
											<h3 class="textbanner-title h3 h2-md {% if slide.description or slide.button %}mb-2 pb-1{% endif %}">{{ slide.title }}</h3>
										{% endif %}
										{% if slide.description %}
											<div class="textbanner-paragraph {{ banner_description_spacing_classes }}">{{ slide.description }}</div>
										{% endif %}
										{% if slide.button and slide.link %}
											<div class="btn btn-secondary btn-small">{{ slide.button }}</div>
										{% endif %}
									</div>
								{% endif %}
							</div>
					{% if slide.link %}
						</a>
					{% endif %}
					</div>
				</div>

			{% endfor %}
		{% if section_slider %}
				</div>
			</div>
		{% elseif theme_editor %}
			</div>
		{% endif %}
	</div>
	{% if section_slider and section_banner and section_banner is not empty or theme_editor %}
		<div class="js-swiper-{{ section_id }}-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
			<svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
		</div>
		<div class="js-swiper-{{ section_id }}-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
			<svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
		</div>
	{% endif %}
</div>