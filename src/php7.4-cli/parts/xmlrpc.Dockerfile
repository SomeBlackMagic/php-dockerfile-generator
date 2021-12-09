# -------------------- Installing PHP Extension: xmlrpc --------------------
RUN set -eux \
	# Installation: Version specific
	# Type:         Built-in extension
	# Custom:       configure command \
    && apk add libxml2-dev \
	&& docker-php-ext-configure xmlrpc --with-iconv-dir=/usr \
	# Installation
	&& docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) xmlrpc \
    && php -m | grep -oiE '^xmlrpc$' \
    && true
