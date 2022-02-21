# -------------------- Installing PHP Extension: swoole --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         PECL extension
    # Custom:       Pecl command  \
    # test deps ext
    && php -m | grep -oiE '^curl$' \
    && php -m | grep -oiE '^sockets$' \
    \
    && apk add openssl-dev \
    && yes yes | pecl install swoole \
    # Enabling
    && docker-php-ext-enable swoole \
    && php -m | grep -oiE '^swoole$' \
    && php-fpm -m | grep -oiE '^swoole$' \
    && true
