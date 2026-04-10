{% if not customer and store.country == 'AR' and template == 'home' %}
	<div class="js-tooltip js-login-tooltip tooltip {% if desktop %}js-login-tooltip-desktop tooltip-bottom fade-in-vertical{% else %}tooltip-top{% endif %}" style="display: none;">
        <span class="tooltip-arrow tooltip-arrow-{% if desktop %}up{% else %}down{% endif %}"></span>
        <a data-toggle="#quick-login" class="js-modal-open js-notification m-right">
            <span class="text-primary">{{ '<strong>¡Comprá más rápido</strong> y seguí tus pedidos!' | translate }}</span>
        </a>
        <a class="js-tooltip-close js-dismiss-quicklogin mr-1" href="#">
            <svg class="icon-inline icon-lg svg-icon-primary ml-2 align-middle"><use xlink:href="#times"/></svg>
        </a>
    </div>
{% endif %}
