title: 【项目发布】LightWhite_For_PaperInk
date: 2018-01-23 02:26:00
toc: true
categories: 项目发布
tags: []
thumbnail: 
---
经过一段时间的努力，我已经成功（算是吧...）将本博客使用的主题移植到了纸小墨静态博客上，故发此文进行说明。

首先感谢蚊子大佬的LightWhite主题，真的超厉害的呢～目前我移植的纸小墨主题是基于LightWhite 1.3.1版本，如果后面原作者有更新的话我也会第一时间更进的（可能吧...）各位有能力也可以把自己移植的最新主题提交个PullRequest

<!--more-->

## 纸小墨 ##

纸小墨（InkPaper）是一个GO语言编写的开源静态博客构建工具，可以快速搭建博客网站。它无依赖跨平台，配置简单构建快速，注重简洁易用与更优雅的排版。

纸小墨官方说明：http://www.chole.io/blog/ink-blog-tool.html

## LightWhite For 纸小墨 ##

本主题基于Archeb的LightWhite主题移植，在GitHub开源。

GitHub项目链接：https://github.com/hans362/LightWhite_For_PaperInk

GitHub Release版本：https://github.com/hans362/LightWhite_For_PaperInk/releases

**请勿直接下载项目！！！请下载最新Release包**

~~项目演示（GitHubPages）：https://hans362.github.io/~~失效
原主题链接：https://github.com/Archeb/LightWhite

## 使用方法 ##

解压纸小墨后得到ink.exe和blog文件夹，进入blog/theme文件夹，清空里面所有文件并粘贴本主题文件

编辑blog文件夹下的config.yml（不是主题里的！！！）

内容按如下修改：
```
    site:
    title: "纸小墨官方博客"
    subtitle: "构建只为纯粹书写的博客"
    limit: 10
    theme: theme
    lang: zh
    url: "http://www.chole.io/blog"
    comment: username
    logo: "-/images/avatar.png!webp_1920w"
    # link: "{category}/{year}/{month}/{day}/{title}.html"
    # root: "/blog"

    authors:
    me:
        name: "纸小墨"
        intro: "构建只为纯粹书写的博客"
        avatar: "-/images/avatar.png!webp_1920w"

    build:
    # output: "public"
    port: 8000
    # Copied files to public folder when build
    copy:
        - "source/images"
        - "theme/img"
        - "theme/css"
        - "theme/js"
        - "theme/fonts"
    # Excuted command when use 'ink publish'
    publish: |
        git add . -A
        git commit -m "update"
        git push origin
```
重点是copy:部分的代码，不要擅自修改

然后参考纸小墨官方的使用方法，ink build生成静态博客

注：ink preview无法预览主题正常效果

## 已知BUG ##

（截止至2018.1.23）

 1. ~~首页呈诡异状排版（求大佬帮助...QwQ）~~已修复，感谢蚊子的帮助
 2. 日期显示问题（Unix时间戳与月日转换还在研究...）
 3. 归档页面较丑（原主题貌似没有归档页面）
 4. ~~预览图片代码部分暂未移植（懒...）~~已补上
 5. 评论系统未加入

如果有更多Bug请在下方留言或者GitHub提交Issue谢谢

## 支持我 ##

想要支持本主题GitHub上面给个Star啊之类的都是可以的～当然别忘了给原作者Star～

本博客“关于我”三个字右边的东西点一下看一看也是可以哒～