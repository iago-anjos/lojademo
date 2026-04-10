{% set desktop_nav = desktop_nav | default(false) %}

{% for item in navigation %}
	{% if item.subitems %}
    	<li class="nav-item  item-with-subitems">
    		<div class="nav-item-container {% if not desktop_nav %}js-nav-list-toggle-accordion{% endif %}">
	            <a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">{{ item.name }}</a>
	        </div>
			<ul class="{% if desktop_nav %}{% else %}js-pages-accordion{% endif %} list-subitems nav-list-accordion" >
				{% include 'snipplets/navigation/navigation-nav-list-subitems.tpl' with { 'navigation' : item.subitems } %}
			</ul>
		</li>
	{% else %}
		<li class="nav-item {% if desktop_nav %}nav-item-desktop{% endif %}">
        	<a class="nav-list-link {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">{{ item.name }}</a>
        </li>
	{% endif %}
{% endfor %}