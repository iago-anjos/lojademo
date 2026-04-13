{% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
    {% set sn_url = attribute(store,sn) %}
    {% if sn_url %}
        <a class="{% if circle %}social-icon-rounded{% else %}social-icon{% endif %}" href="{{ sn_url }}" target="_blank" aria-label="{{ sn }} {{ store.name }}">
            {% if sn == "facebook" %}
                {% set social_network = sn ~ '-f' %}
            {% else %}
                {% set social_network = sn %}
            {% endif %}
            {% if circle %}
                {% set icon_class = 'icon-inline icon-lg' %}
            {% else %}
                {% set icon_class = 'icon-inline icon-md' %}
            {% endif %}
            <svg class="{{ icon_class }}"><use xlink:href="#{{ social_network }}"/></svg>
        </a>
    {% endif %}
{% endfor %}