ARG OPENSWOOLE_VERSION=4.11.0

# install swoole
#TIP: it always get last stable version of swoole coroutine.
RUN set -exu && \
    cd /tmp && \
    wget https://github.com/openswoole/swoole-src/archive/refs/tags/v${OPENSWOOLE_VERSION}.zip && \
    unzip /tmp/v${OPENSWOOLE_VERSION}.zip && \
    ls -lah /tmp && \
    cd swoole-src-${OPENSWOOLE_VERSION} && \
    phpize  && \
    ./configure \
    --enable-coroutine \
    --enable-http2  \
    --enable-openssl  \
    --enable-coroutine-postgresql \
    --enable-async-redis && \
    make -j$(getconf _NPROCESSORS_ONLN) && make install && \
    docker-php-ext-enable openswoole && \
    php -m | grep -oiE '^openswoole$' && \
    rm -rf /tmp/* && \
    true