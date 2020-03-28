title: IIS环境下为Typecho配置伪静态
date: 2017-12-28 11:36:00
toc: true
categories: 技术向
tags: []
thumbnail: 
---
Typecho是一款轻量级的基于PHP的博客程序，界面简洁，简单明了，而且它还可以使用内置的固定链接功能让博客看上去像静态页面。


<!--more-->


那么我的博客是使用Typecho，搭建在Windows上的，并且用的是IIS 7，最近心血来潮想打开固定链接的功能，结果却提示无法检测URL重写。然而无论是Typecho官方文档还是百度，都没有针对IIS的伪静态设置说明（有httpd.ini但是不兼容）。

无奈。。。还是自己动手吧。自己选择的路，哭着也得走完啊

在一番复杂的研究之后，我终于写出了一个有效的web.config（哈哈哈哈哈高兴死我啦）
```
<!--web.config url rewrite-->
     <configuration> 
     <system.webServer>
     <rewrite>
     <rules>
     <rule name="Main Rule" stopProcessing="true">
         <match url="^(.*)$" />
         <conditions logicalGrouping="MatchAll">
             <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
             <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
         </conditions>
         <action type="Rewrite" url="/index.php/{R:1}" />
      </rule>
      </rules>
      </rewrite>
      </system.webServer>
      </configuration>
```
配置好之后重启IIS，后台打开固定链接

Now，Enjoy～