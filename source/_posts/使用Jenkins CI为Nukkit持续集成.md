title: 使用Jenkins CI为Nukkit持续集成
date: 2017-12-30 04:09:00
toc: true
categories: 技术向
tags: []
thumbnail: 
---
最近搭了个Jenkins，在一番~~艰难困苦~~的研究之后，终于成功的使用Jenkins编译了一个Maven项目Nukkit。虽然过程艰辛了点，但是从长远来看还是挺方便的，实现了自动检测GayHub上面的项目更新并且自动完成构建，岂不美哉？


<!--more-->


话说这篇文章拖了好久啊...元旦前一个周末就开始写了，现在元旦放假还没写完...我保证这篇文章一定是我有史以来最用心的...没有之一！

## 项目简介 ##

Nukkit是一个由iDeaLeaper一群大佬们写的强大的Minecraft PE非官方开服程序，使用JAVA环境运行，项目代码开源。但是由于MC更新频率极快，所以服务端也需要不断更新，故需Jenkins进行持续集成。

GayHub项目地址：[https://github.com/Nukkit/Nukkit][1]

官方提供的编译方法如下：
```
git submodule update --init
mvn clean
mvn package
```

## 构建环境配置 ##

首先Nukkit是一个Maven项目，因此Jenkins中要把Maven Intergration插件装好，便于新建Maven项目。同时安装Apache Maven，并配置环境变量。

插件安装非常简单，在Jenkins系统设置-插件管理-可选插件里面搜索Maven Intergration就可以安装了

![jenkins_nukkit_02.PNG][2]

Maven的话我用的是Ubuntu，直接执行：

```
apt-get install maven
```

安装完成之后输入mvn -version就会出现Maven路径，再到Jenkins中系统设置-全局工具配置填写Maven路径

![jenkins_nukkit_03.PNG][3]

此外，Git等一些常用的组件也要安装好，具体就不详述了，偷个小懒哈（跑

## 建立Maven项目 ##

Jenkins中点击左侧的建立新的Item，名称随意，项目类型选择Maven（如果没有这个选项一定是你的Maven Intergration插件没有安装好，请检查上一部分操作是否正确）

![jenkins_nukkit_04.PNG][4]

接下来就是项目信息的配置填写了，这里不多说话，直接上图吧

![jenkins_nukkit_05.PNG][5]
![jenkins_nukkit_06.PNG][6]
![jenkins_nukkit_07.PNG][7]
![jenkins_nukkit_08.PNG][8]
![jenkins_nukkit_09.PNG][9]
![jenkins_nukkit_10.PNG][10]

需要注意的是源码管理中的Credentials请填写你自己的GayHub账户（不填好像也没什么关系吧）

## 初次构建 ##

到这里为止就基本设置完啦～想想自己的Jenkins即将跑起第一个项目心里还是挺激动的！

But...在控制台里一大片红色文字闪过后你得到了一个红色的小球（编译失败）

![jenkins_nukkit_01.PNG][11]

怎么会这样呢？

我翻了好久的Issue终于发现了有人和我一样，是缺少对应的库文件，只需要把
 https://github.com/Nukkit/Nukkit/raw/master/lib/leveldb.jar 丢进Maven的Lib文件夹里就可以啦

紧接着再跑一次构建，终于得到了编译好的Nukkit.jar

![jenkins_nukkit_11.PNG][12]

到这里这篇文章就差不多了，只要Jenkins一直运行着，他就会默默帮你检测代码更新，跑代码，测试，构建JAR，听起来就很棒呢！

感谢各位的阅读～如果有什么问题下方留言即可，我会尽力解答哒


  [1]: https://github.com/Nukkit/Nukkit
  [2]: https://blog.hans362.cn/usr/uploads/2017/12/1150874294.png!webp_1920w
  [3]: https://blog.hans362.cn/usr/uploads/2017/12/4193414249.png!webp_1920w
  [4]: https://blog.hans362.cn/usr/uploads/2017/12/1956709933.png!webp_1920w
  [5]: https://blog.hans362.cn/usr/uploads/2017/12/1756374654.png!webp_1920w
  [6]: https://blog.hans362.cn/usr/uploads/2017/12/2253135693.png!webp_1920w
  [7]: https://blog.hans362.cn/usr/uploads/2017/12/122406515.png!webp_1920w
  [8]: https://blog.hans362.cn/usr/uploads/2017/12/3680943815.png!webp_1920w
  [9]: https://blog.hans362.cn/usr/uploads/2017/12/3128980480.png!webp_1920w
  [10]: https://blog.hans362.cn/usr/uploads/2017/12/4176100376.png!webp_1920w
  [11]: https://blog.hans362.cn/usr/uploads/2017/12/3897374868.png!webp_1920w
  [12]: https://blog.hans362.cn/usr/uploads/2017/12/3611958073.png!webp_1920w