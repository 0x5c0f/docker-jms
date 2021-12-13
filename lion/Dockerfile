FROM guacamole/guacd

WORKDIR /opt
ARG Version=v2.16.3
ENV Version=${Version} \
    LANG=en_US.utf8

USER root

RUN set -ex \
    && sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y supervisor wget curl \
    && wget https://github.com/jumpserver/lion-release/releases/download/${Version}/lion-${Version}-linux-amd64.tar.gz \
    && tar -xf lion-${Version}-linux-amd64.tar.gz && mv lion-${Version}-linux-amd64 lion \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -rf *.tar.gz \
    && rm -rf /var/lib/apt/lists/* 

COPY lion/entrypoint.sh .
COPY lion/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 755 ./entrypoint.sh

EXPOSE 8081

CMD [ "./entrypoint.sh" ]
