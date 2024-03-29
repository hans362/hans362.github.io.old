title: UTF8-BOM编码导致Html顶部白条问题
date: 2018-03-09 12:31:00
toc: true
categories: 技术向
tags: []
thumbnail: 
---
自从给博客加上了Google Adsense的广告，就出现了一个很困扰我的问题：网页顶部莫名空出了一个白条。虽然对于网页的访问没有什么影响，但是...强迫症不能忍啊！这一切的背后，~~究竟是人性的扭曲，还是道德的沦丧~~，请阅读本篇文章～（大雾


<!--more-->


## 0x01 问题分析 ##

嗯...遇到html问题先浏览器F12一下，立刻就发现了异常，在body部分的开头出现了如下代码：
```
"
    

"
```
经过测试，顶部的白条确实是由于这串代码造成的，可是我并没有蠢到会去写这个啊喂！那么究竟是什么原因呢？

## 0x02 排除法发现问题 ##

首先由于是加入了Google Ads之后才出现的情况，第一时间想到的就是先去掉广告代码。可是去掉后重新部署依然出现该问题，已基本确定并非Google Ads造成。

紧接着我想到去翻一翻Coding的提交历史，对几个历史版本进行逐行对比，最终我把目光锁定在了这里：

![https://blog-img-1251828412.image.myqcloud.com/2018/03/09/9E55D822-DEAB-4066-9F58-DD15A8291299.jpeg!webp_1920w][1]

咦？第一行中两个相同的<为什么会显示不同呢？由于代码是在Windows上面修改的，而很多奇奇怪怪的编码问题都发生在Windows上面，所以我的第一反应就是编码问题。

因为写代码比较喜欢用Notepad++，就检查了一下Header.php的编码，发现竟然是带BOM格式的UTF8！

![https://blog-img-1251828412.image.myqcloud.com/2018/03/09/4CA2B09C-ED99-4327-9AAC-846CFDD02A32.jpeg!webp_1920w][2]

那么什么是BOM呢？

UTF-8 BOM又叫UTF-8 签名，其实UTF-8 的BOM对UFT-8没有作用，是为了支援UTF-16，UTF-32才加上的BOM，BOM签名的意思就是告诉编辑器当前文件采用何种编码，方便编辑器识别，但是BOM虽然在编辑器中不显示，但是会产生输出，就像多了一个空行。

这多出来的一个空行就造成了网页中顶部的白条，也解释了前面为什么在提交历史中看似一样的两个<却被识别为不同。哈～原来是BOM的锅～

## 0x03 解决方法 ##

在Notepad++编码中修改成无BOM后重新提交Git并部署，果然问题不再复现。

同时我也发现使用Windows记事本编辑php文件也很可能被加上BOM头，所以没事写代码不要用乱加BOM的编辑器

参考链接：

[1]https://baike.baidu.com/item/BOM/2790364?fr=aladdin
[2]https://www.cnblogs.com/wt645631686/p/6868826.html


  [1]: https://blog-img-1251828412.image.myqcloud.com/2018/03/09/9E55D822-DEAB-4066-9F58-DD15A8291299.jpeg!webp_1920w
  [2]: https://blog-img-1251828412.image.myqcloud.com/2018/03/09/4CA2B09C-ED99-4327-9AAC-846CFDD02A32.jpeg!webp_1920w