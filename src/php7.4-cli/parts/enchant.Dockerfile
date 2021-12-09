# -------------------- Installing PHP Extension: enchant --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         Built-in extension \
    && echo "Extension: enchant not supported in alpine." \
    # && apk add enchant-dev \
    # && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) enchant \
    # && php -m | grep -oiE '^enchant$' \
    && true
