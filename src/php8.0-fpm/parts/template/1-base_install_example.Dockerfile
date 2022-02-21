# -------------------- Installing PHP Extension: base --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         Built-in extension
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) base \
    && php -m | grep -oiE '^base$' \
    && true
