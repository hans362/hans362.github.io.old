title: 给你的 Ubuntu GNOME 桌面带来类 Mac OS 的体验 
date: 2019-07-24 17:09:00
toc: true
categories: 技术向
tags: []
thumbnail: 
---
前段时间~~吃饱了撑的~~拆了台废旧的笔记本电脑，主板已经被玩坏了，拿去修成本太高，因此我就把里面的硬盘拆下来玩玩～硬盘的型号是 Seagate Momentus PSD 160GB 混合型硬盘，接口是 SATA ，于是弄了个笔记本硬盘盒一装，S.M.A.R.T. 信息、坏道检测都没有问题呢，就变身我的移动硬盘啦～

正巧一直想要给电脑搞个 Linux 系统，就参照了 [Little_Qiu](https://www.littleqiu.net/) 大佬的一篇文章：

- [Ubuntu To Go | 制作属于你的随身 Ubuntu 系统盘](https://www.littleqiu.net/archives/771)

我将可爱的 Ubuntu 18.04.2 LTS 顺利装进了口袋里～n(*≧▽≦*)n

可惜...个人不太喜欢 GNOME 默认的拟物化主题...（可能也有挺多人喜欢的吧qwq...）所以决定给咱的 Ubuntu To Go 来个大改造！

毕竟，

> 好看是第一生产力。（雾

![](https://blog-img-1251828412.file.myqcloud.com/2019/07/19/2019-07-19 16-27-27 的屏幕截图.png)

（上图即为最终效果图）

So...这篇文章就诞生啦！

<!--more-->

## 准备工作 ##

### 系统环境 ###

本文所使用的 Ubuntu 系统版本是 Ubuntu 18.04.2 LTS-amd64 ，运行的是默认 GNOME 3 桌面，未进行任何改动，其他 Ubuntu 版本由于精力有限我没有测试过，不能保证本文的教程完全适用于您的系统。

如果您想一次性成功...建议您还是重装系统至相同版本呢～

### 更换源 ###

什么？你告诉我国内有那么多速度快到飞起的大学开源软件源你却放着不用？（当然身处国外的大佬们当我没说...

如果不更换软件源呢，由于一些我们都知道的原因，在进行软件安装时速度怕不是会慢到你怀疑人生～

要是你不在意.....咳咳......当我没说...

至于怎么更换我相信各位都知道就算不知道也知道该去哪里让自己知道～（突然口胡

### 其他需要的物品 ###

1. 一台运行着上述操作系统的电脑，内存建议>=4GB ，另外尽量上A卡或N卡，I卡用户需要注意后文有些插件不能开启（会在相应插件处标明的），否则可能花屏闪瞎你的眼。
2. 互联网连接。
3. ~~你的脑子~~。

## 开工！ ##

### 软件包安装 ###

直接无脑打开 Terminal 运行以下指令即可：

```
sudo apt install gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell
```

### 主题安装 ###

下载以下文件（主题作者： [vinceliuice](https://github.com/vinceliuice) ）

1. [亮色主题](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/Sierra-light-thin.tar.xz) / [暗色主题](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/Sierra-dark-thin.tar.xz) （根据个人喜好二选一下载）
2. [亮色图标](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/MacOSX-icons.tar.xz) / [暗色图标](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/MacOSX-dark-icons.tar.xz) （根据个人喜好选择，但是**注意亮色图标只需下载亮色图标文件，暗色图标则二者都需要下载**）
3. [鼠标指针](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/MacOSX-cursors.tar.xz)

以上链接为方便均从本博客图片服务器上下载，如果不放心也可自行前去作者 GitHub 下载。

下载完成后将所有压缩包解压，并存放于下列相应的文件夹中：

- 主题文件 /usr/share/themes
- 图标文件 /usr/share/icons
- 鼠标指针文件 /usr/share/icons

### 插件安装 ###

使用 Ubuntu 自带的 FireFox 浏览器，访问 [GNOME Shell Extensions](https://extensions.gnome.org/) ，首次访问会提示安装浏览器插件。需要注意的是， Ubuntu 自带的 FireFox 并非最新版本，会导致浏览器插件可能无法正常安装，所以强烈建议：

```
sudo apt update
sudo apt install firefox
```

浏览器插件安装完成后，在 [GNOME Shell Extensions](https://extensions.gnome.org/) 依次搜索并安装以下插件（只需无脑 ON 即可）

1. Appfolders Management Extension

2. Blyr（I卡用户注意慎用，一旦出现异常请立刻关闭）

3. Coverflow Alt-Tab

4. Dash to Dock

   该插件需要额外配置，右键你的 Dock 点击 Dash to Dock 设置：

   ![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-28-56屏幕截图.png)

   参照下图进行配置：

   ![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-30-04屏幕截图.png)
   
   ![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-29-53屏幕截图.png)
   
   ![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-29-41屏幕截图.png)
   
   ![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-30-14屏幕截图.png)
   
5. Frippery Move Clock

6. Poppy Menu

   该插件需要额外配置，左上角的图标并不是小苹果，需要自行调整。

   在` ~/.local/share/gnome-shell/extensions/Poppy_Menu@dies/Resources `中将两个 `.svg` 的图片替换成小苹果即可。

   点击 小苹果 你会发现菜单全是英文，可在 `~/.local/share/gnome-shell/extensions/Poppy_Menu@dies/ ` 手动翻译一下。

7. Gnome Global Application Menu

8. User Themes

9. Removable Drive Menu

### 主题配置 ###

打开 **优化** 应用程序 (**Gnome Tweak Tool**) ：

![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-12-58 的屏幕截图.png)

按以下图片进行配置：

![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-39-40屏幕截图.png)

![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-39-13屏幕截图.png)

![](https://blog-img-1251828412.file.myqcloud.com/2019/07/24/2019-07-24 16-38-57屏幕截图.png)

需要注意的是，苹方 字体需要自行下载并安装哦～

## 后记 ##

到这里为止，你的 Ubuntu 系统已经和 Mac OS 有着 90% 的相似度了，当然还有许多细节没有完善。比如开机动画、登录界面等，我也曾按照他人的教程尝试过这些方面的美化，但并未成功，留给各位自己去探索啦～

怎么样，是不是很简单？（好吧我承认太复杂了写这篇文章就累得半死还是买 Mac 吧

## 鸣谢 ##

非常感谢以下文章作者：

[教程：为你的linux桌面带来Mac OS Mojave的体验](https://zhuanlan.zhihu.com/p/37852274)

[Ubuntu18.04(Gnome)环境，十分钟配置Mac OS主题](https://zhuanlan.zhihu.com/p/71588449)

我参照了以上文章，亲手尝试后针对 Ubuntu 18.04.2 LTS 从头重写整合了这篇教程，并在原文中没有提到的注意点做了补充、错误疏漏的地方进行了修改。