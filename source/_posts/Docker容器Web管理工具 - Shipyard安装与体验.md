title: Docker容器Web管理工具 - Shipyard安装与体验
date: 2018-05-12 07:26:00
toc: true
categories: 技术向
tags: []
thumbnail: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/9BBD8EB1-AA29-450F-A03F-A557F2B7FF01.jpeg
---
> ### **2018.4.19更新：建议各位不要使用了，我的主机已经被黑了，疑似是通过自用的Shipyard攻入的，被恶意运行了挖坑程序，这种停止维护的项目还是尽量不要使用，使用的话请做好防火墙防护措施**

最近我开始研究起Docker容器，发现竟然有这么好的东西～最让我喜欢的一点是每个容器之间都是隔离开来的，部署方便，资源利用充分，~~终于可以为所欲为了呢~~

然而每次开个容器命令都要敲个半天，懒癌发作，所以我想找一个Docker的WebUI管理器，最终发现了Shipyard

Shipyard是一个基于Web的Docker管理工具，支持多主机，可以把多个Docker主机上的容器统一管理，可以查看镜像，甚至构建镜像，并提供RESTful API等等

遗憾的是，当我写这篇文章的时候，这个项目的作者已经弃坑了，项目处于无人更新维护的状态，所以自己玩玩就好，切勿用于生产环境，以免造成严重后果

地址：http://shipyard-project.com/（打不开的，作者已经弃坑此项目）

<!--more-->

## Shipyard安装 ##

由于作者已经弃坑，网站都打不开啦，官网提供的安装命令自然已经失效，辣么肿么办勒？

幸运的是作者没有删除GitHub以及DockerHub上面的项目，我们可以自己动手

Linux安装好Docker后执行以下命令：

```
#!/bin/bash
docker run -ti -d --restart=always --name shipyard-rethinkdb rethinkdb
docker run -ti -d -p 4001:4001 -p 7001:7001 --restart=always --name shipyard-discovery microbox/etcd:latest  -name discovery
docker run -ti -d -p 2375:2375 --hostname=$HOSTNAME --restart=always --name shipyard-proxy -v /var/run/docker.sock:/var/run/docker.sock -e PORT=2375 shipyard/docker-proxy:latest
docker run -ti -d --restart=always --name shipyard-swarm-manager swarm:latest manage --host tcp://0.0.0.0:3375 etcd://${IP/ADDRESS}:4001
docker run -ti -d --restart=always --name shipyard-swarm-agent swarm:latest join --addr ${IP/ADDRESS}:2375 etcd://${IP/ADDRESS}:4001
docker run -ti -d --restart=always --name shipyard-controller --link shipyard-rethinkdb:rethinkdb --link shipyard-swarm-manager:swarm -p 8080:8080 shipyard/shipyard:latest server -d tcp://swarm:3375
```

注意：其中${IP/ADDRESS}请全部替换为您的服务器的IP地址

## Shipyard使用 ##

安装完成打开http://IP:8080/就可以看到Shipyard的界面啦～

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/D239626C-597E-47C3-8CEC-2A21F3FA8AA0.jpeg][1]

注意：如果无法打开请检查防火墙设置，是否开放8080等端口

输入用户名admin密码shipyard就可以进入面板了，记得修改默认密码哟

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/2DBABFB6-1E9A-42C0-9C80-0E91E4C93E4F.jpeg][2]

Shipyard功能强大，除了容器的管理还支持镜像管理、日志记录、用户管理、节点管理等

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/4621B7B3-AB42-4CB2-87CE-60463706999B.jpeg][3]

点击创建容器，会出现如下界面，可以非常便捷地完成创建，设置项丰富，可以设置环境变量、端口映射、主机名、容器关联、重启规则等

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/4C224FA4-708A-412D-A249-E9C4E4CCE217.jpeg][4]

点进容器中，单个容器的管理可以说是非常惊艳了

除了基本的开始，停止，重启功能之外，还提供实时资源监控、日志记录、进程管理以及一个强大的在线SSH

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/B3DAB28D-221B-4AF3-8232-32F213FAB9D6.jpeg][5]

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/AA5A96AF-3B2C-477D-AAA8-CBC8EBC0D91F.jpeg][6]

![https://blog-img-1251828412.file.myqcloud.com/2018/04/13/FA1DE817-0EF1-4DE3-9629-7097A88D4287.jpeg][7]

除此之外，Shipyard还提供API接口与文档，对接个WHMCS卖卖Docker容器岂不妙哉？

以上就是安装教程与使用体验啦～尽管项目作者已经弃坑，但还是不得不说这个WebUI真的挺不错的，感谢项目作者写出这么好的东西与大家分享，希望作者有朝一日能继续维护下去吧～

> 我的博客即将搬运同步至腾讯云+社区，邀请大家一同入驻：https://cloud.tencent.com/developer/support-plan?invite_code=1v02tr9dydqgg

  [1]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/D239626C-597E-47C3-8CEC-2A21F3FA8AA0.jpeg
  [2]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/2DBABFB6-1E9A-42C0-9C80-0E91E4C93E4F.jpeg
  [3]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/4621B7B3-AB42-4CB2-87CE-60463706999B.jpeg
  [4]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/4C224FA4-708A-412D-A249-E9C4E4CCE217.jpeg
  [5]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/B3DAB28D-221B-4AF3-8232-32F213FAB9D6.jpeg
  [6]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/AA5A96AF-3B2C-477D-AAA8-CBC8EBC0D91F.jpeg
  [7]: https://blog-img-1251828412.file.myqcloud.com/2018/04/13/FA1DE817-0EF1-4DE3-9629-7097A88D4287.jpeg