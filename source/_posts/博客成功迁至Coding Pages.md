title: 博客成功迁至Coding Pages
date: 2018-02-11 05:47:00
toc: true
categories: 杂文
tags: []
thumbnail: 
---
因为租的AWS服务器快要到期了，然而没钱续了，所以我把博客迁到Coding Pages上面，用动态Pages部署Typehco。

然而动态Pages貌似是把仓库里的文件放到一个单独的容器里运行，所以无法做到仓库和容器双向同步，图片就不能直接传到容器里啦，不然一关Pages图片就全丢了...幸好有CosUpload插件直接传COS，解决了这个问题

发张图Test一下：

![2017111413191397.jpg!webp_1920w][1]

不过迁移过程中还是踩了一些坑，Mark一下

## MySQL问题 ##

本次迁移中PHP版本是5.6=>7.1，由于PHP7开始不再使用MySQL函数，所以在config.inc.php中要修改部分代码：

```
$db = new Typecho_Db('Mysql', 'typecho_');
```

修改成

```
$db = new Typecho_Db('Pdo_Mysql', 'typecho_');
```

酱紫就搞定啦~

## 部署次数问题 ##

没想到动态Pages是有每日部署次数限制的！所以不能重复部署太多次，否则就只能等到第二天再修改了...


  [1]: https://blog-img-1251828412.image.myqcloud.com/2018/02/11/881741996.jpg!webp_1920w