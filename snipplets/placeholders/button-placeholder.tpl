<div class="js-addtocart js-addtocart-placeholder btn btn-primary btn-block btn-transition {{ custom_class }} disabled" style="display: none;">
    <div class="d-inline-block">
        <span class="js-addtocart-text">{% if direct_add %}{{ 'Comprar' | translate }}{% else %}{{ 'Agregar al carrito' | translate }}{% endif %}</span>
        <span class="js-addtocart-success transition-container btn-transition-success-small">
            <svg class="icon-inline svg-icon-invert btn-transition-success-icon"><use xlink:href="#check-circle"/></svg>
        </span>
        <div class="js-addtocart-adding transition-container transition-soft btn-transition-progress">
            <div class="spinner-ellipsis invert">
                <div class="point"></div>
                <div class="point"></div>
                <div class="point"></div>
                <div class="point"></div>
            </div>
        </div>
    </div>
</div>