FROM php:7.4-fpm-alpine

# Fix timezone (only required for testing to stop php -v and php-fpm -v from complaining to stderr)
RUN set -eux \
    && echo "date.timezone=UTC" > /usr/local/etc/php/php.ini

###
### Upgrade (install ps)
###
RUN set -eux \
    && apk add procps curl bash autoconf build-base autoconf automake \
    && true

RUN set -eux \
    && echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && curl https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck > /usr/local/bin/php-fpm-healthcheck \
    && chmod +x /usr/local/bin/php-fpm-healthcheck \
    && apk add fcgi busybox grep \
    && true

{% for item in modules %}
{{ item | raw }}
{% endfor %}


###
### Verify
###
RUN set -eux \
    && echo "date.timezone=UTC" > /usr/local/etc/php/php.ini \
    && php -v | grep -oE 'PHP\s[.0-9]+' | grep -oE '[.0-9]+' | grep '^7.4' \
    \
    && PHP_ERROR="$( php -v 2>&1 1>/dev/null )" \
    && if [ -n "${PHP_ERROR}" ]; then echo "${PHP_ERROR}"; false; fi \
    && PHP_ERROR="$( php -i 2>&1 1>/dev/null )" \
    && if [ -n "${PHP_ERROR}" ]; then echo "${PHP_ERROR}"; false; fi \
    \
    && rm -f /usr/local/etc/php/php.ini \
    && true

###
### Envs
###
ENV MY_USER="app" \
    MY_GROUP="app" \
    MY_UID="1000" \
    MY_GID="1000"

####
#### User/Group
####
RUN set -eux \
    && addgroup -g ${MY_GID} ${MY_GROUP} \
    && adduser -u ${MY_UID} -G ${MY_GROUP} -s /bin/sh -D ${MY_USER} \
    && true

ENV BASH_ENV /etc/profile.d/bash_profile.sh
COPY ./data/bash_profile.sh /etc/profile.d/bash_profile.sh

###
### Copy files
###
###
COPY ./data/php.ini /usr/local/etc/php/conf.d/default-php.ini
COPY ./data/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./data/docker.conf /usr/local/etc/php-fpm.d/docker.conf
COPY ./data/global.conf /usr/local/etc/php-fpm.d/global.conf

ENV PHP_FPM_GLOBAL_ERROR_LOG /proc/self/fd/2
ENV PHP_FPM_GLOBAL_LOG_LEVEL notice
ENV PHP_FPM_GLOBAL_LOG_BUFFERING no
ENV PHP_FPM_WWW_ACCESS_LOG_PATH /proc/self/fd/1
ENV PHP_FPM_WWW_SLOWLOG_PATH /proc/self/fd/1
ENV PHP_FPM_WWW_CLEAR_ENV no
ENV PHP_FPM_WWW_CATCH_WORKERS_OUTPUT yes
ENV PHP_FPM_WWW_DECORATE_WORKERS_OUTPUT no
ENV PHP_FPM_WWW_PM dynamic
ENV PHP_FPM_WWW_PM_MAX_CHILDREN 6
ENV PHP_FPM_WWW_PM_START_SERVERS 5
ENV PHP_FPM_WWW_PM_MIN_SPARE_SERVERS 3
ENV PHP_FPM_WWW_PM_MAX_SPARE_SERVERS 6
ENV PHP_FPM_WWW_PM_PROCESS_IDLE_TIMEOUT 10s
ENV PHP_FPM_WWW_PM_MAX_REQUESTS 100
ENV PHP_FPM_WWW_REQUEST_SLOWLOG_TIMEOUT 10
ENV PHP_FPM_WWW_REQUEST_SLOWLOG_TRACE_DEPTH 20
ENV PHP_FPM_WWW_REQUEST_TERMINATE_TIMEOUT 120s

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./docker-entrypoint.d /docker-entrypoint.d

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm"]
