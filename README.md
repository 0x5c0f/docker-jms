# 应官方安全漏洞公告，指定初始版本由`v2.6.2`开始，于公网访问主机需紧急修复   
> https://github.com/jumpserver/jumpserver/blob/master/README.md  

---  

## Jumpserver Docker-Compose
官方仓库： 
> [https://github.com/jumpserver/Dockerfile](https://github.com/jumpserver/Dockerfile)  


## 核心组件 
```sh
$> cd /data/docker/
$> git clone https://github.com/0x5c0f/docker-jms.git
$> cd docker-jms
$> cp config.example.conf .env
$> cat .env
# docker-compose -f docker-compose-build.yml up
$> docker-compose up
```

## 说明

- `.env` 里面配置的应该是常规需要的，若其他参数请参考官方文档 [https://docs.jumpserver.org/zh/master/admin-guide/env/](https://docs.jumpserver.org/zh/master/admin-guide/env/), 所需参数直接加入`docker`环境变量即可生效  

- 首次使用需要先执行`build`,或者将`image`标签更换为官方镜像 

- **这个是我根据官方仓库改的,将redis、mysql、nginx全部设为了外置环境** 

- 有问题请优先仔细阅读官方文档  

## 外置环境 

- mysql server

```mysql
create database jumpserver default charset 'utf8' collate 'utf8_bin';
grant all on jumpserver.* to 'jumpserver'@'%' identified by 'weakPassword';
```

- 然后在 .env 里面定义 mysql 和 redis 

- nginx server
```bash
$> export Version=v2.6.2       # . .env
$> cd /opt 

$> wget https://github.com/jumpserver/luna/releases/download/${Version}/luna-${Version}.tar.gz
$> tar -xf luna-${Version}.tar.gz
$> mv luna-${Version} jmsluna

$> wget https://github.com/jumpserver/lina/releases/download/${Version}/lina-${Version}.tar.gz
$> tar -xf lina-${Version}.tar.gz
$> mv lina-${Version} jmslina

$> ln -s /data/docker/docker-jms/data/jms-data /opt/jms-data

# or 直接执行 
$> ./prepare 

# 复制 jms.conf.j2 到 nginx 的 conf.d/jms.conf 下，需修改jms.conf的主机名
```
