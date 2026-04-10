{#/*============================================================================
style.scss.tpl

    -This file contains all the theme styles related to settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        --static/css/style-async.css.tpl --> For non critical styles witch will be loaded asynchronously
        --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{# /*============================================================================
  Table of Contents
  #Colors and fonts
    // Colors
    // Font families
    // SVG Icons
    // Texts
    // Backgrounds 
  #Components
    // Margin and Padding
    // Mixins
    // Animations
    // Wrappers
    // Placeholders
    // Dividers    
    // Breadcrumbs
    // Headings
    // Buttons
    // Links
    // Chips
    // Progress bar 
    // Modals
    // Forms
    // Alerts and Notifications
    // Tooltip
    // Images
    // Tables
    // Tabs
    // Cards
    // Sliders
  #Home page
    // Home banners
    // Informative banners
    // Video
    // Instafeed
    // Featured products
    // Newsletter
    // Brands
  #Product grid
    // Category controls
    // Grid item
    // Labels
  #Product detail
    // Image
    // Form and info
  #Account page
    // Order items
  #Header and nav
    // Topbar
    // Header
    // Utilities
    // Search
    // Nav
  #Footer
    // Copyright
  #Media queries
    // Min width 768px
    //// Components
    //// Product grid

==============================================================================*/ #}

{#/*============================================================================
  #Colors and fonts
==============================================================================*/#}
	
{# /* // Colors */ #}

$primary-color: {{ settings.primary_color }};
$secondary-color: {{ settings.secondary_color }};
$main-foreground: {{ settings.text_color }};
$main-background: {{ settings.background_color }};
{% if settings.footer_colors %}
  $footer-background: {{ settings.footer_background_color }};
  $footer-foreground: {{ settings.footer_foreground_color }};
{% endif %}

{# If store has accent color on it uses the accent color else uses primary color as default fallback #}
{% if settings.accent_color_active %}
  $accent-color: {{ settings.accent_color }};
{% else %}
  $accent-color: {{ settings.primary_color }};
{% endif %}

{# /* // Font families */ #}

$heading-font: {{ settings.font_headings | raw }};
$body-font: {{ settings.font_rest | raw }};

{# /* // SVG Icons */ #}

.svg-icon-primary{
  fill: $primary-color!important;
  &.svg-circle{
    border: 1px solid $primary-color;
  }
}
.svg-icon-text{
  fill: $main-foreground;
  &.svg-circle{
    border: 1px solid $main-foreground;
  }
  &.svg-solid{
    line-height: 42px;
    background: $main-background;
    border: 5px solid $primary-color;
    fill: $primary-color;
  }
}

.svg-icon-accent{
  fill: $accent-color;
}

.svg-icon-invert{
  fill: $main-background;
  &.svg-circle{
    border: 1px solid $main-background;
  }
}

.svg-circle{
  width: 30px;
  height: 30px;
  padding: 5px;
  border-radius: 50%;
  &-big {
    width: 50px;
    height: 50px;
    line-height: 48px;
  }
}

{# /* // Texts */ #}

.text-primary {
  color: $primary-color;
}

.text-secondary {
  color: $main-background;
}

.text-accent,
.cart-installments.installment-no-interest {
  color: $accent-color;
}

.bg-primary{
  background-color: $primary-color!important;
  color: $main-background!important;
  a{
    color: $main-background!important;
  }
}

{# /* // Backgrounds */ #}

.background-main{
  background-color: $main-background;
}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and Padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%element-margin {
  margin-bottom: 20px;
}
%element-margin-half {
  margin-bottom: 10px;
}

{# /* // Mixins */ #}

@mixin text-decoration-none(){
  text-decoration: none;
  outline: 0;
  &:hover,
  &:focus{
    text-decoration: none;
    outline: 0;
  }
}

@mixin no-wrap(){
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-weight: normal;
}

@mixin drop-shadow(){
	-moz-box-shadow: 0 0 3px #ccc;
	-webkit-box-shadow: 0 0 3px #ccc;
	box-shadow: 0 0 3px #ccc;
}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
	@each $prefix in $prefixes {
    	#{'-' + $prefix + '-' + $property}: $value;
	}
   	#{$property}: $value;
}

%border-radius {
  border-radius: 40px;
}

%border-radius-medium {
  border-radius: 20px;
}

%border-radius-small {
  border-radius: 10px;
}

{# /* // Animations */ #}

%simplefade {
  transition: all 0.5s ease;
}

{# /* // Functions */ #}

@function set-foreground-color($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return $foreground-color; // Lighter backgorund, return dark color
  } @else {
    @return lighten($foreground-color, 15%); // Darker background, return light color
  }
}

@function set-subnav-color($nav-color) {
  @if (lightness($nav-color) > 25) {
    @return rgba(0,0,0,0.18); // Lighter backgorund, return dark color
  } @else {
    @return rgba(255,255,255,0.1); // Darker background, return light color
  }
}

@function set-background-color($bg-color) {
  @if (lightness($bg-color) > 30) {
    @return darken($bg-color, 5%); // Lighter primary, return dark color
  } @else {
    @return lighten($bg-color, 5%); // Darker primary, return light color
  }
}

{# /* // Wrappers */ #}

%body-font {
  font-size: 14px;
}

body{
  color: $main-foreground;
  fill: $main-foreground;
  font-family: $body-font;
  background-color:$main-background;
  @extend %body-font;
}

.box{
  float: left;
  width: 100%;
  margin-bottom: 20px;
  padding:8px;
  @include prefix(box-shadow, -2px 3px 7px 3px rgba(0,0,0,0.04), webkit ms moz o);
  @extend %border-radius-small;
  &.box-border {
    padding: 15px;
    border: 1px solid rgba($main-foreground, .1);
    box-shadow: none;
  }
}

.box-rounded {
  @extend %border-radius-medium;
  overflow: hidden;
}

.box-rounded-small {
  @extend %border-radius-small;
  overflow: hidden;
}

{# /* // Placeholders */ #}

.placeholder-container{
  background-color:rgba($primary-color, 0.1);
}
.placeholder-color{
  background-color:rgba($primary-color, 0.2);
}
.placeholder-icon svg{
  fill:rgba($primary-color, 0.2);
}
.placeholder-page{
  background: $primary-color;
  &:hover,
  &.active{
      background: $primary-color;
      opacity: 0.8;
  }
}
.placeholder-shine,
.placeholder-fade{
  background-color:rgba($primary-color, 0.2);
}


.placeholder-overlay {
    background-color:rgba($main-foreground, 0.3);
    opacity: 0;
    &:hover,
    &:active,
    &:focus {
        opacity: 1;
    }
}

.placeholder-info {
  color: $main-background;
  fill: $main-background;
  background-color: $primary-color;
  box-shadow: 0 1px 3px rgba(0,0,0,0.5);
  .placeholder-button {
    color: $primary-color;
    background-color: $main-background;
    opacity: 1;
    &:hover {
      opacity: .8;
    }
  }
}

.spinner-ellipsis {
  .point {
    background-color: rgba($main-foreground, 0.2);
  }
  &.invert .point{
    background-color: $main-background;
  }
}


{# /* // Dividers */ #}

.divider{
  margin-top: 20px;
  margin-bottom: 20px;
  clear: both;
  border-bottom: 1px solid rgba($main-foreground, .1);
}

{# /* // Breadcrumbs */ #}

.breadcrumbs {
  @extend %element-margin-half;
  .divider{
    margin: 3px;
    opacity: 0.6;
  }
  .crumb{
    opacity: 0.6;
    &.active{
      opacity: 1;
    }
  }
}


{# /* Headings */ #}

.page-header {
  @extend %element-margin;
  h1, .h1{
    margin-bottom: 0;
  }
}

.category-header {
  @extend %element-margin;
  h1, .h1{
    margin-bottom: 0;
  }
}

h1,.h1,
h2,.h2,
h3,.h3,
h4,.h4,
h5,.h5,
h6,.h6{
  margin-top: 0;
  font-family: $heading-font;
}

{# /* // Buttons */ #}

.btn{
  text-decoration: none;
  text-align: center;
  border: 0;
  cursor: pointer;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  text-transform: uppercase;
  white-space: normal;
  background: none;
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover,
  &:focus{
    outline: 0;
    opacity: 0.8;
  }
  &[disabled],
  &.disabled,
  &[disabled]:hover,
  &.disabled:hover,{
    opacity: 0.5;
    cursor: not-allowed;
    outline: 0;
  }
  &-default{
    display: block;
    padding: 12px;
    width: 100%;
    border: 1px solid rgba($main-foreground, .3);
    @extend %border-radius-small;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    color: $main-foreground;
    fill: $main-foreground;
    background-color: $main-background;
    @include prefix(transition, all 0.4s ease, webkit ms moz o);
    &:hover{
      border: 1px solid $primary-color;
      svg{
        fill: $primary-color;
      }
    }
  }
  &-primary{
    padding: 13px;
    background-color: $primary-color;
    color: $main-background;
    fill: $main-background;
    @extend %border-radius;
    letter-spacing: 2px;
    @extend %body-font;
    font-weight: bold;
    &:hover{
      color: $main-background;
    }
  }
  &-secondary{
    padding: 13px;
    color: $primary-color;
    border: 1px solid $primary-color;
    @extend %border-radius;
    letter-spacing: 2px;
    @extend %body-font;
    font-weight: bold;
    &:hover{
      color: $primary-color;
    }
    &.invert{
      color: $main-background;
      border: 1px solid $main-background;
      &:hover{
        color: $main-background;
        opacity: 0.8;
      }
    }
    &.btn-circle.chevron:before {
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="{{ settings.primary_color |replace("#","%23") }}"><path d="M17.525 36.465l-7.071 7.07c-4.686 4.686-4.686 12.284 0 16.971L205.947 256 10.454 451.494c-4.686 4.686-4.686 12.284 0 16.971l7.071 7.07c4.686 4.686 12.284 4.686 16.97 0l211.051-211.05c4.686-4.686 4.686-12.284 0-16.971L34.495 36.465c-4.686-4.687-12.284-4.687-16.97 0z"/></svg>');
    } 
  }
  &-block{
    float: left;
    width: 100%;
  }
  &-medium{
    padding: 12px;
    font-size: 12px;
  }
  &-small{
    display: inline-block;
    padding: 10px;
    font-size: 10px;
    letter-spacing: 1px;
  }
  &-extra-small{
    padding: 8px;
    font-size: 8px;
    letter-spacing: 1px;
  }
  &-circle {
    position: relative;
    display: inline-block;
    width: 30px;
    height: 30px;
    font-size: 0;
    vertical-align: bottom;
    border-radius: 50%;
    &.btn-icon:before {
      position: absolute;
      top: 7px;
      left: 11px;
      width: 15px;
      height: 15px;
    }
  }
  &-variant{
    display: inline-block;
    min-width: 30px;
    min-height: 30px;
    margin: 0 5px 10px 0;
    font-size: 14px;
    line-height: 10px;
    border: 1px solid rgba($main-foreground, .8);
    color: rgba($main-foreground, .8);
    border-radius: 6px;
    vertical-align: top;
    text-transform: none;
    &-content{
      display: block;
      min-height: 20px;
      margin: 4px;
      padding: 0 4px;
      line-height: 20px;
      border-radius: 2px;
      &-square {
        position: relative;
        width: 48px;
        height: 48px;
        border-radius: 2px;
        overflow: hidden;
      }
    }
    &.selected {
      color: $main-foreground;
      border: 1px solid $main-foreground;
      background: rgba($main-foreground, .1);
    }
    &-no-stock {
      position: relative;
      background: transparent;
      color: rgba($main-foreground, 0.5);
      border-color: rgba($main-foreground, 0.3);
      overflow: hidden;
      &:after {
        position: absolute;
        top: 0;
        left: 0;
        z-index: 9;
        width: 100%;
        height: 100%;
        background: linear-gradient(to top left,transparent 49%,rgba($main-foreground, 0.5) ,transparent 52%);
        content:'';
      }

      &.selected:after {
        background: linear-gradient(to top left,transparent 49%,$main-foreground ,transparent 52%);
      }

      &.btn-variant-color:after {
        background: linear-gradient(-45deg,rgba($main-background, 0.3) calc(50% - .7px),rgba($main-foreground, 0.5) calc(50% - .7px),rgba($main-foreground, 0.5) 50%,rgba($main-foreground, 0.5) calc(50% + .7px),rgba($main-background, 0.3) calc(50% + .7px));
      }

      &.btn-variant-color.selected:after {
        background: linear-gradient(-45deg,rgba($main-background, 0.3) calc(50% - .7px),$main-foreground calc(50% - .7px),$main-foreground 50%,$main-foreground calc(50% + .7px),rgba($main-background, 0.3) calc(50% + .7px));
      }
    }
  }
  &-facebook{
    color: #1977f2;
    border: 1px solid #1977f2;
    .svg-fb-icon {
      position: relative;
      bottom: 1px;
      height: 16px;
      margin-right: 5px;
      vertical-align: middle;
      fill: #1977f2;
    }
    &:hover {
      background: #1977f2;
      color: #fff;
      .svg-fb-icon {
        fill: #fff;
      }
    }
  }
}

button{
  cursor: pointer;
  &:focus{
    outline: 0;
    opacity: 0.8;
  }
}

{# /* // Links */ #}

a {
  color: $main-foreground;
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover,
  &:focus{
    color: rgba($main-foreground, .5);
  }
}

.link-contrast {
  color: $main-background;
  &:hover,
  &:focus{
    color: rgba($main-background, .8);
  }
}

.btn-link{
  color: $main-foreground;
  fill: $main-foreground;
  cursor: pointer;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  background: none;
  border: none;
  &:hover,
  &:focus{
    color: $primary-color;
    fill: $primary-color;
    svg {
      fill: $primary-color;
    }
  }
  &.toggled{
    color: $primary-color;
  }
  &.invert{
    color: $main-background;
    fill: $main-background;
    &:hover,
    &:focus{
      color: $main-background;
      fill: $main-background;
      opacity: 0.5;
    }
  }
  &-primary{
    color: $primary-color;
    fill: $primary-color;
    font-weight: bold;
    &:hover,
    &:focus{
      color: $primary-color;
      fill: $primary-color;
      opacity: 0.5;
    }
  }
}

{# /* // Chips */ #}

.chip{
  color: $main-foreground;
  background-color: rgba($main-foreground, .08);
  &-remove-icon {
    background-color: $main-background;
    fill: $main-foreground;
  }
}

{# /* // Progress bar */ #}

.bar-progress {
  background: rgba($main-foreground, 0.1);
  &-active {
    background-image: linear-gradient(-90deg, rgba($accent-color, 1), rgba($accent-color, .2));
  }
  &-check {
    background-color: $main-background;
    fill: $accent-color;
  }
}

{# /* // Modals */ #}

.modal{
  color: $main-foreground;
  background-color:$main-background;
  @extend %border-radius-small;
  &-header{
    background-color:$primary-color;
    color: $main-background;
    fill: $main-background;
    border-bottom: 1px solid $main-background;
    @include prefix(transition, all 0.4s ease, webkit ms moz o);
    &:hover,
    &:focus{
      background-color:$main-background;
      color: $primary-color;
      fill: $primary-color;
      border-bottom: 1px solid $primary-color;
    }
    &-light{
      background-color:$main-background;
      color: $main-foreground;
      fill: $main-foreground;
      border: 0;
      &:hover,
      &:focus{
        color: $main-foreground;
        fill: $main-foreground;
        border: 0;
      }
    }
  }
  .modal-close{
    &.no-header{
      border-radius: 100%;
    }
    &.invert{
      fill: $main-background;
      border: 1px solid $main-background;
    }
  }
}

{# /* // Forms */ #}

input,
textarea {
  font-family: $body-font;
}

.form-control::-webkit-input-placeholder { 
  color: rgba($main-foreground, .3);
}
.form-control:-moz-placeholder {
  color: rgba($main-foreground, .3);
}
.form-control::-moz-placeholder {
  color: rgba($main-foreground, .3);
}
.form-control:-ms-input-placeholder {
  color: rgba($main-foreground, .3);
}

.form-control,
.form-select,
.form-quantity{
  display: block;
  padding: 12px;
  width: 100%;
  font-size: 16px; /* Hack to avoid autozoom on IOS */
  text-align: left;
  border: 1px solid rgba($main-foreground, .3);
  @extend %border-radius-small;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  color: $main-foreground;
  fill: $main-foreground;
  background-color: $main-background;
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover{
    border: 1px solid $primary-color;
    & + .form-select-icon{
      fill: $primary-color;
    }
  }
  &:focus{
    outline:0px !important;
    -webkit-appearance:none;
  }
  &-inline{
    display: inline;
  }
  &-small{
    padding: 8px 10px;
    font-size: 12px;
  }
  &-big{
    padding: 17px 15px;
  }
}

.form-select-options {
  background-color: $main-background;
  border: 1px solid rgba($main-foreground, .3);
}

.form-select-options::-webkit-scrollbar {
  width: 7px;
}
.form-select-options::-webkit-scrollbar-track {
  background: rgba($main-background, .5);
  border-radius: 6px;
}

.form-select-options::-webkit-scrollbar-thumb {
  background: rgba($main-foreground, .5);
  border-radius: 6px;
}

.form-select-option:hover,
.form-select-option:active {
  background-color: rgba($main-foreground, .05);
}

.form-select-option.selected {
  background-color: rgba($main-foreground, .03);
}

.form-control-btn{
  position: absolute;
  top: 12px;
  right: 10px;
  &-icon{
    width: 18px;
    height: 18px;
  }
}

.form-quantity{
  .form-control{
    width: 100%;
    padding: 0;
    background-color: transparent;
    -moz-appearance:textfield;
    -webkit-appearance: none;
    border: 0;
    text-align: center;
  }
  &-icon{
    width: 16px;
    fill: $main-foreground;
  }
  &.small{
    width: 120px;
    float: left;
    padding: 8px;
  }
}

input::-webkit-inner-spin-button,
input::-webkit-outer-spin-button{
  -webkit-appearance: none;
  margin: 0;
}

.form-select{
  cursor: pointer;
}
.form-select-icon{
  background: $main-background;
  fill: $main-foreground;
}

.form-group-inline{
  .form-control{
    border-right: 0;
    border-radius: 10px 0 0 10px;
  }
  .btn{
    padding: 13px 12px 12px 12px;
    border-radius: 0 10px 10px 0;
  }
}

.input-clear-content:before {
  content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="{{ settings.primary_color |replace("#","%23") }}"><path d="M193.94 256L296.5 153.44l21.15-21.15c3.12-3.12 3.12-8.19 0-11.31l-22.63-22.63c-3.12-3.12-8.19-3.12-11.31 0L160 222.06 36.29 98.34c-3.12-3.12-8.19-3.12-11.31 0L2.34 120.97c-3.12 3.12-3.12 8.19 0 11.31L126.06 256 2.34 379.71c-3.12 3.12-3.12 8.19 0 11.31l22.63 22.63c3.12 3.12 8.19 3.12 11.31 0L160 289.94 262.56 392.5l21.15 21.15c3.12 3.12 8.19 3.12 11.31 0l22.63-22.63c3.12-3.12 3.12-8.19 0-11.31L193.94 256z"/></svg>');
}

.radio-button {
  .radio-button-content{
    border: 2px solid transparent;
    border-bottom: 1px solid rgba($main-foreground, .06);
  }
  &-icon.unchecked{
    background-color: $main-background;
  }
  input[type="radio"]{
    & +  .radio-button-content .unchecked{
      border: 1px solid rgba($main-foreground, .5);
    }
    &:checked + .radio-button-content .unchecked{
      border: 1px solid $primary-color;
    }
    &:checked + .radio-button-content{
      border: 2px solid $primary-color;
      @include prefix(transition, all 0.2s , webkit ms moz o);
    }
    &:checked + .radio-button-content .radio-button-icons-container{
      background-color: $primary-color;
    }
  }
}

.checkbox-container{
  .checkbox-icon {
    background: $main-background;
    border: 1px solid $main-foreground;
    &:after {
      border: solid $primary-color;
      border-width: 0 2px 2px 0;
    }
  }
  .checkbox:hover,
  input:checked ~ .checkbox {
    color: $primary-color;
    fill: $primary-color;
    .checkbox-icon {
      border: 1px solid $primary-color;
    }
  }
  .checkbox-color{
    border: 1px solid rgba($main-foreground, .06);
  }
}

.list .list-unstyled,
.list{
  .radio-button-item .radio-button-content,
  .list-item{
    border-bottom: 1px solid rgba($main-foreground, .06);
  }
  .radio-button-item:last-child .radio-button-content,
  .list-item:last-child{
    border-bottom: 0;
  }
}


{# /* // Alerts and notifications */ #}

.alert{
  @extend %border-radius-small;
  &:before{
    display: inline-block;
    width: 20px;
    height: 20px;
    margin-right: 10px;
    vertical-align: bottom;
  }
  &-danger,
  &-error{
    color: set-foreground-color($main-background, #cc4845);
    border-color: set-foreground-color($main-background, #cc4845);
    &:before{
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%23cc4845"><path d="M256 40c118.621 0 216 96.075 216 216 0 119.291-96.61 216-216 216-119.244 0-216-96.562-216-216 0-119.203 96.602-216 216-216m0-32C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm-11.49 120h22.979c6.823 0 12.274 5.682 11.99 12.5l-7 168c-.268 6.428-5.556 11.5-11.99 11.5h-8.979c-6.433 0-11.722-5.073-11.99-11.5l-7-168c-.283-6.818 5.167-12.5 11.99-12.5zM256 340c-15.464 0-28 12.536-28 28s12.536 28 28 28 28-12.536 28-28-12.536-28-28-28z"/></svg>');
    }
  }
  &-warning{
    color: set-foreground-color($main-background, #d27611);
    border-color: set-foreground-color($main-background, #d27611);
    &:before{
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" fill="%23d27611"><path d="M270.2 160h35.5c3.4 0 6.1 2.8 6 6.2l-7.5 196c-.1 3.2-2.8 5.8-6 5.8h-20.5c-3.2 0-5.9-2.5-6-5.8l-7.5-196c-.1-3.4 2.6-6.2 6-6.2zM288 388c-15.5 0-28 12.5-28 28s12.5 28 28 28 28-12.5 28-28-12.5-28-28-28zm281.5 52L329.6 24c-18.4-32-64.7-32-83.2 0L6.5 440c-18.4 31.9 4.6 72 41.6 72H528c36.8 0 60-40 41.5-72zM528 480H48c-12.3 0-20-13.3-13.9-24l240-416c6.1-10.6 21.6-10.7 27.7 0l240 416c6.2 10.6-1.5 24-13.8 24z"/></svg>');
    }
  }
  &-info{
    color: set-foreground-color($main-background, #3d9ccc);
    border-color: set-foreground-color($main-background, #3d9ccc);
    &:before{
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%233d9ccc"><path d="M256 40c118.621 0 216 96.075 216 216 0 119.291-96.61 216-216 216-119.244 0-216-96.562-216-216 0-119.203 96.602-216 216-216m0-32C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm-36 344h12V232h-12c-6.627 0-12-5.373-12-12v-8c0-6.627 5.373-12 12-12h48c6.627 0 12 5.373 12 12v140h12c6.627 0 12 5.373 12 12v8c0 6.627-5.373 12-12 12h-72c-6.627 0-12-5.373-12-12v-8c0-6.627 5.373-12 12-12zm36-240c-17.673 0-32 14.327-32 32s14.327 32 32 32 32-14.327 32-32-14.327-32-32-32z"/></svg>');
    }
  }
  &-success{
    color: set-foreground-color($main-background, #3caf65);
    border-color: set-foreground-color($main-background, #3caf65);
    &:before{
      content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%233caf65"><path d="M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 464c-118.664 0-216-96.055-216-216 0-118.663 96.055-216 216-216 118.664 0 216 96.055 216 216 0 118.663-96.055 216-216 216zm141.63-274.961L217.15 376.071c-4.705 4.667-12.303 4.637-16.97-.068l-85.878-86.572c-4.667-4.705-4.637-12.303.068-16.97l8.52-8.451c4.705-4.667 12.303-4.637 16.97.068l68.976 69.533 163.441-162.13c4.705-4.667 12.303-4.637 16.97.068l8.451 8.52c4.668 4.705 4.637 12.303-.068 16.97z"/></svg>');
    }
  }
  &-primary {
    border-color: $primary-color;
    color: $primary-color;
  }
}

.bg-primary{
  .alert{
    &-danger,
    &-error{
      color: $main-background;
      border-color: $main-background;
      &:before{
        content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%23{{ settings.background_color |trim('#') }}"><path d="M256 40c118.621 0 216 96.075 216 216 0 119.291-96.61 216-216 216-119.244 0-216-96.562-216-216 0-119.203 96.602-216 216-216m0-32C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm-11.49 120h22.979c6.823 0 12.274 5.682 11.99 12.5l-7 168c-.268 6.428-5.556 11.5-11.99 11.5h-8.979c-6.433 0-11.722-5.073-11.99-11.5l-7-168c-.283-6.818 5.167-12.5 11.99-12.5zM256 340c-15.464 0-28 12.536-28 28s12.536 28 28 28 28-12.536 28-28-12.536-28-28-28z"/></svg>');
      }
    }
    &-warning{
      color: $main-background;
      border-color: $main-background;
      &:before{
        content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" fill="%23{{ settings.background_color |trim('#') }}"><path d="M270.2 160h35.5c3.4 0 6.1 2.8 6 6.2l-7.5 196c-.1 3.2-2.8 5.8-6 5.8h-20.5c-3.2 0-5.9-2.5-6-5.8l-7.5-196c-.1-3.4 2.6-6.2 6-6.2zM288 388c-15.5 0-28 12.5-28 28s12.5 28 28 28 28-12.5 28-28-12.5-28-28-28zm281.5 52L329.6 24c-18.4-32-64.7-32-83.2 0L6.5 440c-18.4 31.9 4.6 72 41.6 72H528c36.8 0 60-40 41.5-72zM528 480H48c-12.3 0-20-13.3-13.9-24l240-416c6.1-10.6 21.6-10.7 27.7 0l240 416c6.2 10.6-1.5 24-13.8 24z"/></svg>');
      }
    }
    &-info{
      color: $main-background;
      border-color: $main-background;
      &:before{
        content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%23{{ settings.background_color |trim('#') }}"><path d="M256 40c118.621 0 216 96.075 216 216 0 119.291-96.61 216-216 216-119.244 0-216-96.562-216-216 0-119.203 96.602-216 216-216m0-32C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm-36 344h12V232h-12c-6.627 0-12-5.373-12-12v-8c0-6.627 5.373-12 12-12h48c6.627 0 12 5.373 12 12v140h12c6.627 0 12 5.373 12 12v8c0 6.627-5.373 12-12 12h-72c-6.627 0-12-5.373-12-12v-8c0-6.627 5.373-12 12-12zm36-240c-17.673 0-32 14.327-32 32s14.327 32 32 32 32-14.327 32-32-14.327-32-32-32z"/></svg>');
      }
    }
    &-success{
      color: $main-background;
      border-color: $main-background;
      &:before{
        content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="%23{{ settings.background_color |trim('#') }}"><path d="M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 464c-118.664 0-216-96.055-216-216 0-118.663 96.055-216 216-216 118.664 0 216 96.055 216 216 0 118.663-96.055 216-216 216zm141.63-274.961L217.15 376.071c-4.705 4.667-12.303 4.637-16.97-.068l-85.878-86.572c-4.667-4.705-4.637-12.303.068-16.97l8.52-8.451c4.705-4.667 12.303-4.637 16.97.068l68.976 69.533 163.441-162.13c4.705-4.667 12.303-4.637 16.97.068l8.451 8.52c4.668 4.705 4.637 12.303-.068 16.97z"/></svg>');
      }
    }
    &-primary {
      border-color: $main-background;
      color: $main-background;
    }
  }
}

.notification {
    &-primary {
        color: $main-background;
        background-color: darken($primary-color, 5%);
    }
    &-arrow-up {
        border-right: 10px solid transparent;
        border-bottom: 10px solid $main-background;
        border-left: 10px solid transparent;
    }
    &-floating .notification-primary {
        color: $main-foreground;
        background-color: $main-background;
        border-color: rgba($primary-color, .2);
    }
    &-secondary {
        background: $secondary-color;
        color: $main-background;
    }
    &-tertiary {
        color: $primary-color;
        background: lighten($main-foreground, 80%);
    }
    &-img svg {
        border-radius: 100%;
        background: $main-background;
    }
    &-danger {
        color: set-foreground-color($main-background, #cc4845);
    }   
}

{# /* // Tooltip */ #}

.tooltip{
  background: $secondary-color;
  color: $primary-color;
}
    
.tooltip-arrow{
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-bottom: 10px solid $secondary-color;
}

.tooltip-card {
  background: $main-background;
}

{# /* // Images */ #}

.card-img{
  @extend %border-radius-small;
  &-pill {
    background-color: $main-background;
    color: $main-foreground;
  }
}

{# /* // Tables */ #}

.table{
  background-color: $main-background;
  color: $main-foreground;
  tbody{
    tr:nth-child(odd){
      background-color: rgba($primary-color, .05);
    }
    &.table-body-inverted{
      tr:nth-child(even){
        background-color: rgba($primary-color, .05);
      }
      tr:nth-child(odd){
        background-color: $main-background;
      }
    }
  }
  th{
    padding: 8px;
    text-align: left;
  }
}

{# /* // Tabs */ #}

.tab-group{
  .tab{
    &-link{
      border: 1px solid transparent;
      color: $main-foreground;
      @extend %border-radius;
    }
    &.active{
      .tab-link{
        border: 1px solid $primary-color;
        color: $primary-color;
      }
    }
  }
}

{# /* Cards */ #}

.card {
  background-color: $main-background;
  border: 1px solid rgba($main-foreground, .08);
}

.card-header {
  background-color: rgba($main-foreground, .1);
}

{# /* // Sliders */ #}

.swiper-text {
  @extend %simplefade;
  opacity: 0;
  top: 60%;
}
.swiper-title {
  font-family: $heading-font;
}
.swiper-slide-active .swiper-text {
  opacity: 1;
  top: 50%;
}

.swiper-dark {
  color: $main-foreground;
  .swiper-btn {
    color: $main-background;
    background-color: $main-foreground;
  }
}

.swiper-light {
  color: $main-background;
  .swiper-btn {
    color: $main-foreground;
    background-color: $main-background;
  }
}

.swiper-pagination-bullet-active {
  background-color: $main-foreground;
}

.swiper-pagination-fraction{
  border-bottom: 1px solid rgba($main-foreground, .2);
}

{#/*============================================================================
  #Home Page
==============================================================================*/#}

{# /* // Home banners */ #}

.textbanner-image.overlay:after {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  background: rgba($main-foreground, .4);
  content: '';
}

.textbanner-link:hover {
  color: $main-foreground;
  .textbanner-text {
    border-bottom: 1px solid $main-foreground;
    &.over-image,
    &-primary {
      border: 0;
    }
  }
}

.textbanner-text {
  border-bottom: 1px solid rgba($main-foreground, .1);
  &-primary {
    border: 0;
    background: $primary-color;
    color: $main-background;
  }
}

{# /* // Informative banners */ #}

.section-informative-banners {
  @extend %section-margin;
  background: rgba($main-foreground, .1);
}

.service-icon {
  fill: $main-foreground;
}

{# /* // Video */ #}

.section-video-home {
  @extend %element-margin;
}

.embed-responsive {
  background: $main-foreground;
}

.video-player-icon {
  background: $primary-color;
}

{# /* // Instafeed */ #}

.instafeed-title {
  display: block;
  @extend %element-margin;
  line-height: 42px;
  color: $main-foreground;
}

.instafeed-info {
  color: $main-background;
  background: rgba($main-foreground, .6);
}

{# /* // Featured products */ #}

.section-featured-home {
  position: relative;
  @extend %element-margin;
}

{# /* // Newsletter */ #}

.section-newsletter-home {
  padding: 70px 0;
  background: $primary-color;
  color: $main-background;
}

.newsletter .form-control{
  border: 0;
  color: $primary-color;
  &::-webkit-input-placeholder { 
    color: $primary-color;
  }
  &:-moz-placeholder {
    color: $primary-color;
  }
  &::-moz-placeholder {
    color: $primary-color;
  }
  &:-ms-input-placeholder {
    color: $primary-color;
  }
}

.newsletter-btn {
  color: $main-foreground;
}

{# /* // Brands */ #}

.section-brands-home {
  @extend %element-margin;
  background: rgba($main-foreground, .1);
}


{#/*============================================================================
  #Product grid
==============================================================================*/#}

{# /* // Category controls */ #}

.category-controls {
  background-color: $main-background;
  &.is-sticky {
    box-shadow: 0 2px 2px 0 rgba($main-foreground, .14), 0 3px 1px -2px rgba($main-foreground, .2), 0 1px 5px 0 rgba($main-foreground, .12);
  }
}

.filters-overlay {
  background-color: rgba($main-background, .85);
}

{# /* // Grid item */ #}

.item {
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &-rounded {
    border: 1px solid rgba($main-foreground, .1);
    .item-description {
      border-top: 4px solid $primary-color;
      border-bottom: 1px solid transparent;
    }
  }
  &-link {
    color: $main-foreground;
  }
  &-price {
    color: $primary-color;
  }
  &-buy-variants {
    background: rgba($main-background, .9);
  }
  &-colors {
    background: rgba($main-background, .9);
    &-bullet {
      border: 1px solid rgba($main-foreground, .5);
      &.selected {
        border: 2px solid $main-foreground;
      }
    }
  }
}

{# /* // Labels */ #}

.label {
  background: $main-foreground;
  color: $main-background;
  &.label-primary{
    background: $primary-color;
    color: $main-background;
  }
  &.label-secondary{
    background: $secondary-color;
    color: $main-background;
  }
  &.label-accent{
    background: $accent-color;
    color: $main-background;
  }
}

{#/*============================================================================
  #Product detail
==============================================================================*/#}

{# /* // Image */ #}

.nube-slider-product {
  @extend %element-margin;
}

.product-thumb{
  &.selected{
    box-shadow: 0px 4px 0px 0px $primary-color
  }
  img{
    width: auto;
    height: 100%;
  }
}

.thumb-see-more{
  background-color: rgba($main-background, .5);
  color: $primary-color;
  &:hover{
    background-color: rgba($main-background, .9);
  }
}

.product-video-container {
  background-color: rgba($main-foreground, .07);
}

{# /* // Form and info */ #}

.product-detail-installments .installment-no-interest {
  color: $accent-color;
  font-weight: bold;
}
    
.social-share {
  @extend %element-margin;
  .social-share-button {
    color: $main-foreground;
  }
}

.product-description {
  @extend %element-margin;
}

{#/*============================================================================
  #Contact page
==============================================================================*/#}

{# /* // Data contact */ #}

.contact-item {
  @extend %element-margin;
  &-icon {
    fill: $main-foreground;
  }
}

.contact-link {
  color: $main-foreground;
}


{#/*============================================================================
  #Account page
==============================================================================*/#}

.account-page {
  @extend %section-margin;
}

{# /* // Order item */ #}

.order-item {
  padding: 15px 0;
  border-bottom: 1px solid rgba($main-foreground, .08);
  &:first-child {
    border-top: 1px solid rgba($main-foreground, .08);
  }
}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Topbar */ #}

.section-topbar {
  background-color: $secondary-color;
  color: $main-background;
  fill: $main-background;
}

{# /* // Header */ #}

.head-light{
  color: $primary-color;
  fill: $primary-color;
  background-color: $main-background;
  @extend %simplefade;
  a:not(.btn-primary),
  .svg-icon-text {
    color: $primary-color;
    fill: $primary-color;
  }

  .badge {
    color: $main-background;
    background: $primary-color;
  }

  .notification a,
  .notification .svg-icon-text {
    color: $main-background;
    fill: $main-background; 
  }

  .form-control{
    color: $primary-color;
    border: 1px solid $primary-color;
    &::-webkit-input-placeholder { 
      color: $primary-color;
    }
    &:-moz-placeholder {
      color: $primary-color;
    }
    &::-moz-placeholder {
      color: $primary-color;
    }
    &:-ms-input-placeholder {
      color: $primary-color;
    }
  }
  .nav-account {
    a,
    svg {
      color: $main-background;
      fill: $main-background;
    }
  }
}

.head-dark,
.head-primary{
  color: $main-background;
  fill: $main-background;
  background-color: $main-foreground;
  .svg-icon-text,
  .nav-desktop-list > .nav-item > .nav-list-link,
  .nav-desktop-list > .nav-item > .nav-item-container > .nav-list-link,
  .nav-desktop-list > .nav-item > .nav-item-container > .nav-list-arrow > i,
  .utilities-item svg{
    color: $main-background;
    fill: $main-background;
    border-color: rgba($main-background, 0.2)
  }
  .nav-desktop-list > .nav-item > .nav-item-container > .nav-list-link.selected,
  .nav-desktop-list > .nav-item > .nav-item-container > .nav-list-link.selected + .nav-list-arrow > i{
    color: $main-background;
    fill: $main-background;
    opacity: 0.6;
  }
  .form-control{
    background-color: $main-background;
    border: 0;
  }
  a {
    color: $main-background;
    fill: $main-background;
  }
  .btn-secondary {
    color: $primary-color;
  }
  .badge {
    color: $main-background;
    background: $primary-color;
  }
}

.head-primary{
  background-color: $primary-color;
  .icon-underline:after{
    background-color: rgba($main-background, .4);
  }
  .badge {
    color: $primary-color;
    background: $secondary-color;
  }
  .form-control{
    color: $primary-color;
    &::-webkit-input-placeholder { 
      color: $primary-color;
    }
    &:-moz-placeholder {
      color: $primary-color;
    }
    &::-moz-placeholder {
      color: $primary-color;
    }
    &:-ms-input-placeholder {
      color: $primary-color;
    }
  }
  .search-suggest {
    background-color: $primary-color;
    .search-suggest-item {
      border-bottom: 1px solid rgba($main-background, .1);
    }
    a.btn {
      background-color: $main-background;
      color: $primary-color;
      fill: $primary-color;
    }
  }

  .modal-close{
    fill: $main-background;
  }
  .nav-primary {
    .nav-list {
      .nav-item {
        border-color: rgba($main-background, .2);
      }
      .list-subitems {
        background-color: set-subnav-color($primary-color);
      }
    } 
  }
}

{# /* // Utilities */ #}

.subutility-list {
 background-color: $primary-color;
 box-shadow: 0 1px 6px rgba(0,0,0,0.2);
}

.head-light{
  .subutility-list {
   background-color: $main-background;
  }
  .search-suggest {
    background-color: $main-background;
    a.btn {
      color: $main-background;
      fill: $main-background;
    }
  }
  .nav-list-link {
    border-color: rgba($main-foreground, .2);
  }
  .modal-close{
    fill: $primary-color;
  }
  .nav-primary {
    .nav-list {
      .nav-item {
        border-color: rgba($main-foreground, .1);
      }
      .list-subitems {
        background-color: set-subnav-color($main-background);
      }
    } 
  }
}

.head-dark{
  .subutility-list {
   background-color: $main-foreground;
  }
  .search-input-submit {
    fill: $main-foreground;
  }
  .search-suggest {
    background-color: $main-foreground;
    .search-suggest-item {
      border-bottom: 1px solid rgba($main-background, .1);
    }
    a.btn {
      background-color: $main-background;
      color: $primary-color;
      fill: $primary-color;
    }
  }
  .nav-list-link {
    border-color: rgba($main-background, 0.2);
  }
  .modal-close{
    fill: $main-background;
  }
  .nav-primary {
    .nav-list {
      .nav-item {
        border-color: rgba($main-background, 0.1);
      }
      .list-subitems {
        background-color: set-subnav-color($main-foreground);
      }
    } 
  }
}



{# /* // Search */ #}

.search-input-submit {
  fill: $primary-color;
}

.search-suggest {
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.2);
  .search-suggest-item {
    border-bottom: 1px solid rgba($main-foreground, .1);
  }
}


{# /* // Nav */ #}

.nav-row {
  border-color: rgba($main-background, .2);
}

.desktop-dropdown::-webkit-scrollbar-track {
  background: darken($main-background, 5%);
}
.desktop-dropdown::-webkit-scrollbar-thumb {
  background: darken($primary-color, 10%);
}
.desktop-dropdown::-webkit-scrollbar-thumb:hover {
  background: darken($primary-color, 20%);
}
.desktop-list-subitems {
 background-color: rgba($primary-color, .95);
}


.head-light{
  .nav-row {
    border-color: rgba($primary-color, .2);
    border-bottom: 1px solid rgba($primary-color, .2);
  }
  .desktop-dropdown::-webkit-scrollbar-track {
    background: darken($main-background, 10%);
  }
  .desktop-dropdown::-webkit-scrollbar-thumb {
    background: darken($primary-color, 0%); 
  }
  .desktop-dropdown::-webkit-scrollbar-thumb:hover {
    background: darken($primary-color, 10%); 
  }
  .desktop-list-subitems {
    background-color: rgba($main-background, .95);
    color: $primary-color;
    fill: $primary-color;
    border-top: 1px solid rgba($primary-color, .1);
    border-bottom: 1px solid rgba($primary-color, .1);
  }
  .nav-categories-container:after,
  .nav-categories-container:before {
    background-image: linear-gradient(-90deg, transparent, darken($main-background, 3%));
  }
}

.head-dark{
  .nav-row {
    border-color: rgba($main-background, .15);
  }
  .desktop-dropdown::-webkit-scrollbar-track {
    background: darken($main-background, 20%);
  }
  .desktop-dropdown::-webkit-scrollbar-thumb {
    background: lighten($main-foreground, 20%); 
  }
  .desktop-dropdown::-webkit-scrollbar-thumb:hover {
    background: lighten($main-foreground, 30%);
  }
  .desktop-list-subitems {
    background-color: rgba($main-foreground, .95);
    color: $main-background;
    fill: $main-background;
  }
  .nav-categories-container:after,
  .nav-categories-container:before {
    background-image: linear-gradient(-90deg, transparent, darken($main-foreground, 3%));
  }
}

.nav-categories-container:after,
.nav-categories-container:before {
  background-image: linear-gradient(-90deg, transparent, darken($primary-color, 2%));
}

.nav-secondary {
  .nav-account {
    background-color: set-background-color($primary-color);
    box-shadow: 0 2px 5px rgba($main-foreground, .4);
  }
}

.modal-nav-hamburger {
  .navigation-topbar {
    background-color: $secondary-color;
    fill: $main-background;
  }
}


{#/*============================================================================
  #Footer
==============================================================================*/#}

{% if settings.footer_colors %}
  $footer-background-color: $footer-background;
  $footer-foreground-color: $footer-foreground;
  $footer-legal-background-color: $footer-background;
  $footer-legal-foreground-color: $footer-foreground;
{% else %}
  $footer-background-color: rgba($main-foreground, .1);
  $footer-foreground-color: $primary-color;
  $footer-legal-background-color: $primary-color;
  $footer-legal-foreground-color: $main-background;
{% endif %}

footer {
  color: $footer-foreground-color;
  background: $footer-background-color;
  a,
  .contact-link {
    color: $footer-foreground-color;
  }
  .contact-item-icon {
    fill: $footer-foreground-color;
  }
}

.social-icon-rounded {
  background: $footer-foreground-color;
  {% if settings.footer_colors %}
    fill: $footer-background-color;
  {% else %}
    fill: $main-background;
  {% endif %}
  &:hover {
    {% if settings.footer_colors %}
      opacity: .8;
    {% else %}
      background: $secondary-color;
    {% endif %}
  }
}

.section-footer {
  @extend %section-margin;
}
.element-footer {
  @extend %element-margin;
}

.powered-by-logo svg {
  fill: $footer-legal-foreground-color;
}

.footer-legal {
  background: $footer-legal-background-color;
  color: $footer-legal-foreground-color;
  a {
    color: $footer-legal-foreground-color;
    &:hover {
      opacity: .8;
    }
  }
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  {# /* //// Components */ #}

  {# /* Forms */ #}

  .form-control,
  .form-select,
  .form-quantity{
    font-size: 14px;
  }

  .btn-extra-small-md {
    padding: 10px;
    font-size: 10px;
  }

  {# /* Modals */ #}

  .modal-header{
    &:hover,
    &:focus{
      .modal-close{
        border: 1px solid $primary-color;
      }
    }
    &-light:hover,
    &-light:focus{
      .modal-close{
        border: 1px solid $main-background;
      }
    }
  }
  .modal-close,
  .modal-header .modal-close{
    border: 1px solid $main-background;
    border-radius: 100%;
  }

  {# /* Slider */ #}

  .swiper-text {
    opacity: 0;
    top: 40%;
  }
  .swiper-slide-active .swiper-text {
    opacity: 1;
    top: 50%;
  }

  {# /* //// Home Banners */ #}

  .textbanner-shadow {
    @include prefix(transition, all 0.4s ease, webkit ms moz o);
    &:hover {
      box-shadow: 0 1px 10px rgba($main-foreground, .2);
    }
  }

  {# /* //// Product grid */ #}

  .item {
    &-description {
      border-bottom: 1px solid rgba($main-foreground, .2);
      @include prefix(transition, all 0.4s ease, webkit ms moz o);
    }
    &-product:hover {
      box-shadow: 0 1px 6px rgba($main-foreground, .2);
      .item-description {
        border-bottom: 1px solid transparent;
      }
    }
    &-rounded .item-actions {
      background: $main-background;
      box-shadow: 0 6px 6px rgba($main-foreground, .2);
    }
  }

}