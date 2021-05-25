FROM centos:7
WORKDIR /opt
ARG Version=v2.10.0
ENV Version=${Version} \
    LANG=en_US.utf8

RUN set -ex \
    && yum install make gcc-c++ -y \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "LANG=en_US.utf8" > /etc/locale.conf \
    && echo "net.core.somaxconn = 1024" >> /etc/sysctl.conf \
    && echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf \
    && curl -O https://download.redis.io/releases/redis-6.2.3.tar.gz \
    && tar -xzf redis-6.2.3.tar.gz && cd redis-6.2.3 \
    && make && make install \
    && mv redis.conf /etc/redis.conf \
    && sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis.conf \
    && sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /etc/redis.conf \
    && sed -i "1021i maxmemory-policy allkeys-lru" /etc/redis.conf \
    && cd /opt \
    && rm -rf /opt/redis-6.2.3.tar.gz /opt/redis-6.2.3 \
    && yum clean all \
    && rm -rf /var/cache/yum/*

COPY redis/entrypoint.sh .
RUN chmod 755 ./entrypoint.sh

CMD ["./entrypoint.sh"]
