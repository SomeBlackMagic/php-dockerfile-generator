# -------------------- Installing PHP Extension: solr --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install solr \
    # Enabling
    && docker-php-ext-enable solr \
    && php -m | grep -oiE '^solr$' \
    && true
