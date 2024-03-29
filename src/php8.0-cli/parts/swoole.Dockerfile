ARG SWOOLE_VERSION=4.7.0

# install swoole
#TIP: it always get last stable version of swoole coroutine.
RUN set -exu && \
    cd /tmp && \
    wget https://github.com/swoole/swoole-src/archive/refs/tags/v${SWOOLE_VERSION}.zip && \
    unzip /tmp/v${SWOOLE_VERSION}.zip && \
    ls -lah /tmp && \
    cd swoole-src-${SWOOLE_VERSION} && \
    phpize  && \
    ./configure \
    --enable-coroutine \
    --enable-http2  \
    --enable-openssl  \
    --enable-coroutine-postgresql \
    --enable-async-redis && \
    make -j$(getconf _NPROCESSORS_ONLN) && make install && \
    docker-php-ext-enable swoole && \
    php -m | grep -oiE '^swoole$' && \
    rm -rf /tmp/* && \
    true