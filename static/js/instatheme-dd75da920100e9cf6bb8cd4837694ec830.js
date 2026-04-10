window.tiendaNubeInstaTheme = (function(jQueryNuvem, countryCode) {
	return {
		waitFor: function() {
			return [];
		},
		placeholders: function() {
			return [
				{
					placeholder: '.js-home-slider-placeholder',
					content: '.js-home-slider-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-category-banner-placeholder',
					content: '.js-category-banner-top',
					contentReady: function() {
						return $(this).find('.js-category-banner-container').filter(function () {
							return $(this).data('visible');
						}).length > 0;
					},
				},
				{
					placeholder: '.js-module-banner-placeholder',
					content: '.js-module-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-informative-banners-placeholder',
					content: '.js-informative-banners-top',
					contentReady: function() {
						// Show only if there are any titles defined
						return $(this).find('.js-informative-banner-title').map(function(){
							return this.textContent;
						}).get().join('').trim();
					},
				},
				{
					placeholder: '.js-home-video-placeholder',
					content: '.js-home-video-top',
					contentReady: function() {
						// Show only if the thumbnail is ready
						return $(this).find('.js-home-video-container').data('thumbnail-ready');
					},
				}
			];
		},
		handlers: function(instaElements) {
			const handlers = {
				logo: new instaElements.Logo({
					$storeName: jQueryNuvem('#no-logo'),
					$logo: jQueryNuvem('#logo')
				}),
				// ----- Section order -----
				home_order_position: new instaElements.Sections({
					container: '.js-home-sections-container',
					data_store: {
						'slider': 'home-slider',
						'products': 'home-products-featured',
						'informatives': 'banner-services',
						'categories': 'home-banner-categories',
						'welcome': 'home-welcome-message',
						'institutional': 'home-institutional-message',
						'brands': 'home-brands',
						'new': 'home-products-new',
						'video': 'home-video',
						'sale': 'home-products-sale',
						'instafeed': 'home-instagram-feed',
						'promotional': 'home-banner-promotional',
						'modules': 'home-image-text-module',
						'newsletter': 'home-newsletter',
					}
				})
			};

			// ----------------------------------- Slider -----------------------------------

			// Build the html for a slide given the data from the settings editor
			function buildHomeSlideDom(aSlide) {
				return '<div class="swiper-slide slide-container">' +
					(aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
					'<img src="' + aSlide.src + '" class="slider-image"/>' +
					'<div class="swiper-text swiper-' + aSlide.color + '">' +
					(aSlide.description ? '<div class="swiper-description mb-3">' + aSlide.description + '</div>' : '' ) +
					(aSlide.title ? '<div class="swiper-title">' + aSlide.title + '</div>' : '' ) +
					(aSlide.button && aSlide.link ? '<div class="btn btn-primary btn-small swiper-btn mt-4 px-4">' + aSlide.button + '</div>' : '' ) +
					'</div>' +
					(aSlide.link ? '</a>' : '' ) +
					'</div>'
			}

			// Update main slider
			handlers.slider = new instaElements.Lambda(function(slides){
				if (!window.homeSwiper) {
					return;
				}

				window.homeSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.homeSwiper.appendSlide(buildHomeSlideDom(aSlide));
				});
			});

			// Update mobile slider
			handlers.slider_mobile = new instaElements.Lambda(function(slides){
				// This slider is not included in the html if `toggle_slider_mobile` is not set.
				// The second condition could be removed if live preview for this checkbox is implemented but changing the viewport size forces a refresh, so it's not really necessary.
				if (!window.homeMobileSwiper || !window.homeMobileSwiper.slides) {
					return;
				}

				window.homeMobileSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.homeMobileSwiper.appendSlide(buildHomeSlideDom(aSlide));
				});
			});

			// Toggle full-width for sliders
			handlers.slider_full = new instaElements.Lambda(function(value){
				const $top = $('.js-live-preview-home-slider-container');

				const $section = $top.closest('section');
				const $bootstrapContainer = $top.children();
				const $bootstrapCol = $bootstrapContainer.find('.js-home-slider-col');
				const $swiperContainerRoundableBorders = $bootstrapContainer.find('.js-swiper-roundable-border');

				if (value) {
					$top.removeClass('mt-4');
					$bootstrapContainer.removeClass('container').addClass('container-fluid');
					$bootstrapCol.addClass('p-0');
					$swiperContainerRoundableBorders.removeClass('box-rounded'); // Full screen never uses rounded borders

					$section.css('padding-top', 0); // This is to force a resize so the section overlay updates after change of margin-top for $top
				} else {
					$top.addClass('mt-4');
					$bootstrapContainer.removeClass('container-fluid').addClass('container');
					$bootstrapCol.removeClass('p-0');
					if (useRoundedCorners()) {
						$swiperContainerRoundableBorders.addClass('box-rounded');
					}

					$section.css('padding-top', '1px'); // Same as above
				}
			});

			// Toggle unified height for sliders
			handlers.slider_viewport_height = new instaElements.Lambda(function(value){
				const $wrapper = $('.js-live-preview-home-slider-container .section-slider');

				const $slides = $wrapper.find('.slider-slide');
				if (value) {
					$wrapper.removeClass('section-slider-auto');
					$slides.removeClass('position-relative h-auto');
				} else {
					$wrapper.addClass('section-slider-auto');
					$slides.addClass('position-relative h-auto');
				}
			});


			// ----------------------------------- Brands Slider -----------------------------------

			// Build the html for a slide given the data from the settings editor
			function buildBrandsSlideDom(aSlide) {
				return '<div class="swiper-slide slide-container">' +
					(aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
					'<img src="' + aSlide.src + '" class="brand-image"/>' +
					(aSlide.link ? '</a>' : '' ) +
					'</div>'
			}

			// Update brands carousel
			handlers.brands = new instaElements.Lambda(function(slides){
				if (!window.brandsSwiper) {
					return;
				}

				window.brandsSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.brandsSwiper.appendSlide(buildBrandsSlideDom(aSlide));
				});
			});


			// ----------------------------------- Informative Banners -----------------------------------

			// Map of icon code => icon svg
			var informativeBannersIconMap = {
				image: "image",
				shipping: "#shipping-circle",
				card: "#credit-card-circle",
				security: "#security-circle",
				returns: "#returns-circle",
				whatsapp: "#whatsapp-circle",
				promotions: "#promotions-circle",
				hand: "#clean-hands-circle",
				home: "#stay-home-circle",
				office: "#home-office-circle",
				cash: countryCode == 'BR' ? "#barcode-circle" : "#cash-circle",
			};

			// Toggle entire informative banners section
			handlers.banner_services =  new instaElements.Lambda(function(isVisible){
				const $container = $('.js-informative-banners-container');

				if (isVisible) {
					$container.show();
				} else {
					$container.hide();
				}

			});
			for (let i = 1; i <= 4; i++) {

				if ($(`.js-informative-banner-img-${i}`).attr('src')) {
					// Add html for icon
					$(`.js-informative-banner-img-${i}`).closest(`.js-informative-banner-icon-${i}`).prepend(`<div class="js-informative-banner-icon-svg" style="display:none;"><svg class="icon-inline icon-5x svg-icon-text"><use xlink:href=""/></svg></div>`);
				} else {
					// Add html for image
					$(`.js-informative-banner-icon-${i}`).prepend(`<img class="js-informative-banner-img js-informative-banner-img-${i} service-item-image" style="display:none;"></img>`);
				}

				// Update icon for each informative banner
				handlers[`banner_services_0${i}_icon`] = new instaElements.Lambda(function(iconCode){
					if (!informativeBannersIconMap[iconCode]) {
						return;
					}
					if (informativeBannersIconMap[iconCode] == 'image') {
						$(`.js-informative-banner-icon-${i}`).find('.js-informative-banner-icon-svg').hide();
						$(`.js-informative-banner-img-${i}`).show();
					} else {
						$(`.js-informative-banner-icon-${i}`).find('.js-informative-banner-icon-svg').show();
						$(`.js-informative-banner-img-${i}`).hide();
					}

					$(`.js-informative-banner-icon-${i} .js-informative-banner-icon-svg`).html(`<svg class="icon-inline icon-5x svg-icon-text"><use xlink:href="${informativeBannersIconMap[iconCode]}"/></svg>`);
				});

				// Update image for each informative banner
				handlers[`banner_services_0${i}.jpg`] = new instaElements.Image({
					element: `.js-informative-banner-img-${i}`,
					show: function() {
						if ($(`.js-informative-banner-icon-${i}`).find('.js-informative-banner-icon-svg').css('display') === 'none') {
							$(`.js-informative-banner-img-${i}`).show();
							$(`.js-informative-banner-icon-${i}`).find('.js-informative-banner-icon-svg').hide();
						}
					},
					hide: function() {
						$(`.js-informative-banner-img-${i}`).hide();
					},
				});

				// Update title and description for each informative banner
				['title', 'description'].forEach(setting => {
					handlers[`banner_services_0${i}_${setting}`] = new instaElements.Text({
						element: `.js-informative-banner-${setting}-${i}`,
						show: function(){
							$(this).closest('.js-informative-banner-container').show();
						},
						hide: function(){
							$(this).closest('.js-informative-banner-container');

							if (!$container.text().trim()) {
								$container.hide();
							}
						},
					});
				});
			}


			// ----------------------------------- Category Banners -----------------------------------

			// Show or hide category banner depending on its contents
			function calculateCategoryBannerContainerVisibility($container) {
				// Only show if there's actual content inside -- This mimics the tpl behavior
				if ($container.data('visible') && ($container.text().trim() || $container.find('img').attr('src'))) {
					$container.show();
				} else {
					$container.hide();
				}

				// Recalculate grid classes in case the number of banners shown has changed
				setBannerContainerGridClasses('.js-category-banner-container');
			}

			// Set col-* classes depending on the number of visible banners
			function setBannerContainerGridClasses(selector) {
				const $banners = $(selector);
				const qty = $banners.filter(':visible').length;

				$banners.removeClass('col-md-6 col-md-4 offset-md-3');
				if (qty == 3) {
					$banners.addClass('col-md-4');
				} else if (qty == 2) {
					$banners.addClass('col-md-6');
				} else {
					$banners.addClass('col-md-6 offset-md-3');
				}
			}

			// Toggle full-width for category banners
			handlers.banners_full = new instaElements.Lambda(function(isFullwidth){
				const $container = $('.js-category-banner-fullwidth');
				if (isFullwidth) {
					$container.removeClass('container').addClass('container-fluid');
				} else {
					$container.removeClass('container-fluid').addClass('container');
				}
			});

			for (let i = 1; i <= 3; i++) {
				// Toggle individual banners
				handlers[`banner_0${i}_show`] = new instaElements.Lambda(function(isVisible){
					const $container = $(`.js-category-banner-container-${i}`);
					$container.data('visible', isVisible);

					if (isVisible) {
						calculateCategoryBannerContainerVisibility($container);
					} else {
						calculateCategoryBannerContainerVisibility($container);
					}
				});

				// Update image for banner
				handlers[`banner_0${i}.jpg`] = new instaElements.Image({
					element: `.js-banner-img-${i}`,
					show: function() {
						$(this).parent().show();

						// Maybe show container now that there's content inside
						calculateCategoryBannerContainerVisibility($(this).closest('.js-category-banner-container'));
					},
					hide: function() {
						$(this).parent().hide();

						// Maybe hide if there's no content inside
						calculateCategoryBannerContainerVisibility($(this).closest('.js-category-banner-container'));
					},
				});

				// Update text and description for banner
				['title', 'description'].forEach(setting => {
					handlers[`banner_0${i}_${setting}`] = new instaElements.Text({
						element: `.js-category-banner-${setting}-${i}`,
						show: function() {
							$(this).show();
							$(this).parent().show();

							// Maybe show container now that there's content inside
							calculateCategoryBannerContainerVisibility($(this).closest('.js-category-banner-container'));
						},
						hide: function() {
							$(this).hide();
							if (!$(this).parent().text().trim()) {
								$(this).parent().hide();
							}

							// Maybe hide if there's no content inside
							calculateCategoryBannerContainerVisibility($(this).closest('.js-category-banner-container'));
						}
					});
				});
			}


			// ----------------------------------- Promotional Banners -----------------------------------

			// Show or hide promotional banner depending on its contents
			function calculatePromotionalBannerContainerVisibility($container) {
				// Only show if there's a title or an image inside -- This mimics the tpl behavior
				if ($container.data('visible') && ($container.find('.js-promotional-banner-title').text().trim() || $container.find('img').attr('src'))) {
					$container.show();
				} else {
					$container.hide();
				}

				// Recalculate grid classes in case the number of banners shown has changed
				setBannerContainerGridClasses('.js-promotional-banner-container');

			}

			function calculateOverlayClass($overlayContainer) {
				const hasTitle = $overlayContainer.find('.js-promotional-banner-title').text().trim();
				const hasButton = $overlayContainer.find('.js-promotional-banner-button').is(':visible');

				if (hasTitle || hasButton) {
					$overlayContainer.addClass('overlay');
				} else {
					$overlayContainer.removeClass('overlay');
				}
			}

			// Toggle full-width for promotional banners
			handlers.banner_promotional_full = new instaElements.Lambda(function(isFullwidth){
				const $container = $('.js-promotional-banner-fullwidth');
				if (isFullwidth) {
					$container.removeClass('container').addClass('container-fluid');
				} else {
					$container.removeClass('container-fluid').addClass('container');
				}
			});

			for (let i = 1; i <= 3; i++) {
				// Toggle individual banners
				handlers[`banner_promotional_0${i}_show`] = new instaElements.Lambda(function (isVisible) {
					const $container = $(`.js-promotional-banner-container-${i}`);
					$container.data('visible', isVisible);

					if (isVisible) {
						calculatePromotionalBannerContainerVisibility($container);
					} else {
						calculatePromotionalBannerContainerVisibility($container);
					}
				});

				// Update image for banner
				handlers[`banner_promotional_0${i}.jpg`] = new instaElements.Image({
					element: `.js-promotional-banner-img-${i}`,
					show: function() {
						$(this).show();

						// Maybe show container now that there's content inside
						calculatePromotionalBannerContainerVisibility($(this).closest('.js-promotional-banner-container'));
					},
					hide: function() {
						$(this).hide();

						// Maybe hide if there's no content inside
						calculatePromotionalBannerContainerVisibility($(this).closest('.js-promotional-banner-container'));
					},
				});

				// Update text and description for banner
				handlers[`banner_promotional_0${i}_title`] = new instaElements.Text({
					element: `.js-promotional-banner-title-${i}`,
					show: function() {
						// Maybe show container now that there's content inside
						calculatePromotionalBannerContainerVisibility($(this).closest('.js-promotional-banner-container'));
						calculateOverlayClass($(this).closest('.js-textbanner-image'));
					},
					hide: function() {
						// Maybe hide if there's no content inside
						calculatePromotionalBannerContainerVisibility($(this).closest('.js-promotional-banner-container'));
						calculateOverlayClass($(this).closest('.js-textbanner-image'));
					}
				});

				// Update button for banner
				handlers[`banner_promotional_0${i}_button`] = new instaElements.Text({
					element: `.js-promotional-banner-button-${i}`,
					show: function() {
						if ($(this).data('has-url')) {
							$(this).show();
						} else {
							$(this).hide();
						}

						calculateOverlayClass($(this).closest('.js-textbanner-image'));
					},
					hide: function() {
						$(this).hide();
						calculateOverlayClass($(this).closest('.js-textbanner-image'));
					}
				});

				// Toggle has-url data attribute which is used in the show/hide logic of the button above
				handlers[`banner_promotional_0${i}_url`] = new instaElements.Lambda(function(value){
					const $button = $(`.js-promotional-banner-button-${i}`);

					$button.data('has-url', !!value);
					if (value && $button.text().trim()) {
						$button.show();
					} else {
						$button.hide();
					}

					calculateOverlayClass($button.closest('.js-textbanner-image'));
				});
			}

			// ----------------------------------- Main Banners -----------------------------------

			// Build the html for a slide given the data from the settings editor

			var slideCount = 0;

			function buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, textClasses, imageContainerClasses, imageClasses, bannerModule) {
				slideCount++;
				var evenClass = slideCount % 2 === 0 ? '' : 'order-md-first';
				return '<div class="js-banner flexible-banner position-relative overflow-none ' + bannerClasses + '">' +
						'<div class="js-textbanner textbanner ' + textBannerClasses + '">' +
							(aSlide.link ? '<a href="' + aSlide.link + '" class="textbanner-link">' : '' ) +
								(bannerModule ? '<div class="row no-gutters align-items-center">' : '' ) +
									'<div class="js-textbanner-image-container textbanner-image overflow-none ' + (bannerModule ? 'col-md-6 ' : '') + imageContainerClasses + '">' +
										'<img src="' + aSlide.src + '" class="js-textbanner-image textbanner-image-effect ' + imageClasses + '">' +
									'</div>' +
									(aSlide.title || aSlide.description || aSlide.button ? '<div class="js-textbanner-text ' + (bannerModule ? 'col-md-6 text-center p-3 px-md-5 ' + evenClass : '') + textClasses + '">' : '') +
										(aSlide.title ? '<div class="textbanner-title h3 h2-md mb-2 pb-1">' + aSlide.title + '</div>' : '' ) +
										(aSlide.description ? '<div class="textbanner-paragraph ' + (aSlide.button && aSlide.link ? 'mt-0 mb-3 pb-1' : '') + '">' + aSlide.description + '</div>' : '' ) +
										(aSlide.button && aSlide.link ? '<div class="btn btn-secondary btn-small">' + aSlide.button + '</div>' : '' ) +
									(aSlide.title || aSlide.description || aSlide.button ? '</div>' : '') +
								(bannerModule ? '</div>' : '' ) +
							(aSlide.link ? '</a>' : '' ) +
						'</div>' +
					'</div>'
			}

			// Build swiper JS for Banners

			function initSwiperJS(bannerMainContainer, swiperId, swiperName, isModule){

				// Initialize swiper
				createSwiper(`.js-swiper-${swiperId}`, {
					watchOverflow: true,
					centerInsufficientSlides: true,
					threshold: 5,
					watchSlideProgress: true,
					watchSlidesVisibility: true,
					slideVisibleClass: 'js-swiper-slide-visible',
					spaceBetween: 30,
					navigation: {
						nextEl: `.js-swiper-${swiperId}-next`,
						prevEl: `.js-swiper-${swiperId}-prev`
					},
					slidesPerView: 1.25,
					breakpoints: {
						768: {
							slidesPerView: 1,
						}
					}
				},
				function(swiperInstance) {
					window[swiperName] = swiperInstance;
				});

			}

			// Main banners: Banner content and order updates. General layout and format updates (for main and secondary banners)

			['module'].forEach(setting => {

				const bannerName = setting;
				const bannerPluralName = 
					setting == 'module' ? 'modules' :
					null;

				const isModule = setting == 'module';
				const $generalBannersContainer = $(`.js-home-${bannerName}`);

				// Main banner
				const $mainBannersContainer = $generalBannersContainer.find(`.js-${bannerPluralName}`);
				const $bannerItem = $generalBannersContainer.find('.js-banner');
				const bannerSwiper = 
					setting == 'module' ? 'homeModuleSwiper' :
					null;

				const bannerModuleSetting = setting == 'module' ? true : false;
				const bannerFormat = $generalBannersContainer.attr('data-format');

				// Update banners content and order

				handlers[`${setting}`] = new instaElements.Lambda(function(slides){

					// Update text classes
					const textPosition = $generalBannersContainer.attr('data-text');
					const textClasses = textPosition == 'above' ? 'over-image' : '';

					// Update margin classes
					const bannerFormat = $generalBannersContainer.attr('data-format');
					const marginClasses = isModule && bannerFormat == 'grid' ? ' mb-4 mb-md-5 pb-2'  : '';

					// Update textbanner classes
					const textBannerClasses = marginClasses;

					// Update image classes
					const imageSize = $generalBannersContainer.attr('data-image');
					const imageClasses = imageSize == 'same' ? 'textbanner-image-background' : 'img-fluid d-block w-100';
					const imageContainerClasses = 
						imageSize == 'original' ? 'p-0' : 
						isModule && imageSize == 'same' ? 'textbanner-image-equal-size textbanner-image-equal-size-md' : '';

					

					if (bannerFormat == 'slider') {
						// Update banner classes
						const bannerClasses = 'swiper-slide';

						if (!window[bannerSwiper]) {
							return;
						}

						// Try using already created swiper JS, if it fails initialize swipers again
						try{
							window[bannerSwiper].removeAllSlides();
							slides.forEach(function(aSlide){
								window[bannerSwiper].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
							});
							window[bannerSwiper].update();
						}catch(e){
							initSwiperJS($generalBannersContainer, bannerPluralName, bannerSwiper, isModule);

							setTimeout(function(){
								slides.forEach(function(aSlide){
									window[bannerSwiper].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
								});	
							},500);
						}
					} else {
						// Update banner classes
						const bannerClasses = isModule ? '' : 'col-grid';
						// Update column classes
						const desktopColumnsClasses = $generalBannersContainer.attr('data-grid-classes');

						$mainBannersContainer.find('.swiper-slide-duplicate').remove();
						$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-prev`).remove();
						$mainBannersContainer.find(`.js-swiper-${bannerPluralName}-next`).remove();
						$mainBannersContainer.find('.js-banner').remove();

						slides.forEach(function(aSlide){
							$mainBannersContainer.find('.js-banner-row').append(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, textClasses, imageContainerClasses, imageClasses, bannerModuleSetting));
						});
					}

					$generalBannersContainer.data('format', bannerFormat);
				});

				function initSwiperElements(bannerRow, swiperId, swiperName, isModule) {

					const bannerMarginClasses = isModule ? 'justify-content-center' : '';

					const $bannerContainer = $generalBannersContainer.find('.js-banner-container');
					const $bannerItem = $generalBannersContainer.find('.js-banner');

					$bannerContainer.addClass("pr-0 px-md-4");
					$bannerItem.removeClass('col-md-6 mb-md-5 pb-md-3');
					$bannerItem.find(".js-textbanner").removeClass("mb-md-5 pb-md-3");

					// Row to swiper wrapper
					bannerRow.removeClass(bannerMarginClasses).addClass('swiper-wrapper');

					// Wrap everything inside a swiper container
					bannerRow.wrapAll(`<div class="js-swiper-${swiperId} swiper-container mb-4 px-md-2"></div>`);

					// Replace each banner into a slide
					$bannerItem.addClass('swiper-slide');

					// Add previous and next controls
					$mainBannersContainer.append(`
						<div class="js-swiper-${swiperId}-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text">
							<svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</div>
						<div class="js-swiper-${swiperId}-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text">
							<svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
						</div>
					`);
					
					// Initialize swiper

					initSwiperJS($generalBannersContainer, swiperId, swiperName, isModule);
				}

				// Build grid markup and reset swiper

				function resetSwiperElements(bannersGroupContainer, bannerRow, swiperId, isModule) {

					const $bannerContainer = $generalBannersContainer.find('.js-banner-container');
					const $bannerItem = $generalBannersContainer.find('.js-banner');

					$bannerContainer.removeClass("pr-0 px-md-4");

					// Remove duplicate slides and slider controls
					bannersGroupContainer.find('.swiper-slide-duplicate').remove();
					bannersGroupContainer.find(`.js-swiper-${swiperId}-prev, .js-swiper-${swiperId}-next`).remove();

					// Swiper wrapper to row
					bannerRow.removeClass('swiper-wrapper').removeAttr('style');

					// Undo all slider wrappers and restore original classes
					bannerRow.unwrap();
					$bannerItem.find(".js-textbanner").addClass("mb-md-5 pb-md-3");
					$bannerItem
						.removeClass('js-swiper-slide-visible swiper-slide-active swiper-slide-next swiper-slide-prev swiper-slide')
						.removeAttr('style');
				}

				// Toggle grid and slider format

				handlers[`${setting}_slider`] = new instaElements.Lambda(function(bannerSlider){

					// Main banners markup container
					const $mainBannerRow = $mainBannersContainer.find('.js-banner-row');

					if (bannerSlider) {
						$generalBannersContainer.attr('data-format', 'slider');
					} else {
						$generalBannersContainer.attr('data-format', 'grid');
					}

					const bannerFormat = $generalBannersContainer.attr('data-format');

					const toSlider = bannerFormat == "slider";

					if ($generalBannersContainer.data('format') == bannerFormat) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {

						initSwiperElements($mainBannerRow, bannerPluralName, bannerSwiper, isModule);

					// From slider to grid
					} else {
						resetSwiperElements($mainBannersContainer, $mainBannerRow, bannerPluralName, isModule);

						// Add margin if modules
						if (isModule) {
							$bannerItem.addClass('mb-4 mb-md-5 pb-2');
						}
					}

					// Persist new format in data attribute
					$generalBannersContainer.data('format', bannerFormat);
				});

				// Update banner size

				handlers[`${setting}_same_size`] = new instaElements.Lambda(function(bannerSize){
					const $bannerImageContainer = $generalBannersContainer.find('.js-textbanner-image-container');
					const $bannerImage = $generalBannersContainer.find('.js-textbanner-image');

					if (bannerSize) {
						$generalBannersContainer.attr('data-image', 'same');
						$bannerImageContainer.removeClass('p-0').addClass("textbanner-image-equal-size textbanner-image-equal-size-md");
						$bannerImage.removeClass('img-fluid d-block w-100').addClass('textbanner-image-background');
					} else {
						$generalBannersContainer.attr('data-image', 'original');
						$bannerImageContainer.addClass('p-0').removeClass("textbanner-image-equal-size textbanner-image-equal-size-md");
						$bannerImage.removeClass('textbanner-image-background').addClass('img-fluid d-block w-100');
					}
				});

			});

			// ----------------------------------- Highlighted Products -----------------------------------

			// Same logic applies to all 3 types of highlighted products
			['featured', 'sale', 'new'].forEach(setting => {
				// Update title text
				handlers[`${setting}_products_title`] = new instaElements.Text({
					element: `.js-products-${setting}-title`
				})

				// Toggle grid and slider view
				handlers[`${setting}_products_format`] = new instaElements.Lambda(function(format){
					const toSlider = format == "slider";

					const $container = $(`.js-products-${setting}-container`);
					if ($container.data('format') == format) {
						// Nothing to do
						return;
					}

					const $products = $(`.js-products-${setting}-product`);

					// From grid to slider
					if (toSlider) {
						// Wrap everything inside a swiper container
						$products.wrapAll(`<div class="col-12 p-0"><div class="js-swiper-${setting} swiper-container p-md-1"><div class="swiper-wrapper"></div></div></div>`)

						// Wrap each product into a slide
						$products.wrap(`<div class="swiper-slide ${useRoundedCorners() ? 'p-3' : ''}"></div>`);
						$products.removeClass($products.data('grid-classes'));

						// Add previous and next controls
						$container.append(`
							<div class="js-swiper-${setting}-prev swiper-button-prev d-none d-md-block svg-circle svg-circle-big svg-icon-text ${useSolidIcons() ? 'svg-solid' : ''}">
								<svg class="icon-inline icon-2x mr-1 icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
							</div>
							<div class="js-swiper-${setting}-next swiper-button-next d-none d-md-block svg-circle svg-circle-big svg-icon-text ${useSolidIcons() ? 'svg-solid' : ''}">
								<svg class="icon-inline icon-2x ml-1"><use xlink:href="#chevron"/></svg>
							</div>
						`);

						// Initialize swiper
						window.swiperLoader(`.js-swiper-${setting}`, {
							watchOverflow: true,
							centerInsufficientSlides: true,
							threshold: 5,
							watchSlideProgress: true,
							watchSlidesVisibility: true,
							slideVisibleClass: 'js-swiper-slide-visible',
							loop: $products.length > 3,
							navigation: {
								nextEl: `.js-swiper-${setting}-next`,
								prevEl: `.js-swiper-${setting}-prev`
							},
							slidesPerView: 1.5,
							breakpoints: {
								768: {
									slidesPerView: $container.data('desktop-columns'),
								}
							}
						});

					// From slider to grid
					} else {
						// Remove duplicate slides and slider controls
						$container.find('.swiper-slide-duplicate').remove()
						$container.find(`.js-swiper-${setting}-prev`).remove()
						$container.find(`.js-swiper-${setting}-next`).remove()

						// Undo all slider wrappers and restore original classes
						$products
							.unwrap()
							.unwrap()
							.unwrap()
							.unwrap()
							.addClass($products.data('grid-classes'));
					}

					// Persist new format in data attribute
					$container.data('format', format);
				});
			});


			// ----------------------------------- Welcome Message -----------------------------------

			// Update welcome message title
			handlers.welcome_message = new instaElements.Text({
				element: '.js-welcome-message-title',
			});

			// Update welcome message subtitle
			handlers.welcome_text = new instaElements.Text({
				element: '.js-welcome-message-text',
			});

			// ----------------------------------- Institutional Message -----------------------------------

			// Update institutional message title
			handlers.institutional_message = new instaElements.Text({
				element: '.js-institutional-message-title',
				show: function(){
					$(this).show();
				},
				hide: function(){
					$(this).hide();
				},
			});

			// Update institutional message subtitle
			handlers.institutional_text = new instaElements.Text({
				element: '.js-institutional-message-text',
				show: function(){
					$(this).show();
				},
				hide: function(){
					$(this).hide();
				},
			});

			// ----------------------------------- Newsletter -----------------------------------

			// Toggle newsletter visibility
			handlers.news_show = new instaElements.Lambda(function (isVisible) {
				const $container = $('.js-home-newsletter');

				if (isVisible) {
					$container.show();
				} else {
					$container.hide();
				}
			});

			// Update title and text for newsletter form
			['title', 'text'].forEach(setting => {
				handlers[`news_${setting}`] = new instaElements.Text({
					element: `.js-home-newstetter-${setting}`
				});
			});

			// ----------------------------------- Video -----------------------------------

			// Update video thumbnail and iframe
			handlers.video_embed = new instaElements.Lambda(function(videoUrl){
				const $container = $('.js-home-video');

				// Generate new html
				$container.html(`
					<div class="js-video embed-responsive embed-responsive-16by9 ${useRoundedCorners() ? 'box-rounded' : ''}">
						<a href="#" class="js-play-button video-player">
							<div class="video-player-icon">
								<svg class="icon-inline icon-xs svg-icon-invert icon-lg ml-2"><use xlink:href="#play"/></svg>
							</div>
							<div class="js-video-image">
								<img src="" class="video-image">
								<div class="placeholder-fade"></div>
							</div>
						</a>
					</div>

					<div class="js-video-iframe embed-responsive embed-responsive-16by9 ${useRoundedCorners() ? 'box-rounded' : ''}" style="display: none" data-video-color="${$container.data('video-color')}"></div>
				`);

				LS.loadVideo(videoUrl);

				// The loadVideo function sets the data-src attribute for lazy loading, copy that value to src
				const $thumbnail = $container.find('.js-video-image img');
				$thumbnail.attr('src', $thumbnail.data('src'));
				$thumbnail.css('z-index', -1);

				// Show container for both video and text and signal thumbnail readiness to placeholder
				$container.closest('.js-home-video-container').data('thumbnail-ready', true).show();
			});

			// Toggle full-width for video
			handlers.video_full = new instaElements.Lambda(function(isFullwidth){
				const $container = $('.js-home-video-container');
				if (isFullwidth) {
					$container.removeClass('container').addClass('container-fluid p-0');
				} else {
					$container.removeClass('container-fluid p-0').addClass('container');
				}
			});

			// Update title and description for video
			['title', 'text'].forEach(setting => {
				handlers[`video_${setting}`] = new instaElements.Text({
					element: `.js-home-video-${setting}`,
					show: function(){
						$(this).show();
					},
					hide: function(){
						$(this).hide();
					},
				});
			});


			// ----------------------------------- Instagram Feed -----------------------------------

			// Toggle feed visibility
			handlers.show_instafeed = new instaElements.Lambda(function (isVisible) {
				const $container = $('.js-instagram-feed');

				if (isVisible) {
					$container.show();
				} else {
					$container.hide();
				}
			});


			// ----------------------------------- Helper Functions -----------------------------------

			function useRoundedCorners(){
				return $('body').data('rounded-borders');
			}

			function useSolidIcons(){
				return $('body').data('solid-icons');
			}

			return handlers;
		}
	};
})(jQueryNuvem, LS.country);