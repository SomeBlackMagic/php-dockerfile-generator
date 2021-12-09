RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install raphf \
    # Enabling
    && docker-php-ext-enable raphf \
    && php -m | grep -oiE '^raphf$' \
    && true

# -------------------- Installing PHP Extension: propro --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install propro \
    # Enabling
    && docker-php-ext-enable propro \
    && php -m | grep -oiE '^propro$' \
    && true

# -------------------- Installing PHP Extension: http --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install pecl_http-3.2.4 \
    # Enabling
    && docker-php-ext-enable http \
    && php -m | grep -oiE '^http$' \
    && true
