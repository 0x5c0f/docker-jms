*此项目停止维护，兼容版本至最后一次提交版本v2.16.3,有需要请转至官方*
---
## Jumpserver Docker-Compose 仓库  
自构建部署方案  
> [https://github.com/jumpserver/Dockerfile](https://github.com/jumpserver/Dockerfile) 

## Jumpserver Installer 仓库  
官方最新的部署支持方案,后续管理及升级也将全部由其控制，提供分离部署方案  
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

- 首次使用需要先 `build` 

- ~~这个是我根据官方仓库 [`[jumpserver/Dockerfile]`](https://github.com/jumpserver/Dockerfile) 改的~~

- 当前版本兼容 `v2.16.3`, 若其要其他版本,可查看 [`Releases`](https://github.com/0x5c0f/docker-jms/releases)版本或使用 [`[jumpserver/installer]`](https://github.com/jumpserver/installer)仓库 

- 当前第二版根据 [`[jumpserver/installer]`](https://github.com/jumpserver/installer) 调整 

- 仓库可将`redis`、`mysql`、`nginx`全部分离外置环境 

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
