# -------------------- Installing PHP Extension: sockets --------------------
RUN set -eux \
	# Installation: Generic
	# Type:         Built-in extension
	&& docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) sockets \
    && php -m | grep -oiE '^sockets$' \
    && php-fpm -m | grep -oiE '^sockets$' \
	&& true
