{% set item_rounded_class = settings.theme_rounded ? 'item-rounded box-rounded overflow-none mb-3' %}

<div class="container mb-5">
    {% embed "snipplets/page-header.tpl" with { breadcrumbs: true } %}
        {% block page_header_text %}{{ "Blog" | translate }}{% endblock page_header_text %}
    {% endembed %}
    <section class="blog-page pb-5">
        <div class="row">
            {% for post in blog.posts %}
                <div class="col-md-4 mb-2 mb-md-4">
                    {{ component(
                        'blog/blog-post-item', {
                            image_lazy: true,
                            image_lazy_js: true,
                            post_item_classes: {
                                item: 'item p-0 ' ~ item_rounded_class,
                                image_container: '',
                                image: 'img-absolute img-absolute-centered fade-in',
                                information: 'item-description py-4 px-3',
                                title: 'item-name mb-3',
                                summary: 'mb-3 font-small',
                                read_more: 'btn-link btn-link-primary',
                            },
                        })
                    }}
                </div>
            {% endfor %}
        </div>
    </section>
    {% include 'snipplets/grid/pagination.tpl' with {'pages': blog.pages} %}
</div>
