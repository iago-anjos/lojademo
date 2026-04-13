
{% if primary_links %}
    <div class="nav-primary">
        <ul class="nav-list" data-store="navigation" data-component="menu">
            {% include 'snipplets/navigation/navigation-nav-list.tpl' with { 'mobile_nav' : true  } %}
        </ul>
    </div>
{% else %}
    <div class="nav-secondary" data-store="account-links">
        <ul class="nav-account">
            {% if not customer %}
                <svg class="icon-inline icon-2x icon-w-14 mr-2 ml-3"><use xlink:href="#user"/></svg>
                {% if 'mandatory' not in store.customer_accounts %}
                    <li class="nav-accounts-item">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'nav-accounts-link') }}</li>
                {% endif %}
                <li class="nav-accounts-item position-relative">
                    {{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'js-login nav-accounts-link') }}            
                    {% if store.country == 'AR'%}
                        {# Notification badge for quick login on AR stores #}
                        <a data-toggle="#quick-login" class="js-modal-open js-quick-login-badge" style="display: none;">
                            <span class="js-quick-login-badge badge badge-float"></span>
                        </a>
                        {# Tooltip for quick login on AR stores #}
                        {% include "snipplets/tooltip-login.tpl" %}
                    {% endif %}
                </li>
            {% else %}
                <svg class="icon-inline icon-2x-half icon-w-12 mr-2 ml-3"><use xlink:href="#user"/></svg>
                <li>
                    <strong class="nav-accounts-item mb-0">{{ "¡Hola, {1}!" | t(customer.name) }}</strong> 
                    <ul class="d-flex m-0 p-0">
                        <li class="nav-accounts-item">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'nav-accounts-link') }}</li>
                        <li class="nav-accounts-item">{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'nav-accounts-link') }}</li>
                    </ul>
                </li>
            {% endif %}
        </ul>
    </div>
{% endif %}