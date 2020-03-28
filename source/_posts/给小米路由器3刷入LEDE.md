title: 给小米路由器3刷入LEDE
date: 2018-08-22 02:00:00
toc: true
categories: 技术向
tags: []
thumbnail: https://blog-img-1251828412.file.myqcloud.com/2018/08/22/3280075319.png
---
没错，继[给小米路由器3刷入Pandavan][1]之后我这个刷机狂魔又来啦~

这段时间翻了翻恩山无线论坛发现小米路由器3已经有非官方LEDE固件了呢！果断决定刷刷看...

**预警：如果您准确按照本文的操作步骤操作，一般是不会出问题的，当然不排除刷坏的可能，变砖了赶快去买彩票，别来找我╮(￣▽￣"")╭**

**预警²：本文使用的固件非官方固件，而是ptpt52为推广natcap而自行编译的固件，目前经我测试一切正常，若您需要纯净固件请留意LEDE官网有无官方固件发布**

<!--more-->

## 0x01 准备开刷 ##

首先请确认您的设备真的是小米路由器3（背面型号：MI R3）哟～其他设备比如R3G可别拿来这么刷，否则...你懂的

### 以下材料务必提前准备好哟 ###

 - 小米路由器3（废话并且需要恢复小米官方固件哦）

 - 牙签（开启SSH时要用到）

 - 充足的时间和精力&不怕刷砖掉的强大内心&你的脑子

### 确保已准备好以下文件 ###

 - 固件（请去 https://router-sh.ptpt52.com/rom/ 下载）
   只需下载如下图两个即可：（rootfs0和kernel1）
   ![lede1.PNG][2]

## 0x02 开启SSH ##

请参照 http://www.miui.com/thread-4529081-1-1.html 此处不再赘述

## 0x03 刷写固件 ##

将下载好的两个固件通过SFTP上传到/tmp目录下，并改名为rootfs0.bin和kernel1.bin（方便后面操作）

SSH连接路由器，并执行以下命令：
```
    # 进入目录
    cd /tmp
    # 开启串口（非常重要！万一刷坏了这可是救命的）
    nvram set flag_last_success=1
    nvram set boot_wait=on
    nvram set uart_en=1
    nvram commit
    # 正式刷写
    mtd write kernel1.bin kernel1
    mtd write rootfs0.bin rootfs0
    # 重启
    reboot
```

## 0x04 连接网络 ##

可以使用网线直接连接，也可以连接WiFi（SSID：NATCAP_XXXX 密码：88888888）

输入192.168.15.1进入管理界面（用户名：root 密码：admin）

进入后记得修改密码，然后就慢慢折腾吧~ 玩坏了就在系统中重置即可

![lede2.PNG][3]

固件自带$$，酸酸乳需要另行安装，并且经测试酸酸乳不能ipk直接丢上去安装不然会报错，解决方案将在之后的文章中提到~

顺便吐槽一下上海电信还是没给IPV6，He.net隧道好慢啊还是挂酸酸乳吧

## 参考链接 ##

[1]《LEDE 全球首发，支持小米路由3（Xiaomi Mi Router R3）》http://www.right.com.cn/forum/thread-261964-1-1.html
[2]《OpenWrt/LEDE最新固件 适配大量硬件》http://www.right.com.cn/forum/forum.php?mod=viewthread&tid=212965
[3]《[经验技巧] 小米路由器3 开启SSH最简单的方法》http://www.miui.com/thread-4529081-1-1.html


  [1]: https://blog.hans362.cn/%E7%BB%99%E5%B0%8F%E7%B1%B3%E8%B7%AF%E7%94%B1%E5%99%A83%E5%88%B7%E5%85%A5Pandavan/
  [2]: https://blog-img-1251828412.file.myqcloud.com/2018/08/22/1464015853.png
  [3]: https://blog-img-1251828412.file.myqcloud.com/2018/08/22/3280075319.png