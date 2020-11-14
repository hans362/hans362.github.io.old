title: PHP踩坑记录#1
date: 2019-02-18 16:40:00
toc: true
categories: 技术向
tags: []
thumbnail: https://blog-img-1251828412.image.myqcloud.com/2019/05/11/code-944499_1280.jpg!webp_1920w
---
这段时间在开发[追番列表展示API][1]（人生中第一个PHP项目啊...），迫于没有系统地学习过PHP只是略知一二，在开发的过程中可以说是到处是坑，于是乎....在我努力地现学现卖的过程下，还是~~顺利~~地写完了这个程序

至于运行的效率以及代码质量么....不管了....（自信

![](https://blog-img-1251828412.image.myqcloud.com/2019/02/18/ybsbny.jpeg)

那么针对踩过的坑就记录一下吧~（先说明一下 PHP 版本为7.1.26）

<!--more-->

## 0x01 PHP 调用 API ##

本案例中 API 为 BiliBili 的 Bangumi API：

``https://space.bilibili.com/ajax/Bangumi/getList?mid={user.id}``

其中``{user.id}``为用户的UID

正确请求后可得到 json 返回该用户的追番列表

那么 PHP 应该如何调用这个 API 并将返回的 json 存储于变量中呢？

首先建立一个 function
```
function curl_get_https($url) {
    $curl = curl_init(); // 启动一个CURL会话
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1); // TRUE 将curl_exec()获取的信息以字符串返回，而不是直接输出。
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false); // 跳过证书检查
    $tmpInfo = curl_exec($curl); // 返回api的json对象
    curl_close($curl);
    return $tmpInfo; // 返回json对象
    
}
```

搞定后程序中就可以随时调用这个function

```
$uid = $_GET["uid"]; //获取提交的UID
$file = curl_get_https('https://space.bilibili.com/ajax/Bangumi/getList?mid=' . $uid);
```
这样返回的json就被存储于`$file`变量中了

## 0x02 PHP 解析 Json ##

假设 json 数据已经存储与`$file`变量中，解析 json 非常简单：

```
$res = json_decode($file);
```

但是请注意，这种方式 json 将以 StdClass Object 的形式存储，如果需要以 Array 的形式存储，则应该这样：

```
$res = json_decode($file, true);
```

### StdClass Object 的进一步解析 ###

假设解析后的内容存储于`$res`中，`$res`下有一个分项叫`data`，`data`下有一个分项叫`pages`，那我要获取`pages`的值，应该怎么办呢？

``
$pages = $res->data->pages;
``

这样就可以将`pages`的值存储于`$pages`中

### Array 的进一步解析 ###

假设解析后的内容存储于`$res`中

首先要清楚 Array 的结构，用以下代码可输出：

``
print_r($res);
``

接着就要用到`foreach()`函数一层层完成遍历，相关用法不再赘述，可自行查找相关资料

## 0x03 For 循环的简单应用 ##

```
for ($x = 1; $x <= 10; $x++) {
// Put your code here.
}
```

以上代码可完成`$x`从1至10的循环

## 0x04 PHP 下载文件 ##

假设要下载到运行目录下的 cache 目录，下载链接存储于`$url`变量中

```
$url = $result['cover'];
$path = 'cache/';
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
$img = curl_exec($ch);
curl_close($ch);
$filename = pathinfo($url, PATHINFO_BASENAME);
$resource = fopen($path . $filename, 'a');
fwrite($resource, $img);
fclose($resource);
```

## 0x05 PHP 判断一个文件是否存在 ##

假设文件名存储于`$filename`变量中

```
if (file_exists($filename)) {
  return true;
} else {
  return false;
}
```

好啦暂时就整理这么多，由于本人没有系统地学习过 PHP，本文中的部分表述可能存在漏洞或描述不清，各位大佬轻喷....如果您发现本文中有错误请务必在下方评论区指出，我会感激不尽~

[1]: https://blog.hans362.cn/%E3%80%90%E9%A1%B9%E7%9B%AE%E5%8F%91%E5%B8%83%E3%80%91%E8%BF%BD%E7%95%AA%E5%88%97%E8%A1%A8%E5%B1%95%E7%A4%BAAPI/