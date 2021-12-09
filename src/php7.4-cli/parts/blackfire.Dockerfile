# -------------------- Installing PHP Extension: blackfire --------------------
RUN set -eux \
	# Installation: Generic
	# Type:         Custom extension
	&& version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz \
    && echo "extension=blackfire" >> /usr/local/etc/php/conf.d/docker-php-ext-blackfire.ini \
    && php -m | grep -oiE '^blackfire' \
	&& true
