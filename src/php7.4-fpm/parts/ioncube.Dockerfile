# -------------------- Installing PHP Extension: ioncube --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         Custom extension
    && EXTENSION_DIR="$( php -i | grep ^extension_dir | awk -F '=>' '{print $2}' | xargs )" \
    && if [ ! -d "${EXTENSION_DIR}" ]; then mkdir -p "${EXTENSION_DIR}"; fi \
    && curl https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -L -o ioncube.tar.gz \
    && tar xvfz ioncube.tar.gz \
    && cd ioncube \
    && cp "ioncube_loader_lin_7.4.so" "${EXTENSION_DIR}/ioncube.so" \
    && cd ../ \
    && rm -rf ioncube \
    && rm -rf ioncube.tar.gz \
    && echo "zend_extension=ioncube" >> /usr/local/etc/php/conf.d/docker-php-ext-ioncube.ini \
    && php -m | grep -oiE '^ioncube' \
    && php-fpm -m | grep -oiE '^ioncube' \
    && true
