# -------------------- Installing PHP Extension: gmp --------------------
RUN set -eux \
    # Installation: Generic
    && apk add gmp-dev \
    # Type:         Built-in extension
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gmp \
    && php -m | grep -oiE '^gmp$' \
    && php-fpm -m | grep -oiE '^gmp$' \
    && true
