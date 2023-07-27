FROM debian:bullseye

RUN set -x && apt update && apt install --no-install-recommends --no-install-suggests -y \
    build-essential wget git libpcre3 libpcre3-dev ca-certificates libssl-dev zlib1g-dev

RUN wget 'https://nginx.org/download/nginx-1.18.0.tar.gz' \
    && tar -xf nginx-1.18.0.tar.gz \
    && git clone --depth 1 https://github.com/tiandrey/nginx-sslkeylog

RUN addgroup --system --gid 101 nginx \
    && adduser --system --disabled-login --ingroup nginx --no-create-home --home /nonexistent --gecos "nginx user" \
        --shell /bin/false --uid 101 nginx

RUN cd nginx-1.18.0 && ./configure \
    --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock \
    --user=nginx --group=nginx --with-compat --with-file-aio \
    --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module \
    --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module \
    --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module \
    --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail \
    --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --add-module=../nginx-sslkeylog

RUN cd nginx-1.18.0 && make -j 12

RUN cd nginx-1.18.0 && make install

STOPSIGNAL SIGQUIT

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

EXPOSE 80
