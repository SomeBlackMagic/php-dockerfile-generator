# -------------------- Installing PHP Extension: propro --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install propro \
    # Enabling
    && docker-php-ext-enable propro \
    && php -m | grep -oiE '^propro$' \
    && php-fpm -m | grep -oiE '^propro$' \
    && true
