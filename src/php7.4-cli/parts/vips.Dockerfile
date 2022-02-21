# -------------------- Installing PHP Extension: vips --------------------
RUN set -eux \
    # Generic pre-command \
    && apk add git gtk-doc libtool expat-dev \
    && git clone https://github.com/libvips/libvips /tmp/libvips \
    && cd /tmp/libvips \
    && ./autogen.sh \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/libvips \
    \
    # Installation: Generic
    # Type:         PECL extension
    # Default:      Pecl command
    && pecl install vips \
    # Enabling
    && docker-php-ext-enable vips \
    && php -m | grep -oiE '^vips$' \
    && true