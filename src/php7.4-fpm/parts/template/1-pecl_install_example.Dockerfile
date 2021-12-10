# -------------------- Installing PHP Extension: pecl --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install pecl \
    # Enabling
    && docker-php-ext-enable pecl \
    && php -m | grep -oiE '^pecl$' \
    && php-fpm -m | grep -oiE '^pecl$' \
    && true
