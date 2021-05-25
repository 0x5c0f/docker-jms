# 环境编译
FROM python:3.8.6-slim

WORKDIR /opt
ARG Version=v2.10.0
ENV Version=${Version} \
    LANG=zh_CN.utf8

RUN set -ex \
    && sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt update \
    && apt install -y wget ncat \
    && wget https://github.com/jumpserver/jumpserver/releases/download/${Version}/jumpserver-${Version}.tar.gz \
    && tar -xf jumpserver-${Version}.tar.gz \ 
    && mv jumpserver-${Version} jumpserver \
    && chown -R root:root jumpserver \
    && grep -v '^#' /opt/jumpserver/requirements/deb_buster_requirements.txt | xargs apt -y install \
    && pip install --upgrade pip==20.2.4 setuptools==49.6.0 wheel==0.34.2 \
    && pip install --no-cache-dir $(grep 'jms' /opt/jumpserver/requirements/requirements.txt) \
    && pip install --no-cache-dir -r /opt/jumpserver/requirements/requirements.txt \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
    && rm -rf *.tar.gz \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf ~/.cache/pip

    # && pip config set global.index-url https://mirrors.cqu.edu.cn/pypi/web/simple \
    # && mkdir -p /root/.ssh/ \
    # && echo "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile /dev/null" > /root/.ssh/config \

VOLUME /opt/jumpserver/data

COPY core/entrypoint.sh .
RUN chmod 755 ./entrypoint.sh

EXPOSE 8070
EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]