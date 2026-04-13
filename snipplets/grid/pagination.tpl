{% if infinite_scroll %}
    {% if pages.current == 1 and not pages.is_last %}
        <div class="text-center mt-5 mb-5">
            <a class="js-load-more btn btn-primary">
                <span class="js-load-more-spinner pull-left m-right-quarter" style="display:none;">
                    <svg class="icon-inline icon-spin"><use xlink:href="#circle-notch"/></svg>
                </span>
                {{ 'Mostrar más productos' | t }}
            </a>
        </div>
        <div id="js-infinite-scroll-spinner" class="mt-5 mb-5 text-center w-100" style="display:none">
            <svg class="icon-inline icon-3x svg-icon-text icon-spin"><use xlink:href="#circle-notch"/></svg>
        </div>
    {% endif %}
{% else %}
    {% if pages.numbers %}
        <div class="d-flex justify-content-center align-items-center">
            <a {% if pages.previous %}href="{{ pages.previous }}"{% endif %} class="mr-3 {% if not pages.previous %}opacity-30 disabled{% endif %}">
                <svg class="svg-circle svg-icon-text icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
            </a>
            <div class="h4 mb-0 text-center font-weight-normal">
                <span>{{ pages.current }}</span>
                <span>{{'de' | translate }}</span>
                <span>{{ pages.amount }}</span>
            </div>
            <a {% if pages.next %}href="{{ pages.next }}"{% endif %} class="ml-3 {% if not pages.next %}opacity-30 disabled{% endif %}">
                <svg class="svg-circle svg-icon-text icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
            </a>
        </div>
    {% endif %}
{% endif %}
