# -------------------- Installing PHP Extension: pcov --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install pcov \
    # Enabling
    && docker-php-ext-enable pcov \
    && php -m | grep -oiE '^pcov$' \
    && true
