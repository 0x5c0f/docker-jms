# 应官方安全漏洞公告，指定初始版`v2.6.2`开始，于公网访问主机需紧急修复   
> https://github.com/jumpserver/jumpserver/blob/master/README.md  

---  

## Jumpserver Docker-Compose 仓库  
此仓库目前已归档:  
> ~~[https://github.com/jumpserver/Dockerfile](https://github.com/jumpserver/Dockerfile)~~  

## Jumpserver Installer 仓库  
官方最新的部署支持方案,后续管理及升级也将全部由其控制，提供分离部署方案，但似乎不再提供自打包部署方案
> [https://github.com/jumpserver/installer](https://github.com/jumpserver/installer)   


## 核心组件 
```sh
$> cd /data/docker/
$> git clone https://github.com/0x5c0f/docker-jms.git
$> cd docker-jms
$> cp config.example.conf .env
$> cat .env
# 外置 
# docker-compose -f docker-compose-build.yml up -d --build
$> docker-compose up -d 
# 内置
# docker-compose -f docker-compose-build.local.yml up -d --build
$> docker-compose -f docker-compose.local.yml up -d 

```

## 说明

- `.env` 里面配置的应该是常规需要的，若其他参数请参考官方文档 [`https://docs.jumpserver.org/zh/master/admin-guide/env`](https://docs.jumpserver.org/zh/master/admin-guide/env/), 所需参数直接加入`docker`环境变量即可生效  

- 首次使用需要先执行`build`,或者将`image`标签更换为官方镜像 

- 这个是我根据 [~~官方仓库~~](https://github.com/jumpserver/Dockerfile) 改的

- 仓库可将`redis`、`mysql`、`nginx`全部分离外置环境 

- **[[jumpserver/installer]](https://github.com/jumpserver/installer) 仓库采用了统一管理, 基础镜像增加了一个(据了解是由`core`分离出来的),至`2021-04-23`,当前仓库仍兼容`jms`最新版**

- 当前仓库不会随官方更新而修改基础版本(*我只是部署的,改不改意义不大*), 但会随官方变更(环境)而更新 

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
# 初始化前端站点 
$> chmod +x prepare 
$> ./prepare 

# 复制 jms.conf.j2 到 nginx 的 conf.d/jms.conf 下，需修改jms.conf的主机名
```
