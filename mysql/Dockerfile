FROM centos:7
WORKDIR /opt
ARG Version=v2.16.3
ENV Version=${Version} \
    LANG=en_US.utf8

RUN set -ex \
    && yum install -y epel-release \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "LANG=en_US.utf8" > /etc/locale.conf \
    && yum -y localinstall http://mirrors.ustc.edu.cn/mysql-repo/mysql57-community-release-el7.rpm \
    && yum -y install mysql-community-server \
    && yum clean all \
    && rm -rf /var/cache/yum/*

COPY mysql/entrypoint.sh .
RUN chmod 755 ./entrypoint.sh

CMD ["./entrypoint.sh"]