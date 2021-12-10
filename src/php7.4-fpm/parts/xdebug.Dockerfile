# -------------------- Installing PHP Extension: xdebug --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install xdebug \
    # Enabling
    && docker-php-ext-enable xdebug \
    && php -m | grep -oiE '^xdebug$' \
    && php-fpm -m | grep -oiE '^xdebug$' \
    && true
