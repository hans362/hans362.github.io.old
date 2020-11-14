title: 记一次黑苹果下 AMD 显卡驱动注入经历
date: 2019-08-22 16:46:43
toc: true
categories: 技术向
tags: []
thumbnail: https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.47.04.png!webp_1920w
---
~~不要问我为什么刚用 Ubuntu 体验完了伪 macOS 却又格盘玩起了黑苹果～~~

<!--more-->

## 0x01 前言（都是废话 ##

简单讲一下我的黑苹果安装过程吧～由于电脑支持 UEFI ，咱就选择用 GPT+Clover 的方式安装黑苹果啦～

刚开始，一切进行得十分顺利～写 U 盘、格盘分区、安装系统、配置引导一条龙走下来就看到 macOS Mojave 标志性的暗色主题桌面

然而...在使用过程中却发现系统异常的卡顿，Dock 和顶栏的半透明效果也没有出来，窗口边缘还有明显的粗糙锯齿和黑线......

~~凭借咱多年的经验~~这一看就是显卡没有驱动嘛......

点开「关于本机」一看果不其然，显存仅有 8MB 且显卡型号也没有识别出来～

然而咱这显卡貌似比较冷门：AMD Radeon R9 290（无 X ）4GB 显存版，远景论坛上找了一圈只找到 R9 290 X 的驱动方式，而且早已是几年前的帖子了，对于最近的 Mojave 版本估计不起作用了

不过凭借着咱翻国外论坛的技术，还是找到了利用 Clover 注入显卡 ID 从而实现驱动的办法～

## 0x02 核对显卡配置 ##

首先要核对一下我们用的是不是同一款显卡，不然该文章可能导致您白忙活......

参照此链接可快速判断你的 AMD 显卡型号：https://www.amd.com/zh-hans/support/kb/faq/gpu-55

~~什么？！你是 N 卡用户？那你来这干什么啊qwq~~

请确保「子系统供应商 ID」为 1002 ，「设备 ID」为 67B1 ，完整的型号是 AMD Radeon R9 290

[Device Hunt](https://devicehunt.com/) 截图如下：

![](https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.29.12.png!webp_1920w)

到这里都符合的话就可以继续看下去啦～

## 0x03 注入驱动 ##

### 打开 「Clover Configurator」 ###

![](https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.34.06.png!webp_1920w)

（如果你不知道这是啥说明本文并不适合你w）

### 挂载 EFI 分区 ###

![](https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.36.08.png!webp_1920w)

挂载完成后用 「Clover Configurator」 打开该分区中的 config.plist 文件

### 设备设置 ###

![](https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.38.35.png!webp_1920w)

在 仿冒 ID - ATI 中 输入 0x67B01002

### 显卡设置 ###

![](https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.40.34.png!webp_1920w)

「FB 名称」设置为 Hawaii ，「显存」设置为 4096 ，「显卡端口」设置为 4 ，Display-cfg 设置为 067B0100 2

最后勾上「注入 ATI/AMD 显卡」即可

### 保存 ###

这个别忘了...

## 0x04 后续操作 ##

重启你的电脑...

Then, enjoy~

![](https://blog-img-1251828412.image.myqcloud.com/2019/08/22/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-08-22%20%E4%B8%8B%E5%8D%883.45.45.png!webp_1920w)