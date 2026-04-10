{# Categories banners that work as examples #}

<div class="container js-category-banner-placeholder">
    <div class="row">
        <div class="col-md">
            <div class="textbanner{% if settings.theme_rounded %} box-rounded{% endif %}">
                <div class="textbanner-image overlay textbanner-image-empty">
                </div>
                <div class="textbanner-text{% if settings.theme_rounded %} textbanner-text-primary{% endif %}">
                    <div class="h2">{{ "Categoría" | translate }}</div>
                </div>
                <div class="placeholder-overlay transition-soft">
                    <div class="placeholder-info">
                        <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                        <div class="placeholder-description font-small-xs">
                            {{ "Podés destacar categorías de tu tienda desde" | translate }} <strong>"{{ "Banners de categorías" | translate }}"</strong>
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
                <div class="textbanner-text{% if settings.theme_rounded %} textbanner-text-primary{% endif %}">
                    <div class="h2">{{ "Categoría" | translate }}</div>
                </div>
                <div class="placeholder-overlay transition-soft">
                    <div class="placeholder-info">
                        <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                        <div class="placeholder-description font-small-xs">
                            {{ "Podés destacar categorías de tu tienda desde" | translate }} <strong>"{{ "Banners de categorías" | translate }}"</strong>
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
                <div class="textbanner-text{% if settings.theme_rounded %} textbanner-text-primary{% endif %}">
                    <div class="h2">{{ "Categoría" | translate }}</div>
                </div>
                <div class="placeholder-overlay transition-soft">
                    <div class="placeholder-info">
                        <svg class="icon-inline icon-3x"><use xlink:href="#edit"/></svg>
                        <div class="placeholder-description font-small-xs">
                            {{ "Podés destacar categorías de tu tienda desde" | translate }} <strong>"{{ "Banners de categorías" | translate }}"</strong>
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

{# Skeleton of "true" section accessed from instatheme.js #}
<div class="js-category-banner-top" style="display:none">
    {% include 'snipplets/home/home-banners.tpl' %}
</div>