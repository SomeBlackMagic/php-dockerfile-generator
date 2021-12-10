# -------------------- Installing PHP Extension: sqlsrv --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install sqlsrv \
    # Enabling
    && docker-php-ext-enable sqlsrv \
    && php -m | grep -oiE '^sqlsrv$' \
    && php-fpm -m | grep -oiE '^sqlsrv$' \
    && true
