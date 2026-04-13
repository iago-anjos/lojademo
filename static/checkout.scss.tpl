{% if store.allows_checkout_styling %}

{#/*============================================================================
checkout.scss.tpl

    -This file contains all the theme styles related to the checkout based on settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
        -static/css/style-async.scss.tpl --> For non critical styles witch will be loaded asynchronously
        -static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{#/*============================================================================
  Global
==============================================================================*/#}

{# /* // Colors */ #}

$accent-brand-color: {{ settings.primary_color | default('rgb(77, 190, 207)' | raw ) }};
$foreground-color: {{ settings.text_color | default('rgb(102, 102, 102)' | raw ) }};
$background-color: {{ settings.background_color | default('rgb(252, 252, 252)' | raw ) }};

{# /* // Font */ #}

$heading-font: {{ settings.font_headings | default('Muli') | raw }};
$body-font: {{ settings.font_rest | default('Muli') | raw }};

{# /* // Box */ #}
$box-border-color: rgba($foreground-color, .3);

$box-radius: 10px;
$box-background: lighten($background-color, 10%);
$box-shadow: none;
$form-control-radius: 6px;

{# /* // Functions */ #}

@function set-background-color($background-color) {
  @if lightness($background-color) > 95% {
    @return lighten($background-color, 10%);
  } @else {
    @return desaturate(lighten($background-color, 7%), 5%);
  }
}

@function set-input-color($background-color, $foreground-color) {
  @if lightness($background-color) > 70% {
    @return desaturate(lighten($foreground-color, 5%), 80%);
  } @else {
    @return desaturate(lighten($background-color, 5%), 80%);
  }
}

{# /* // Mixins */ #}

@mixin prefix($property, $value, $prefixes: ()) {
	@each $prefix in $prefixes {
    	#{'-' + $prefix + '-' + $property}: $value;
	}
   	#{$property}: $value;
}

{#/*============================================================================
  React
==============================================================================*/#}

{# /* // Box */ #}

$box-background: lighten($background-color, 10%);
$box-text-shadow: null;
@if lightness($foreground-color) > 95% {
  $box-text-shadow: 0 2px 1px rgba(darken($foreground-color, 80%), 0.1);
} @else {
  $box-text-shadow: 0 2px 1px rgba(lighten($foreground-color, 80%), 0.1);
}

$base-red: #c13a3a;

$xs: 0;
$sm: 576px;
$md: 768px;
$lg: 992px;
$xl: 1200px;

{#/*============================================================================
  # Checkout tokens
==============================================================================*/#}
:root {

  {#### Color tokens #}

  {% set accent_color = settings.primary_color %}
  {% set main_foreground = settings.text_color %}
  {% set main_background = settings.background_color %}

  {# Auxiliar opacity hex levels #}
  {% set opacity_05 = '0D' %}
  {% set opacity_10 = '1A' %}
  {% set opacity_20 = '33' %}
  {% set opacity_30 = '4D' %}
  {% set opacity_50 = '80' %}
  {% set opacity_60 = '99' %}
  {% set opacity_80 = 'CC' %}

  {# Accent color #}
  --accent-color: {{ accent_color }};
  --accent-color-opacity-05: {{ accent_color }}{{ opacity_05 }};
  --accent-color-opacity-10: {{ accent_color }}{{ opacity_10 }};
  --accent-color-opacity-20: {{ accent_color }}{{ opacity_20 }};
  --accent-color-opacity-30: {{ accent_color }}{{ opacity_30 }};
  --accent-color-opacity-50: {{ accent_color }}{{ opacity_50 }};
  --accent-color-opacity-60: {{ accent_color }}{{ opacity_60 }};
  --accent-color-opacity-80: {{ accent_color }}{{ opacity_80 }};

  {# Foreground color #}
  --main-foreground: {{ main_foreground }};
  --main-foreground-opacity-05: {{ main_foreground }}{{ opacity_05 }};
  --main-foreground-opacity-10: {{ main_foreground }}{{ opacity_10 }};
  --main-foreground-opacity-20: {{ main_foreground }}{{ opacity_20 }};
  --main-foreground-opacity-30: {{ main_foreground }}{{ opacity_30 }};
  --main-foreground-opacity-50: {{ main_foreground }}{{ opacity_50 }};
  --main-foreground-opacity-60: {{ main_foreground }}{{ opacity_60 }};
  --main-foreground-opacity-80: {{ main_foreground }}{{ opacity_80 }};

  {# Background color #}
  --main-background: {{ main_background }};
  --main-background-opacity-05: {{ main_background }}{{ opacity_05 }};
  --main-background-opacity-10: {{ main_background }}{{ opacity_10 }};
  --main-background-opacity-20: {{ main_background }}{{ opacity_20 }};
  --main-background-opacity-30: {{ main_background }}{{ opacity_30 }};
  --main-background-opacity-50: {{ main_background }}{{ opacity_50 }};
  --main-background-opacity-60: {{ main_background }}{{ opacity_60 }};
  --main-background-opacity-80: {{ main_background }}{{ opacity_80 }};

  {#### Component tokens #}

  {# General #}
  --border-radius: 10px;
  --box-border-radius: var(--border-radius);
  --border-color: var(--main-foreground-opacity-10);

  {# Buttons #}
  --button-foreground: var(--main-background);
  --button-background: var(--accent-color);
  --button-border-color: var(--accent-color);
  --button-border-radius: 40px;

  {# Labels #}
  --label-foreground: var(--main-background);
  --label-background: var(--accent-color);

  {# Header #}
  --header-foreground: {{ settings.head_background == 'light' ? 'var(--main-foreground)' : 'var(--main-background)' }};
  --header-background: {{
    settings.head_background == 'light' ? 'var(--main-background)' :
    settings.head_background == 'dark' ? 'var(--main-foreground)' :
    'var(--accent-color)'
  }};
  --header-logo-max-width: 100%;
  --header-logo-max-height: 80px;

  {# Footer #}
  --footer-foreground: {{ settings.footer_colors ? settings.footer_foreground_color : 'var(--accent-color)' }};
  --footer-background: {{ settings.footer_colors ? settings.footer_background_color : 'var(--main-foreground-opacity-10)' }};

  {#### Typography #}

  {# Headings #}
  --heading-font: {{ settings.font_headings | default('Muli') | raw }};
  --heading-font-weight: bold;
  --heading-text-transform: none;
  --heading-letter-spacing: normal;

  {# Header #}
  --header-logo-font: var(--heading-font);
  --header-logo-font-size: 20px;
  --header-logo-font-weight: 700;
  --header-logo-text-transform: none;
  --header-logo-letter-spacing: normal;
}

body {
  font-family: $body-font;
  color: $foreground-color;
  background-color: $background-color;
}
a {
  color: $accent-brand-color;
  text-decoration: none;
  &:hover, &:focus {
    color: darken($accent-brand-color, 20%);
    
    svg {
      fill: darken($accent-brand-color, 20%);
    }
  }

  svg {
    fill: $accent-brand-color;
  }
}

{# /* // Text */ #}

.title {
  color: $foreground-color;
}

{# /* // Header */ #}

.header { 
  background-color: lighten($background-color, 10%);
  border-color: $accent-brand-color;
}

.security-seal {
  color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
}

{# /* // Headbar */ #}

.headbar {
  background: {% if settings.head_background == 'light' %}$background-color{% elseif settings.head_background == 'dark' %}$foreground-color{% else %}$accent-brand-color{% endif %};
  {% if settings.head_background == 'light' %}
    border-bottom: 1px solid rgba($accent-brand-color, .2);
  {% endif %}
  box-shadow: none;

  .container {
    max-width: 100%;
    width: 100%;

    .row {
      -ms-flex-align: center;
      align-items: center;

    }
  }
}

.headbar-logo-img {
  max-width: 100%;
  max-height: 80px;
}

.headbar-logo-text {
  float: none;
  color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
  font-weight: 700;

  &:hover {
    color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
    opacity: .8;
  }

  &:focus {
    color: $background-color;
  }
}

.headbar-continue {
  margin: 0 !important;
  font-weight: 400;
  color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
  &:hover,
  &:focus {
    color: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
    opacity: .8;

    .headbar-continue-icon {
      fill: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
    }
  }
  &-icon {
    margin-left: 5px;
    fill: {% if settings.head_background == 'light' %}$foreground-color{% else %}$background-color{% endif %};
  }
}

{# /* // Form */ #}

.form-control {
  background: $background-color;
  border-color: $box-border-color;
  color: $foreground-color;
  font-family: $body-font;
  border-radius: $box-radius;

  &:focus {
    border-color: $accent-brand-color;
    outline: none;    
  }
}
.form-options-content {
  font-size: 12px;
  line-height: 20px;
  color: rgba($foreground-color, .6);
  border: 0;
}
.form-group input[type="radio"] + .form-options-content .unchecked {
  fill: darken($background-color, 10%);
}
.form-group input[type="radio"] + .form-options-content .checked {
  fill: $accent-brand-color;
}
.form-group input[type="radio"]:checked + .form-options-content {
  border: 1px solid $accent-brand-color;
  border-color: darken($background-color, 10%);
  
  + .form-options-accordion {
    border-color: darken($background-color, 10%);
  }
  
  .checked {
    fill: $accent-brand-color;
  }
}
.form-group input[type="checkbox"]:checked + .form-options-content .checked {
  fill: $foreground-color;
}
.form-group input[disabled] + .form-options-content {
  border-color: darken($background-color, 10%) !important;
  
  .form-options-label {
    color: $foreground-color !important;
  }
  .checked {
    fill: $foreground-color !important;
  }
}
.form-group input[type="checkbox"] + .form-options-content .unchecked {
  width: 13px;
  fill: $foreground-color;
}

{# /* // Input */ #}

.has-float-label>span,
.has-float-label label {
  padding: 1px 0 0 7px;
  font-weight: 400;
}

.input-label {
  color: $foreground-color;
}

.select-icon {
  fill: $foreground-color;
}

{# /* // Buttons */ #}

.btn-primary {
  color: $background-color;
  background: $accent-brand-color;
  border-radius: 40px;

  &:hover,
  &:focus,
  &:active {
    color: $background-color;
    background: $accent-brand-color;
    opacity: 0.9;
  }
}
.btn-secondary {
  color: $accent-brand-color;
  text-transform: uppercase;
  font-weight: bold;
  letter-spacing: 1px;
  border-color: $accent-brand-color;
  border-radius: 40px;
  background: $background-color;

  &:hover,
  &:focus,
  &:active,
  &:active:focus {
    background: $background-color;
    color: lighten($accent-brand-color, 15%);
    border-color: lighten($accent-brand-color, 15%);

    .btn-icon-right {
      fill: lighten($accent-brand-color, 15%);
    }
  }
  .btn-icon-right {
    fill: $accent-brand-color;
  }
}
.btn-transparent {
  color: $accent-brand-color;
  font-weight: 700;

  &:hover {
    color: $accent-brand-color;
    
    .btn-icon-right {
      fill: $accent-brand-color;
    }
  }

  .btn-icon-right {
    fill: $accent-brand-color;
  }
}

.btn-link {
  color: $accent-brand-color;
  text-decoration: none;

  &:hover {
    color: darken($accent-brand-color, 10%);

    svg {
      fill: darken($accent-brand-color, 10%);
    }
  }
}

.btn-picker {
  border-color: $box-border-color;
  border-radius: $box-radius;
}

.login-info {
  margin: 10px 0 0;
  font-size: 12px;
  text-align: left;
}

{# /* // Breadcrumb */ #}

.breadcrumb li .breadcrumb-step {
  margin: 0;
  font-size: 12px;
  color: rgba($foreground-color, .6);
  background: none;
  text-transform: none;

  &.active {
    color: $foreground-color;
    background: none;

    &:before,
    &:after {
      position: relative;
      margin: 0 10px;
      border: 0;
      content: ">";
      opacity: .6;
    }
  }

  &.visited {
    color: rgba($foreground-color, .6);
    background: none;
  }
}
.breadcrumb li:first-child .breadcrumb-step,
.breadcrumb li:last-child .breadcrumb-step {
  padding: 0;
}

{# /* // Accordion */ #}

.accordion {
  color: $foreground-color;
  background-color: $background-color;
  border-radius: $box-radius;
  box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
  border-color: rgba($foreground-color, .15); 
}

.accordion-section-header-icon {
  fill: $foreground-color;
}

.accordion-rotate-icon {
  fill: $foreground-color;
}

{# /* // Summary */ #}

.mobile-discount-coupon_btn {
  border-radius: $box-radius;
  border-color: darken($background-color, 10%);
  color: lighten($foreground-color, 20%);
  
  .icon {
    color: lighten($foreground-color, 20%);
  }
}
.summary .overlay + .summary-container {
  border: 0;
}
.summary-details {
  background: lighten($background-color, 15%);
}
.summary-container {
  background: $background-color;
  border-bottom: 1px solid rgba($foreground-color, .1);
  box-shadow: none;
}
.summary-total {
  font-size: 16px;
  font-weight: 700;
  color: $accent-brand-color;
  background: $background-color;
}
.summary-img-thumb {
  border-radius: 0;
}
.summary-arrow-rounded {
  background: none;
  border: 1px solid $accent-brand-color;
  .summary-arrow-icon {
    fill: $accent-brand-color;
  }
}

.summary-title {
  color: darken($accent-brand-color, 10%);
}

{# /* // Radio */ #}

.radio-group {
  border-radius: $box-radius;

  &.radio-group-accordion {
    border-color: rgba($foreground-color, .15);
    box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
    overflow: hidden;

    .radio {
      border-color: rgba($foreground-color, .15);
      &.active {
        color: $background-color;
        background: $accent-brand-color;
        padding-bottom: 25px;
        margin-bottom: -10px;
        .description {
          color: $background-color;
        }
        & + .radio-content {
          border: 2px solid $accent-brand-color;
          border-top-right-radius: 10px;
          border-top-left-radius: 10px;
        }
        .payment-item-discount {
          color: $background-color;
        }
      }
      .label {
        font-weight: 700;
      }
      .description {
        width: calc(100% - 35px);
        margin-left: 35px;
        font-weight: 400;
      }
      &-content:last-child {
        border-radius: 0 0 $box-radius $box-radius;
      }
    }
  }
}

.radio input:checked + .selector:before {
  background: $background-color;
  border-color: $background-color;
}
.radio input:checked + .selector:after {
  position: absolute;
  top: 4px;
  left: 4px;
  width: 12px;
  content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%23{{ settings.primary_color |trim('#') }}"><path d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"/></svg>');
}
.radio input:disabled:checked + .selector:before {
  background-image: radial-gradient(circle, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.5) 50%, transparent 50%, transparent 100%);
}
.radio .selector {
  position: relative;

  &:before {
    width: 20px;
    height: 20px;
    margin: 1px 15px 0 0;
    border-color: rgba($foreground-color, 0.5);
  }
}

.radio-content {
  background: $background-color;
  border: 0;
  box-shadow: none;
}

.shipping-option {
  position: relative;
  margin-bottom: -1px;
  padding-left: 55px;
  background: $background-color;
  border-radius: 0;
  border-color: rgba($foreground-color, .15);

  &:first-child {
    border-radius: $box-radius $box-radius 0 0;
  }
  &:last-child {
    border-radius: 0 0 $box-radius $box-radius;
  }
  &:only-child {
    border-radius: $box-radius;
  }
  &.active {
    margin-bottom: 0;
    border: 2px solid $accent-brand-color;
    border-left-width: 0;

    .selector {
      background: $accent-brand-color;
    }
  }

  .selector {
    position: absolute;
    top: 0;
    left: 0;
    width: 45px;
    height: 100%;
    margin: 0;
    text-align: center;
    &:before {
      margin: 15px 0 0 0;
    }
  }

  input:checked + .selector:after {
    top: 17px;
    left: 16px;
  }
}

{# /* // Panel */ #}

.panel {
  padding: 0;
  color: $foreground-color;
  background-color: $background-color;
  border-radius: $box-radius;
  box-shadow: $box-shadow;
  border: 0;
  &.panel-with-header {
    padding-top: 0;
    p {
      margin-top: 0;
    }
  }
  &.summary-details {
    border: 1px solid rgba($foreground-color, .1);
    box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
  }
  &.text-center {
    text-align: left !important;
  }
  .panel-subheader:before {
    display: inline-block;
    width: 18px;
    margin: 0 14px 0 1px;
    vertical-align: middle;
    {% if settings.icons_solid %}
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 29 32.49" fill="%23{{ settings.text_color |trim('#') }}"><path d="M26.5,32.49H2.5A2.5,2.5,0,0,1,0,30C0,23.8,6.5,18.76,14.5,18.76S29,23.8,29,30A2.5,2.5,0,0,1,26.5,32.49Zm-20.67-5H23.17c-1.5-2.17-4.87-3.73-8.67-3.73S7.33,25.32,5.83,27.49ZM14.5,5a4,4,0,1,1-4,4,4,4,0,0,1,4-4m0-5a9,9,0,1,0,9,9,9,9,0,0,0-9-9Z"/></svg>');
    {% else %}
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" fill="%23{{ settings.text_color |trim('#') }}"><path d="M15,17.41A8.33,8.33,0,1,0,6.68,9.08,8.33,8.33,0,0,0,15,17.41Zm0-14A5.55,5.55,0,1,1,9.45,9,5.56,5.56,0,0,1,15,3.44Zm0,14.62C7.1,18.06.66,22.5.66,28a1.36,1.36,0,0,0,1.39,1.39A1.36,1.36,0,0,0,3.44,28c0-3.86,5.29-7.12,11.56-7.12S26.56,24.09,26.56,28a1.39,1.39,0,0,0,2.78,0C29.34,22.5,22.9,18.06,15,18.06Z"/></svg>');
    {% endif %}
  }
  .panel-submodule:last-child .panel-subheader:before,
  .shipping-options .panel-subheader:before {
    {% if settings.icons_solid %}
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" fill="%23{{ settings.text_color |trim('#') }}"><path d="M172.268 501.67C26.97 291.031 0 269.413 0 192 0 85.961 85.961 0 192 0s192 85.961 192 192c0 77.413-26.97 99.031-172.268 309.67-9.535 13.774-29.93 13.773-39.464 0zM192 272c44.183 0 80-35.817 80-80s-35.817-80-80-80-80 35.817-80 80 35.817 80 80 80z"/></svg>');
    {% else %}
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" fill="%23{{ settings.text_color |trim('#') }}"><path d="M192 96c-52.935 0-96 43.065-96 96s43.065 96 96 96 96-43.065 96-96-43.065-96-96-96zm0 160c-35.29 0-64-28.71-64-64s28.71-64 64-64 64 28.71 64 64-28.71 64-64 64zm0-256C85.961 0 0 85.961 0 192c0 77.413 26.97 99.031 172.268 309.67 9.534 13.772 29.929 13.774 39.465 0C357.03 291.031 384 269.413 384 192 384 85.961 298.039 0 192 0zm0 473.931C52.705 272.488 32 256.494 32 192c0-42.738 16.643-82.917 46.863-113.137S149.262 32 192 32s82.917 16.643 113.137 46.863S352 149.262 352 192c0 64.49-20.692 80.47-160 281.931z"/></svg>');
    {% endif %}
  }

  .new-shipping-flow .panel-subheader-ship:before {
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" fill="%23{{ settings.text_color |trim('#') }}"><path d="M226.8 94.6H0V63.8h242.2c8.5 0 15.4 6.9 15.4 15.4v41.6h70.1c4.7 0 9.1 2.1 12 5.8l57 71.2c2.2 2.7 3.4 6.1 3.4 9.6v85.5c0 8.5-6.9 15.4-15.4 15.4h-30.1c-6.2 16.6-22.3 28.5-41.1 28.5-24.2 0-43.9-19.6-43.9-43.9 0-24.2 19.6-43.9 43.9-43.9 18.8 0 34.9 11.8 41.1 28.5h14.7v-64.7l-49-61.2h-62.7v141.3c0 8.5-6.9 15.4-15.4 15.4h-85.5v-30.8h70.1V94.6zm-70.1 56.9H28.5v-30.8h128.2v30.8zm-28.5 57H0v-30.8h128.2v30.8zm-42.7 71.2c-7.2 0-13.1 5.9-13.1 13.1 0 7.2 5.9 13.1 13.1 13.1 7.2 0 13.1-5.9 13.1-13.1 0-7.2-5.9-13.1-13.1-13.1zm-43.9 13.2c0-24.2 19.6-43.9 43.9-43.9s43.9 19.6 43.9 43.9c0 24.2-19.6 43.9-43.9 43.9s-43.9-19.7-43.9-43.9zm271.8-13.2c-7.2 0-13.1 5.9-13.1 13.1 0 7.2 5.9 13.1 13.1 13.1 7.2 0 13.1-5.9 13.1-13.1 0-7.2-5.9-13.1-13.1-13.1z"/></svg>');
  }
  .new-shipping-flow .panel-subheader-pickup:before {
    content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" fill="%23{{ settings.text_color |trim('#') }}"><path d="M198.3 0c-82.5 0-150 67.5-150 150 0 60 20 77.5 135 242.5 3.8 5 9.4 7.5 15 7.5s11.3-2.5 15-7.5c115-165 135-182.5 135-242.5 0-82.5-67.5-150-150-150zm0 348.5c-11.3-16.1-21.5-30.6-30.8-43.7C93.9 200.4 85.8 187.7 85.8 150c0-62 50.5-112.5 112.5-112.5S310.8 88 310.8 150c0 37.7-8.1 50.4-81.7 154.8-9.3 13.1-19.5 27.6-30.8 43.7z"/></svg>');
  }

  .shipping-address-container .panel-subheader:before {
    display: none;
  }
}
.panel-header {
  margin: 0;
  font-size: 34px;
  font-weight: bold;
  color: $foreground-color;
  text-align: left;
  border: 0;
  text-shadow: none;
}
.panel-header-tooltip {
  padding: 0 5px;
}
.panel-header-sticky {
  background-color: $background-color;
}
.panel-header-button {
  position: absolute;
  top: 9px;
  right: 0;
  z-index: 2;
  width: auto;
}
.panel-footer {
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
  background: darken($background-color, 2%);
  &-wa {
    border-color: darken($background-color, 5%);
  }
}
.panel-footer-form {
  input {
    border-color: $foreground-color;
  }
  .input-group-addon {
    background: $background-color;
    border-color: $foreground-color;
  }
  .disabled {
    background: darken($background-color, 15%) !important;
  }
}

{# /* // Table */ #}

.table-footer {
  font-size: 22px;
  font-weight: 700;
  color: $accent-brand-color;
  border: 0;
  .text-semi-bold {
    font-weight: 700;
  }
}

.table-subtotal {
  padding-top: 10px;
  border-color: rgba($foreground-color, .15);
}

.table .table-discount-coupon,
.table .table-discount-promotion {
  color: $accent-brand-color;
  border: 0;
}

{# /* // Shipping Options */ #}

.shipping-options {
  color: lighten($foreground-color, 7%);

  .radio-group {
    border-radius: $box-radius;
    box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
    overflow: hidden;
  }

  .btn {
    margin: 0;
    background: $background-color;
    border: 1px solid rgba($foreground-color, .1);
    border-radius: 0 0 $box-radius $box-radius;
    border-top: 0;
  }
}

.shipping-options-ship, 
.shipping-options-pickup {
  border-radius: $box-radius;
  box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
  overflow: hidden;
}

.new-shipping-flow .shipping-options .radio-group {
  box-shadow: none;
  overflow: inherit;
}

.new-shipping-flow .shipping-options .btn {
  margin-top: -10px;
  padding-top: 20px;
  border: 0;
}

.shipping-method-item > span {
  width: 100%;
}

.shipping-method-item-desc,
.shipping-method-item-name {
  max-width: 70%;
  color: desaturate(lighten($foreground-color, 10%), 80%)
}

.shipping-method-item-price {
  float: right;
  font-size: 16px;
  color: $accent-brand-color;
}

.price-striked {
  display: block;
  margin: 5px 0 0 !important;
  font-size: 14px;
  color: rgba($foreground-color, .6);
}

{# /* // Discount Coupon */ #}

.box-discount-coupon button {
  @if lightness($foreground-color) < 90% {
    color: lighten($foreground-color, 80%);
  } @else {
    color: $foreground-color;
  }
  background: $accent-brand-color;

  &:hover {
    background: lighten($accent-brand-color, 15%) radial-gradient(circle,transparent 1%, lighten($accent-brand-color, 15%) 1%) center/15000%;
  }
}
.box-discount-coupon-applied {
  color: $accent-brand-color;
  background: none;
  border: 1px solid $accent-brand-color !important;
  border-radius: 40px;

  .coupon-icon {
    fill: $accent-brand-color;
  }
}

{# /* // Order Status */ #}

.orderstatus {
  border: 1px solid rgba($foreground-color, .1);
  box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
}

{# /* // Support */ #}

.support .btn-secondary {
  border-radius: 40px;
  letter-spacing: 0;
}

{# /* // Destination */ #}

.destination {
  border-color: rgba($foreground-color, 0.1);
  &-icon svg {
    fill: $accent-brand-color;
  }
}


{# /* // User Detail */ #}

.user-detail-icon svg {
  fill: $accent-brand-color;
}

{# /* // History */ #}

.history-item-done .history-item-title {
  color: $foreground-color;
}
.history-item-failure .history-item-title {
  color: $base-red;
}
.history-item-progress-icon svg {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);  
  } @else {
    fill: $background-color;
  }
}
.history-item-progress-icon:after {
  @if lightness($background-color) > 50% {
    fill: darken($background-color, 10%);
    border-color: darken($background-color, 10%);
  } @else {
    fill: $background-color;
    border-color: $background-color;
  }
}
.history-item-progress-icon-failure svg {
  fill: $base-red;
}
.history-item-progress-icon-success svg {
  fill: $accent-brand-color;
}
.history-item-progress-icon-success:after {
  border-color: $accent-brand-color;
}

{# /* // History Canceled */ #}

.history-canceled {
  border-top-right-radius: $box-radius;
  border-top-left-radius: $box-radius;
  
  &-round {
    border-bottom-right-radius: $box-radius;
    border-bottom-left-radius: $box-radius;
  }
}
.history-canceled-header {
  border-color: rgba($box-border-color, 0.7);
  border-top-left-radius: $box-radius;
  border-top-right-radius: $box-radius;
}
.history-canceled-icon svg {
  fill: darken($background-color, 45%);
}

{# /* // Offline Payment */ #}

.ticket-coupon {
  background: darken($background-color, 4%);
  border-color: $box-border-color;
}

{# /* // Status */ #}

.status {
  border: 1px solid rgba($foreground-color, .1); 
  box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04);
  padding: 25px 0;
  &-icon svg {
    fill: $accent-brand-color;
  }
}

{# /* // Tracking */ #}

.tracking-item-time {
  color: $foreground-color;
}

{# /* // WhatsApp Opt-in */ #}

.whatsapp-form input, 
.whatsapp-form .input-group-addon {
  border-color: $accent-brand-color;
}

{# /* // Helpers */ #}

.border-top {
  border-color: rgba($box-border-color, .4);
}

{# /* // Errors */ #}

.alert-danger-bagged {
  margin-top: -7px;
  padding-top: 10px;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
  float: left;
}

.general-error {
  background: $base-red;
  border-color: lighten($base-red, 10%);
}

{# /* // Badge */ #}

.badge {
  border: 0;
}

{# /* // Payment */ #}

.payment-item-discount {
  color: $accent-brand-color;
}

.payment-option {
  border-radius: $box-radius;
  color: $foreground-color;
  background-color: $background-color;
  border-color: rgba($foreground-color, .15);
  box-shadow: 0 1px 3px -1px rgba($foreground-color, 0.05);
}

.radio-content.payment-option-content {
  background: darken($background-color, 2%);
  border: 1px solid rgba($foreground-color, .15);
  border-top: 0;
  border-bottom-right-radius: $box-radius;
  border-bottom-left-radius: $box-radius;
}


{# /* // Overlay */ #}

.overlay {
  background: rgba(darken($background-color, 10%), 0.6);
}
.overlay-title {
  color: rgba($foreground-color, .7);
}

{# /* // List Picker */ #}

.list-picker .unchecked {
  fill: $foreground-color;
}
.list-picker li {
  border-color: $box-border-color;
  background: lighten($background-color, 10%);

  &:hover {
    color: $accent-brand-color;
  }

  &.active {
    background: $background-color;
    color: $accent-brand-color;

    .checked {
      fill: $accent-brand-color;
    }
  }
}

.list-picker-content {
  background: lighten($background-color, 10%);
  border-color: $box-border-color;
}

{# /* // Loading */ #}

.loading {
  background: rgba(darken($background-color, 2%), 0.5);
  color: $accent-brand-color;
}
.loading-spinner {
  color: $accent-brand-color;
}
.loading-skeleton-radio {
  margin: 0 0 -1px 0;
  border-color: rgba($foreground-color, .15);
  border-radius: 0;
  &:first-child {
    border-radius: $box-radius $box-radius 0 0;
  }
  &:last-child {
    border-radius: 0 0 $box-radius $box-radius;
  }
  &:not(:first-child) {
    border-top: 0;
  }
}

{# /* // Spinner */ #}

.round-spinner {
  border-color: $accent-brand-color;
  border-left-color: darken($accent-brand-color, 5%);
  
  &:after {
    border-color: $accent-brand-color;
    border-left-color: darken($accent-brand-color, 5%);
  }
}

.spinner > .spinner-elem {
  background: $accent-brand-color;
}

.spinner-inverted > .spinner-elem {
  background: $background-color;
}

{# /* // Sign Up */ #}

.signup {
  border: 1px solid rgba($foreground-color, .1); 
  box-shadow: 0 1px 3px -1px rgba($foreground-color,0.04); 
  padding: 25px 0;
  &-icon svg {
    fill: $accent-brand-color;
  }
}

{# /* // Modal */ #}

.modal-dialog,
.modal .modal-dialog {
  background: $background-color;
}

{# /* // List */ #}

.list-group-item {
  border-color: rgba($foreground-color, .15);
}

{# /* // Announcement */ #}

.announcement {
  color: darken($accent-brand-color, 10%);

  &-bg {
    background: $accent-brand-color;
    box-shadow: 0px 3px 5px -1px rgba(darken($accent-brand-color, 20%), 0.35);
    border-radius: $box-radius;
  }

  &-close {
    color: $accent-brand-color;
  }
}

{# /* // Alert */ #}

.alert-info {
  background-color: rgba($accent-brand-color, .15);
  border-color: rgba($accent-brand-color, .2);
  color: desaturate(darken($accent-brand-color, 10%), 30%);

  .alert-icon {
    fill: desaturate(darken($accent-brand-color, 10%), 20%);
  }
}

{# /* // Chip */ #}

.chip {
  background-color: rgba($accent-brand-color, .15);
  color: $accent-brand-color;
  border-radius: 5px;
}

{# /* // Review Block Detailed  */ #}
.price--display__free {
  color: $accent-brand-color;
}

.review-block-detailed-item {
  border-bottom: 1px solid rgba($foreground-color, .15);
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
  &:last-child{
    border-radius: 0 0 10px 10px;
  }
}

.review-block-detailed {
  border: 1px solid rgba($foreground-color, .15);
  border-radius: 10px;
  background-color: $background-color;
}

{# /* // Tooltip */ #}

.tooltip-icon {
  fill: $foreground-color;
}

{# /* // Tabs */ #}

.tabs-wrapper {
  border-top-right-radius: $box-radius;
  border-top-left-radius: $box-radius;
  background: darken($background-color, 5%);
  border-bottom-color: darken($background-color, 10%);
}

.tab-item.active {
  color: $accent-brand-color;
  font-weight: bold;
}

.tab-indicator {
  background-color: $accent-brand-color;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Max width 576px */ #}

@media (max-width: $sm) {

  .headbar .container .row .col {
    text-align: center !important;
    flex-basis: auto;
    &.text-left {
      order: 2;
    }
    &.text-right {
      margin: -12px 0 15px 0;
      background: #aac67b;
    }
  }

  .headbar-logo-text {
    display: inline-block;
    margin: 8px 0;
  }

  .security-seal {
    color: #000000;

    .d-inline-block:first-child {
      position: absolute;
      top: 1px;
      left: 50%;
      margin-left: -13px;
    }
    p {
      display: inline-block;
      &.text-semi-bold {
        margin-right: 50px !important;
      }
    }
    &-badge {
      margin: 0;
    }
  }

  .summary .panel {
    border: 0;
  }

  .panel.summary-details {
    border: 0;
  }

  .panel-header {
    font-size: 22px;
  }

  .panel-subheader {
    font-size: 12px;
  }

  .orderstatus-footer {
    background: $background-color;
  }

}

{# /* // Min width 768px */ #}

@media (min-width: $md) {

  .status,
  .signup {
    padding: 40px 0;
  }

}

{# /* // Max width 0px */ #}

@media (max-width: $xs) {

  .modal-xs {
    background: $background-color;
  }

}

{% endif %}
