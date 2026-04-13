{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
{% endembed %}

{# Institutional page  #}

<section class="user-content pb-5">
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-md-10">
				{{ page.content }}
			</div>
		</div>
	</div>
</section>
