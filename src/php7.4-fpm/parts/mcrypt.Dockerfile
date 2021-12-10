# -------------------- Installing PHP Extension: mcrypt --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         Built-in extension
    && apk add libmcrypt-dev \
    && pecl install mcrypt-1.0.4 \
    && docker-php-ext-enable mcrypt \
    && php -m | grep -oiE '^mcrypt$' \
    && php-fpm -m | grep -oiE '^mcrypt$' \
    && true
