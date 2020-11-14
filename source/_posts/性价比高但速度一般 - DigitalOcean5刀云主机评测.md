title: 性价比高但速度一般 - DigitalOcean5刀云主机评测
date: 2018-03-12 09:53:00
toc: true
categories: 测评
tags: []
thumbnail: 
---
DigitalOcean应该算是美国一家比较老牌的云主机商了，经常与Vultr、Linode等廉价的主机商一起出现。作为穷得要死的牛奶，我还是想方设法搞到了一台DO的5刀云主机。（前段时间发现GitHub学生包里还有50刀的DigitalOcean代金券还没有用，嘿嘿不然哪有闲钱买这个啊喂）

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/9108C443-14B1-4F9A-ABAE-6D8C68A44C33.jpeg][1]


<!--more-->


## 账户注册 ##

网址：https://www.digitalocean.com

注册地址（带了我的推广链接，不想点的请直接去主页注册～）：https://m.do.co/c/baf4ba8263d8

注册过程对于学生党来说有一点点小困难，因为作为学生党没有信用卡啊ಥ_ಥ所以只好忍痛往PayPal里砸了5刀用于账户验证（PayPal某宝上有代充的，就不打广告了w）新用户注册可以享有10刀的免费代金券哦～

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/F01D9013-6C7D-448C-9B67-CBFF219E84B4.jpeg][2]

 - 一点小Tips
在添加完新用户的10刀代金券后，大部分有GitHub学生包的人都会发现没法再添加50刀优惠券！这时提交个工单，用英语告诉客服你的状况，并在工单里附上你的代金券代码，请求帮忙激活。英文不好的可以参考一下我的写法：

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/93447F47-071C-4F9B-B2F6-958ECB93332F.jpeg][3]

然后你就会惊喜地发现账户里有65刀啦（5刀PayPal+10刀新用户赠送+50刀GitHub学生包）
a
![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/2E9042A1-D862-4BDC-A699-D5BF0FF3A979.jpeg][4]

## 操作面板 ##

操作面板真的很清晰简洁，但是功能非常全面。配色也是我非常喜欢的蓝灰配色。

这是DigitalOcean VPS主机管理界面，创建VPS主机后，稍等几分钟就可以看到VPS列表了，这里有删除、升级配置、备份、报表和Web控制台等。

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/9D754CBC-AB83-47C2-8285-696E6270DE04.jpeg][5]

这是DigitalOcean VPS主机操作中心，常用的报表、重装、追加硬盘、快照、备份、关机等这些都有。

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/16E71CEE-C82F-44DA-92A0-F88CF30C8D05.jpeg][6]

总得来说，DigitalOcean的控制面板也比较强大，只不过像快照、备份等功能都是需要收费的，大家在开通时需要特别注意。

## 购买价格 ##

这是DigitalOcean的价格表，最便宜的是5美元一个月。

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/79B7122C-B131-4968-8F88-38AC034452AF.jpeg][7]

即使是最便宜的也配备了1G内存、1CPU、25GSSD和1T流量，感觉还是蛮合算的！

## 性能测试 ##

这里我跑了两个测试脚本，UnixBench测运算能力、SpeedBench做综合测试（网络、硬盘IO等）

结果如下：

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/1420CBBD-6529-4B54-87A5-6EBF25B9302D.jpeg][8]

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/410DFD62-44D7-4E2C-95A2-76663E8C0638.jpeg][9]

可以看到UnixBench跑分为700+，还是比较好的。IO也很不错。综合测试下来最令我惊喜的是网络，带宽给的非常足，能达到GB级的水平～

## 网络及可用区 ##

DigitalOcean目前有纽约：NYC1、NYC2、NYC3，旧金山：SFO1，阿姆斯特丹：AMS1、AMS2、AMS3，新加坡：SGP1，伦敦：LON1，印度：BLR1等共计九个机房。前面的测试发现DigitalOcean的机房带宽给得非常充足，不足之处就是这些节点在国内访问都比较慢，线路优化不好。

目前连接国内速度相对较好的就是新加坡和旧金山机房了，其它的如英国、荷兰等线路太远。以下是DigitalOcean机房图。

![https://blog-img-1251828412.image.myqcloud.com/2018/03/12/14B56E20-990F-4E0D-B0CB-E042232C35E3.gif][10]

选择可用区之前可以先在这里测一下速：http://speedtest-nyc1.digitalocean.com/

全国Ping下来基本上都是200-300ms，挺糟糕的，这大概是唯一不足之处吧。

## 总结 ##

本次体验给我的感觉是不错的～算是我目前为止用过的最满意的主机～

从VPS主机的性能与速度测试来看，DigitalOcean表现还是可以的，尤其是机房带宽这一块比较充足。当然，DigitalOcean也有国内访问速度慢的毛病，不过建站的话挂个CDN应该也不成问题。

## 参考链接 ##

[1]https://wzfou.com/digitalocean/


  [1]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/9108C443-14B1-4F9A-ABAE-6D8C68A44C33.jpeg
  [2]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/F01D9013-6C7D-448C-9B67-CBFF219E84B4.jpeg
  [3]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/93447F47-071C-4F9B-B2F6-958ECB93332F.jpeg
  [4]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/2E9042A1-D862-4BDC-A699-D5BF0FF3A979.jpeg
  [5]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/9D754CBC-AB83-47C2-8285-696E6270DE04.jpeg
  [6]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/16E71CEE-C82F-44DA-92A0-F88CF30C8D05.jpeg
  [7]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/79B7122C-B131-4968-8F88-38AC034452AF.jpeg
  [8]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/1420CBBD-6529-4B54-87A5-6EBF25B9302D.jpeg
  [9]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/410DFD62-44D7-4E2C-95A2-76663E8C0638.jpeg
  [10]: https://blog-img-1251828412.image.myqcloud.com/2018/03/12/14B56E20-990F-4E0D-B0CB-E042232C35E3.gif