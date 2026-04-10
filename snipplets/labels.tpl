{% set has_multiple_slides = product.images_count > 1 or product.video_url %}
{% set label_accent_classes = 'label label-accent' %}

{% set custom_label = product.getPromotionCustomLabel %}
{% set has_custom_promotion_label = custom_label and custom_label | trim %}

{{ component(
  'labels', {
    defer_stock_label_text: true,
    prioritize_promotion_over_offer: true,
    promotion_quantity_long_wording: true,
    promotion_nxm_long_wording: false,
    labels_classes: {
      group: 'js-labels-floating-group ' ~ (product_detail and has_multiple_slides ? 'labels-product-slider'),
      promotion: label_accent_classes,
      promotion_primary_text: 'd-block',
      promotion_secondary_text: 'font-smallest',
      offer: 'js-offer-label ' ~ (not has_custom_promotion_label ? 'label-circle ') ~ label_accent_classes,
      shipping: label_accent_classes,
      no_stock: 'js-stock-label label label-default',
    },
  })
}}