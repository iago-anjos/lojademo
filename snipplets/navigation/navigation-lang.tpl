{% if languages | length > 1 %}
    <div class="languages">
        {% for language in languages %}
            {% set class = language.active ? "" : "opacity-50" %}
            <a href="{{ language.url }}" class="{{ class }}">
            	<img class="lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
            </a>
        {% endfor %}
    </div>
{% endif %}