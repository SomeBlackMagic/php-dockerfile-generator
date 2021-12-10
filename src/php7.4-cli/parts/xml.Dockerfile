# -------------------- Installing PHP Extension: xml --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         Built-in extension
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) xml \
    && php -m | grep -oiE '^xml$' \
    && true
