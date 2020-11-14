title: 搭了个Jenkins CI～
date: 2017-12-23 04:24:00
toc: true
categories: 技术向
tags: []
thumbnail: https://blog.hans362.cn/usr/uploads/2017/12/1118237617.gif
---
虽说我已经是懒癌晚期了但是为了方便~~自己~~大家还是搭了个Jenkins。平时可以自动在上面构建一些项目什么的，还是挺方便的呢

这次和大家分享一下搭建的过程吧～


<!--more-->


## 系统环境 ##

系统：CentOS 6.8 x86_64

IP位置：德国（别问我为什么选德国233都怪国内要备案然后刚好德国有一台闲置主机）

## 安装JAVA ##

~~让我喝一口82年的JAVA~~

咳咳...

```
yum install java-1.8.0-openjdk
```

## 安装Jenkins ##

```
wget -O /etc/yum.repos.d/jenkins.repo http://jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins
```

## 启动Jenkins ##

```
service jenkins start
```

## 配置Jenkins ##

由于是采用YUM安装的原因，其实如果没有特殊需求（例如改默认8080端口）的话，直接访问http://ip:8080/就可以了，超方便der有木有

然后就是按照提示一步一步走，看得懂英文当然最好啦，看不懂就一直往下点也是可以的

最后就进入了Jenkins CI的主界面啦，会自动根据你的浏览器设置语言哦～不需要自己修改成中文，挺人性化的

![jenkins_installed.PNG][1]

(安装过程忘记截图了...就这样吧ಠ_ಠ）

## 常见问题 ##

暂时没发现呢...以后再补（懒癌晚期的日常2333）

## 结束语 ##

总体来说这次搭建还是挺顺利的，目前Jenkins上面已经跑了一个项目，就是本博客使用的LightWhite主题，每天下午三点会自动从GayHub上面构建。大家有什么项目需要我帮忙持续集成的话也可以本页下方留言哦，提供GayHub项目地址及构建方法即可。由于之前没怎么用过Jenkins，目前也仍在研究中

![lightwhite_jenkins.PNG][2]

~~（顺便一说有谁知道Nukkit怎么用Jenkins持续集成吗...求教各位大佬|已学会，但是编译到一半就会因为内存不足导致Jenkins被杀...看样子得等有钱了换一个内存大一点的服务器，不过跑跑小项目还是可以的）~~

** 2017.12.24更新：Jenkins搬到了一台1H1G的美国服务器上面，这下可以愉快地玩耍了呢，还搞了个反代不需要加端口访问了（是不是很棒） **

哦对了...差点忘了...我的Jenkins地址是[戳我戳我][3]，欢迎来玩^_^


  [1]: https://blog.hans362.cn/usr/uploads/2017/12/3486196270.png!webp_1920w
  [2]: https://blog.hans362.cn/usr/uploads/2017/12/1666787342.png!webp_1920w
  [3]: http://jenkins.milkcloud.ml/