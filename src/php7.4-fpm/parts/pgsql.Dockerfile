# -------------------- Installing PHP Extension: pgsql --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         Built-in extension
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) pgsql \
    && php -m | grep -oiE '^pgsql$' \
    && php-fpm -m | grep -oiE '^pgsql$' \
    && true
