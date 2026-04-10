{# Promotional banners that work as examples #}

<div class="container">
    <div class="row">
        <div class="col-md">
            <div class="textbanner{% if settings.theme_rounded %} box-rounded{% endif %}">
                <div class="textbanner-image overlay textbanner-image-empty">
                </div>
                <div class="textbanner-text over-image">
                    <div class="h2">{{ "Promoción" | translate }}</div>
                    <div class="btn btn-secondary btn-small invert mt-3">{{ "Link" | translate }}</div>
                </div>
                <div class="placeholder-overlay transition-soft">
                    <div class="placeholder-info">
                        <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                        <div class="placeholder-description font-small-xs">
                            {{ "Podés mostrar tus promociones desde" | translate }} <strong>"{{ "Banners promocionales" | translate }}"</strong>
                        </div>
                        {% if not params.preview %}
                            <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="textbanner{% if settings.theme_rounded %} box-rounded{% endif %}">
                <div class="textbanner-image overlay textbanner-image-empty">
                </div>
                <div class="textbanner-text over-image">
                    <div class="h2">{{ "Promoción" | translate }}</div>
                    <div class="btn btn-secondary btn-small invert mt-3">{{ "Link" | translate }}</div>
                </div>
                <div class="placeholder-overlay transition-soft">
                    <div class="placeholder-info">
                        <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                        <div class="placeholder-description font-small-xs">
                            {{ "Podés mostrar tus promociones desde" | translate }} <strong>"{{ "Banners promocionales" | translate }}"</strong>
                        </div>
                        {% if not params.preview %}
                            <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md">
            <div class="textbanner{% if settings.theme_rounded %} box-rounded{% endif %}">
                <div class="textbanner-image overlay textbanner-image-empty">
                </div>
                <div class="textbanner-text over-image">
                    <div class="h2">{{ "Promoción" | translate }}</div>
                    <div class="btn btn-secondary btn-small invert mt-3">{{ "Link" | translate }}</div>
                </div>
                <div class="placeholder-overlay transition-soft">
                    <div class="placeholder-info">
                        <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                        <div class="placeholder-description font-small-xs">
                            {{ "Podés mostrar tus promociones desde" | translate }} <strong>"{{ "Banners promocionales" | translate }}"</strong>
                        </div>
                        {% if not params.preview %}
                            <a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-secondary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
