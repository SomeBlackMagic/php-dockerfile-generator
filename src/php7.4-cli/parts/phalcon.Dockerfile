# -------------------- Installing PHP Extension: phalcon --------------------
RUN set -eux \
    # Installation: Generic
    # Type:         GIT extension \
    && apk add git \
    && git clone https://github.com/phalcon/cphalcon /tmp/phalcon \
    && cd /tmp/phalcon \
    # Custom:       Branch
    && git checkout $(git for-each-ref --format='%(*creatordate:raw)%(creatordate:raw) %(refname)' refs/tags | sort -n | sed 's/^.*tags\///g' | grep -E '^v[.0-9]+$' | tail -1) \
    # Custom:       Install command
    && cd build && ./install \
    # Enabling
    && docker-php-ext-enable phalcon \
    # && php -m | grep -oiE '^phalcon' \ - no check. PHP Warning:  Cannot load module 'phalcon' because required module 'psr' is not loaded in Unknown on line 0
    && true
