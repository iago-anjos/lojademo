<div class="js-home-video-container container{% if settings.video_full %}-fluid p-0{% endif %}" {% if not settings.video_embed %}style="display: none"{% endif %}>
    <div class="row no-gutters">
        <div class="col-md-8 offset-md-2 text-center">
            <h2 class="h1 js-home-video-title {% if settings.theme_rounded %}text-primary{% endif %}" {% if not settings.video_title %}style="display: none"{% endif %}>{{ settings.video_title }}</h2>
            <p class="mb-5 js-home-video-text" {% if not settings.video_text %}style="display: none"{% endif %}>{{ settings.video_text }}</p>
        </div>
        <div class="col-12 js-home-video" data-video-color="{{ settings.primary_color | trim('#') }}">
            {% include 'snipplets/video-item.tpl' %}
        </div>
    </div>
</div>