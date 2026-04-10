{% set message_name = institutional ? 'institutional' : 'welcome' %}
{% set message_title = institutional ? settings.institutional_message : settings.welcome_message %}
{% set message_description = institutional ? settings.institutional_text : settings.welcome_text %}

<section class="section-welcome-home" data-store="home-{{ message_name }}-message">
    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <h2 class="js-{{ message_name }}-message-title h1">{{ message_title }}</h2>
                <p class="js-{{ message_name }}-message-text" {% if not message_description %}style="display: none"{% endif %}>{{ message_description }}</p>
            </div>
        </div>
    </div>
</section>