title: 遇到怪事了-玄学的ApacheTomcat容器
date: 2017-12-26 10:08:00
toc: true
categories: 技术向
tags: []
thumbnail: https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike60%2C5%2C5%2C60%2C20/sign=bf6d81464f90f60310bd9415587bd87e/b3b7d0a20cf431adfe004e4e4e36acaf2fdd98f2.jpg
---
最近把Jenkins移到了新的服务器上，由于已经自带Apache Tomcat所以就使用War包的方式部署Jenkins，然而我一不小心手贱重启了Tomcat，于是这只该死的Tomcat就罢工了。


<!--more-->


提示如下：
```
org.apache.catalina.startup.Catalina stopServer
SEVERE: Could not contact localhost:8005. Tomcat may not be running.
org.apache.catalina.startup.Catalina stopServer
SEVERE: Catalina.stop: 
java.net.ConnectException: Connection refused
at java.net.PlainSocketImpl.socketConnect(Native Method)
at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
at java.net.Socket.connect(Socket.java:589)
at java.net.Socket.connect(Socket.java:538)
at java.net.Socket.<init>(Socket.java:434)
at java.net.Socket.<init>(Socket.java:211)
at org.apache.catalina.startup.Catalina.stopServer(Catalina.java:476)
at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
at java.lang.reflect.Method.invoke(Method.java:497)
at org.apache.catalina.startup.Bootstrap.stopServer(Bootstrap.java:408)
at org.apache.catalina.startup.Bootstrap.main(Bootstrap.java:497)
```
初步判断是端口占用的原因，因为上面的Log显示应该是端口冲突了。于是我把所有的Java全部kill了，并无卵用。Tomcat各个端口全部换掉也无济于事。。。我甚至重装了Tomcat都没有用

然后心里好气哟，于是上了百度找了半天全是建议更换端口，终于，我在V站上面发现了一个在1年前和我有同样遭遇的人：[https://www.v2ex.com/t/257064][1]

当时好激动，因为情况简直一模一样。赶快看了评论，终于找到了解决办法。

> 找到 jdk1.x.x_xx/jre/lib/security/java.security 这个文件 
> 把 securerandom.source 设置成 
> securerandom.source=file:/dev/./urandom 

最后终于看到了熟悉的Jenkins界面，虽然并不知道为什么这样就解决了，据说是因为JDK内存太小的原因（所以说到底还是内存的锅咯），但是真的炒鸡开心的说～感谢V站的大佬们，也分享给大家，说不定哪天碰上了呢


  [1]: https://www.v2ex.com/t/257064