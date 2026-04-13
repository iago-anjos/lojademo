{% set no_results_message = template == 'category' ? (has_filters_enabled ? "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." : "Próximamente") | translate : "No hubo resultados para tu búsqueda" | translate %}
{% if products %}
    <div class="js-product-table row">
        {% include 'snipplets/product_grid.tpl' %}
    </div>
        {% include "snipplets/grid/pagination.tpl" with {infinite_scroll: true} %}
{% else %}
    <h6 class="text-center my-2" data-component="filter.message">
        {{ no_results_message }}
    </h6>
{% endif %}