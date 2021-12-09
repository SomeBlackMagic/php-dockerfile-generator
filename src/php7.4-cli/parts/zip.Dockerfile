# -------------------- Installing PHP Extension: zip --------------------
RUN set -eux \
	# Installation: Version specific
	# Type:         Built-in extension
	# Custom:       configure command \
    && apk add libzip-dev \
	&& docker-php-ext-configure zip --with-zip \
	# Installation
	&& docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) zip \
	&& true
