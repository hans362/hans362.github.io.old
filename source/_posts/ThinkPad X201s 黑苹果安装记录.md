title: ThinkPad X201s 黑苹果安装记录
date: 2020-04-17 18:49:27
toc: true
categories: 技术向
tags: []
thumbnail: https://blog-img-1251828412.image.myqcloud.com/2020/04/19/15872677873187.jpg!webp_1920w
---
继上次给这台 ThinkPad X201s 更换了 SSD 以后，想着既然都换了 SSD 怎么能不尝尝黑苹果的滋味呢w

然而很不幸的是网络上几乎没有任何关于 ThinkPad X201s 黑苹果安装的有效信息，只有几篇关于 X201 和 X201i 的，于是在踩了特别特别多的坑以后决定还是在这里记录一下完整的安装过程吧～

![](https://blog-img-1251828412.image.myqcloud.com/2020/04/19/15872678074060.jpg!webp_1920w)

<!--more-->

## 硬件配置

确认一下你使用的是 ThinkPad X201s 而不是 X201i 也不是 X201 哟～

即使是 ThinkPad X201s，也有下图中的一堆版本，我使用的这台型号是 5129A15，即下图中的第一个

![](https://blog-img-1251828412.image.myqcloud.com/2020/04/17/15871187142331.jpg!webp_1920w)

当然，如果你的型号并非 5129A15 也不用太担心，毕竟它们都是 X201s 系列的，硬件差别应该来说不会太大，理论上同样可以成功

核对以下关键信息：

主板芯片组：Intel QM57
CPU：Intel Core i7 640LM Arrandale
内建LCD分辨率：1440*900
显卡：Intel GMA 5700 MHD

## 安装目标

由于 X201s 使用的是传统 BIOS，因此不得不采用 BIOS+MBR+Chameleon 的引导方案，同时又考虑到这台笔记本可怜的那点性能，决定安装有那么些古老的 OS X Yosemite

目前能够实现：
* 显卡被正常驱动（顶栏及 Dock 可实现透明效果，LaunchPad 不卡顿）
* 声音正常（内置麦克风扬声器以及3.5mm接口均可正常使用）
* 千兆以太网卡正常
* USB 接口正常
* SSD Trim 正常开启

已知问题如下：
* 内置 Intel 无线网卡无解（可通过购买免驱无线网卡解决）
* VGA 无输出（据说 UltraBay 上的 DisplayPort 接口可用，可通过购买 UktraBay 扩展坞或购买 USB 转 VGA 解决）
* 电池不被识别（一直都是插着电使用，并无大碍）
* 睡眠会一睡不醒（几乎用不到这个功能，并无大碍）

## 安装过程

### 配置 Chameleon 引导并给黑苹果分区

通过 EasyBCD + wowpc.iso 为电脑添加 Chameleon 启动项

注意选择合适的 Chameleon 版本，Yosemite 需要 2388 版本以上

为黑苹果创建一个分区（建议>=30GB），压缩卷-新建简单卷-不要格式化，得到一个文件系统为 RAW 的分区，作为黑苹果系统盘

### 写入安装镜像至 U 盘

推荐下载懒人版 10.10.5（为什么推荐这个版本呢？看下文你就知道了）镜像（Yosemite Install(XXXXX).cdr 格式），省事省力，特别适合我这种懒癌晚期患者

使用 TransMac 写入**空白** U 盘（容量建议>=7GB）来制作安装盘

**空白意味着你需要在 Windows 自带的磁盘管理中删除 U 盘里的所有分区，然后新建简单卷-不要格式化，得到一个文件系统为 RAW 的单分区 U 盘，此时才可以用 TransMac 写入镜像**

**如果你的 U 盘文件系统为 NTFS 之类的话，很可能会在之后安装到一半时出现 提取软件包“Essentials.pkg”的文件时出错 的错误**

### 安装 Windows 下读写 HFS+ 文件系统的工具

需要小心的是，目前满大街流传的破解版 HFS+ For Windows 10 可能导致 Win 10 蓝屏无法启动

建议**到官方网站**下载 MacDrive 或 Paragon HFS+ For Windows，可以免费试用5天，足够黑苹果的安装

其中 MacDrive 不太推荐，因为它同样使我的电脑突然蓝屏了一次，重启之后才恢复正常

**需要注意的是，任何在 Windows 下读写 HFS+ 分区的工具都极易破坏 HFS+ 分区的原有文件系统结构，导致黑苹果安装盘或系统盘无法启动，具体表现是 Verbose 下出现 CPU Halted 字样后突然自动关机或者读条读到一半突然自动关机**

**但是后文我们仍需频繁地用到这些工具，因此一旦由于使用这些工具导致黑苹果无法启动，请看本文末尾的疑难解答**

### 给安装盘添加驱动及 Chameleon 配置

重点来啦～因为 X201s 的一代核心显卡无法被直接驱动，导致如果直接安装会卡在 IOBluetoothController，即显卡驱动失败

得益于国外 InsanelyMac 论坛和国内 PCBETA 论坛的大佬们，一代核心显卡（GMA5700）终于有救了，本文中用到的驱动即来自于这些论坛的大佬们，原帖见本文最后的参考链接

利用读写 HFS+ 的工具在 Windows 下打开黑苹果**安装盘**，然后完成以下操作：

* 进入 /System/Library/Extensions 文件夹中，删除所有 AMD 及 NVDA 开头的 kext 以腾出空间

* 将下面的文件夹中所有的 kext 丢进 /System/Library/Extensions 文件夹中，遇到重复选择替换

https://github.com/hans362/ThinkPad-X201s-Hackintosh/tree/master/System/Library/Extensions

* 将下面的文件夹中所有的 kext 丢进 /Extra/Extensions 文件夹中，遇到重复选择替换

https://github.com/hans362/ThinkPad-X201s-Hackintosh/tree/master/Extra/Extensions

* 打开 /Extra/org.chameleon.plist，改为如下代码：

```
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">

<plist version="1.0"> 
  <dict> 
    <key>EthernetBuiltIn</key>  
    <string>Yes</string>  
    <key>GenerateCStates</key>  
    <string>Yes</string>  
    <key>GeneratePStates</key>  
    <string>Yes</string>  
    <key>Graphics Mode</key>  
    <string>1440x900x32</string>  
    <key>GraphicsEnabler</key>  
    <string>Yes</string>  
    <key>Kernel</key>  
    <string>/System/Library/Kernels/kernel</string>  
    <key>Kernel Flags</key>  
    <string>kext-dev-mode=1 darkwake=0 dart=0</string>  
    <key>Timeout</key>  
    <string>5</string>  
    <key>USBBusFix</key>  
    <string>Yes</string> 
  </dict> 
</plist>
```

此时可以重启进入 Chameleon 加上 -v -f 参数尝试引导啦～运气好的话可以顺利进入安装界面～

但是正如上文说到的那样，如果在 Verbose 过程中出现 CPU Halted 字样突然自动关机，说明安装盘的文件系统结构在添加驱动后出现了问题，解决方法见本文末尾的疑难解答

### 黑苹果系统安装

先到磁盘工具格式化黑苹果**系统盘**（注意别格错了），再安装即可

安装会比较久，期间如果黑屏不用紧张，可点一下鼠标或触摸板来唤醒屏幕

装完后需要启动 WinPE 重新激活 Windows 分区，否则会出现 Missing Operating System 之类的提示

### 给系统盘添加驱动及 Chameleon 配置

进入 Windows，利用读写 HFS+ 的工具在 Windows 下打开安装盘和系统盘，然后完成以下操作：

* 将黑苹果**安装盘**下的 /Extra 文件夹拷贝到黑苹果**系统盘根目录**下

* 进入黑苹果**系统盘** /System/Library/Extensions 文件夹中，删除所有 AMD/NVDA/GEFORCE/ATI 开头的 kext

* 将下面的文件夹中所有的 kext 丢进黑苹果**系统盘** /System/Library/Extensions 文件夹中，遇到重复选择替换

https://github.com/hans362/ThinkPad-X201s-Hackintosh/tree/master/System/Library/Extensions

### 完成安装

重启电脑进入 Chameleon，移动光标至黑苹果系统盘，加入 -v -f 参数尝试启动，不出意外就会出现刚安装完苹果系统时的设置选项了

但是正如上文说到的那样，如果在 Verbose 过程中出现 CPU Halted 字样随后突然自动关机，说明安装盘的文件系统结构在添加驱动后出现了问题，解决方法见本文末尾的疑难解答

剩下就只需要和白苹果一样按部就班地设置好键盘、用户账户之类的即可，完事就可以看到桌面啦～

此时顶栏和 Dock 应该都是半透明的了，显卡可以正常工作，打开 LaunchPad 不会卡顿或花屏，播放视频也不会卡顿，黑苹果就基本完美啦～

![](https://blog-img-1251828412.image.myqcloud.com/2020/04/18/15872089033718.png!webp_1920w)

![](https://blog-img-1251828412.image.myqcloud.com/2020/04/18/15872089032900.png!webp_1920w)

![](https://blog-img-1251828412.image.myqcloud.com/2020/04/18/15872089367163.png!webp_1920w)

## 小建议

### 开启 TRIM

对于 SSD 用户来说，如果你不想让 SSD 提前暴毙，那么最好开启 TRIM

但是，据大量用户反映 Yosemite 在使用第三方 TRIM Enabler 之后会出现禁止符，无法开机

因此开启 TRIM 的最好方法就是升级到 OS X Yosemite 10.10.5（当然你可以一开始就选择 10.10.5 的安装镜像），然后用原生指令打开 TRIM，黑苹果升级有风险，升级完需要再次覆盖驱动

然后只需要打开终端执行：

```
sudo trimforce enable
```

期间输入密码，按 Y 回车，电脑会自动重启，再次进入系统后就会发现 TRIM 开启成功啦～

![](https://blog-img-1251828412.image.myqcloud.com/2020/04/18/15872089220381.jpg!webp_1920w)

### 来一次全盘备份

适合和我一样喜欢瞎搞的人～

可以用 Ghost 或者 OS X 自带的时光机把整个黑苹果系统分区备份一遍，万一某一天手残升级失败了或者装了一些奇奇怪怪的东西开不了机了，有备份在就省去了重装黑苹果的大把时间～

### 卸载 Windows 下读取 HFS+ 的工具

强烈建议安装完成后尽快卸载，不然你就会像我一样突然有一天进不去黑苹果，读条读到一半突然自动关机，Verbose 出现 CPU Halted 字样

如果你不幸已经出现了这种事情，请看下面👇

## 疑难解答

### CPU Halted 突然自动关机怎么办

别慌，问题不大

进入 Chameleon 后选择你要进入修复的盘（安装盘或系统盘），加上参数 -v -s -f 不出意外你会顺利进入单用户命令行模式

执行 `/sbin/fsck -fy` 运行磁盘检查，多半会查出类似于 Invalid Node Structure 的错误，并且会告诉你这个分区对应的 Identifier（类似于 /dev/disk0s2）

执行 `/sbin/fsck_hfs -yprd /dev/disk0s2` 其中 `/dev/disk0s2` 请务必换成你的 Identifier！！！

然后就是漫长的等待，可能需要十几分钟左右，期间屏幕会一直滚信息，对你的文件系统进行详细的检查和修复，如果感兴趣你可以看看都是哪里出现了问题，到最后可能会告诉你修复失败，不过不用慌，再运行一次 `/sbin/fsck -fy` 就会看到 Repaired successfully 之类的提示

执行 `reboot` 进入 Chameleon 再次尝试启动即可

最后别忘了在整个黑苹果安装完成后进 Windows 卸载掉读写 HFS+ 的软件，不然小心重蹈覆辙

### Transmac 出现“Could not write to Mac Volume”无法写入怎么办

能否顺利写入 U 盘似乎完全是玄学，建议开一台 Windows 7 虚拟机再试试，我就是这样才成功的

### 提取软件包“Essentials.pkg”的文件时出错怎么办

请再去好好读一读上文¯\_(ツ)_/¯

当然也可能是你下载的镜像破损造成的，请在下载完成后校验 MD5 值

### 设置系统时卡在“正在创建账户”怎么办

这似乎是一个 BUG，其实此时账户已经创建好了，但是因为某些原因就一直卡在了这一步

解决方法是卡在这里时强制关机，再次开机设置系统，到了创建账户的步骤时随便建一个临时账户，进入桌面后注销当前帐户，切换回最初的账户，再到偏好设置里把临时账户删掉即可

## 后记

得益于之前更换的 SSD，Chameleon 去掉 -v -f 参数后启动黑苹果大约在 30s 左右，系统体验非常舒适，打开应用程序不会在 Dock 上弹跳老半天，总之是非常适合日常使用的～

但是也有个最大的问题，就是 Yosemite 和最新的 Catalina 相比已经落后了不知多少个版本，许多应用软件都无法运行在 Yosemite 上（如 Office 2019 / WPS / 钉钉 / iWork / 腾讯柠檬 / Homebrew 等），目前只能用 Office 2016 代替 2019，用腾讯电脑管家代替腾讯柠檬（别说还真的挺好用的

似乎升级到 EI Captain 体验会更好，但是我没敢跨大版本升级，主要怕驱动不支持比 Yosemite 更高的版本，各位持有 X201s 的也可以尝试一下用 EI Captain 的镜像搭配本文中所给的驱动进行安装～

最后祝所有的 Hackintosher 们早日吃上黑苹果～

## 参考链接

特别感谢以下文章的作者们～❤️

1. [联想Thinkpad x201 i5 560M osx 10.10.3 一代集显QE/CI完美,声音亮度变频正常](http://bbs.pcbeta.com/forum.php?mod=viewthread&tid=1600281)
2. [[GUIDE] 1st Generation Intel HD Graphics QE/CI](https://www.insanelymac.com/forum/topic/286092-guide-1st-generation-intel-hd-graphics-qeci/)
3. [修复 OS X 的系统盘出现 Invalid Node Structure 问题](https://www.cnblogs.com/Ricky81317/p/5292651.html)
































