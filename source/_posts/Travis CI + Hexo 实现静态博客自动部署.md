title: Travis CI + Hexo 实现静态博客自动部署
date: 2020-03-28 17:40:22
toc: true
categories: 技术向
tags: []
thumbnail: https://blog-img-1251828412.file.myqcloud.com/2020/03/28/15853848385002.jpg
---
> 本文使用 MWeb Markdown 编辑器写于 iPad Air 2，利用 iOS 端迄今为止最佳的可视化 Git 工具 Working Copy 提交至博客仓库，经 Travis CI 自动构建后自动发布至 GitHub Pages。

以上是我最理想的写博客的流程，而今天我终于实现啦！😆

众所周知，静态博客的一大特点就是没有管理后台，因此常规的操作流程一般是写文章-丢进_posts文件夹-手动执行构建-发布。事实上我也一直是这么干的，得益于 Coding 的 CloudStudio，我至少可以不用电脑随时随地执行这套繁琐的操作，觉得这样将就用着也还能接受。但是最近发现 CloudStudio 经常卡半天进不去，再加上 Coding 升级后混乱的用户体验（个人版、企业版、团队版、腾讯云开发者全部杂糅在一起），我还是决定放弃这套糟糕的流程。

所以，不如咱就试试让 Travis CI 替咱做掉这些繁琐的工作吧！

<!--more-->

## 需求分析

我想要达到的最终目标是只需要向存放文章的仓库推送 Markdown 文件，就会自动触发 Travis CI 从文章仓库拉取文章，配置环境，自动生成静态文件，自动部署至 GitHub Pages，也就是说，我只要安安心心的写好文章并提交推送，剩下的事情 Travis CI 都会帮我做好。

## 方案设计

首先需要两个 GitHub 公共仓库：

hexo-theme-hans362 //存放 Hexo 博客主题文件（基于 ICARUS 二次修改）
𠃊master //默认分支

文件结构：

![](https://blog-img-1251828412.file.myqcloud.com/2020/03/28/15853825237235.jpg)

hans362.github.io //博客主仓库
𠃊source //默认分支，存放 Markdown 文章和相关配置文件
𠃊master //GitHub Pages 分支，存放生成的静态文件

文件结构：

![](https://blog-img-1251828412.file.myqcloud.com/2020/03/28/15853825371753.jpg)

![](https://blog-img-1251828412.file.myqcloud.com/2020/03/28/15853825532780.jpg)

多分支的那个仓库 source 分支可以这样操作：

```
git init
git remote add origin git@github.com:hans362/hans362.github.io.git
git checkout --orphan source
git add .
git commit -m "First commit"
git push origin source:source
```

iPad 上写文章时只需要在 Working Copy 里 clone 主仓库下的 source 分支，写好文章后 commit + push 就完事啦～

## 构建脚本

重点其实是在这，在 Travis CI 能帮你干活之前你至少得先教会人家应该怎么做，对吧？(≧∇≦)

存放于主分支 source 下的 `.travis.yml` 就是你和 Travis CI 沟通的桥梁。

下面就是我的 `.travis.yml`：

```
language: node_js
node_js: lts/*

branches:
  only:
  - source

cache: npm

before_install:

# 配置 Git 信息
- git config --global user.name "Hans362"
- git config --global user.email "i@hans362.cn"
# 赋予部署脚本可执行权限（很重要！不然你就会像我一样死活部署不上去w）
- chmod +x .travis/deploy.sh

install:

# 检测主题是否存在，不存在就 clone 一个
- if [ ! -d "themes/icarus" ]; then git clone ${THEME} themes/icarus; fi
# 安装依赖
- npm install

script:

# Hexo 生成静态页面
- hexo clean
- hexo generate

after_success:

# 部署（这里把部署的操作单独写到了另一个脚本文件里）
- .travis/deploy.sh

# 环境变量
env:
    global:
        # 主仓库地址
        - GH_REF: https://hans362:${GITHUB_TOKEN}@github.com/hans362/hans362.github.io.git
        # 主题仓库地址
        - THEME: https://hans362:${GITHUB_TOKEN}@github.com/hans362/hexo-theme-hans362.git
```

因为我把部署脚本单独拎出来了，所以还需要在 source 分支下创建一个 .travis 文件夹，里面写好 `deploy.sh` 脚本：

```
#!/bin/bash
set -ev
# 设置时区
export TZ='Asia/Shanghai'

# 先 clone 避免 force commit
git clone -b master ${GH_REF} .deploy_git

cd .deploy_git
git checkout master
mv .git/ ../public/
cd ../public

git add .
git commit -m "Site updated: `date +"%Y-%m-%d %H:%M:%S"`"
# 推送到主仓库的 master 分支
git push origin master:master --force --quiet
```

然后细心的你可能发现了上面配置文件中有两个 `${GITHUB_TOKEN}`，这里应该填写你的 GitHub Personal Access Token，不知道这是啥的自行解决，总之需要生成一个并且牢牢记住。当然我相信你不会笨到直接把脚本里的 `${GITHUB_TOKEN}` 替换成你的 TOKEN，因为存放配置文件的仓库是向世界公开的，这样做无疑于引狼入室。

正确做法就是把 `${GITHUB_TOKEN}` 原封不动的留在那，然后到 Travis CI 中设置环境变量，变量名为 GITHUB_TOKEN，变量值为你牢牢记住的那个 TOKEN，这样当代码运行至这一行时就可以从 Travis CI 中自动读取到你的 TOKEN 并完成替换。

![](https://blog-img-1251828412.file.myqcloud.com/2020/03/28/15853840923226.jpg)

至此，构建脚本就配置完成了。

## Now, enjoy~

如果一切无误的话，你可以尝试推送一篇文章到主仓库的 source 分支，这会触发 Travis CI 按照你教TA的步骤完成后续的一系列操作，你只需要静静地喝杯茶，在一分钟后打开你的博客，就可以看到你写的新文章啦～

![](https://blog-img-1251828412.file.myqcloud.com/2020/03/28/15853843896828.jpg)

## 参考链接

非常感谢以下文章作者～

1. [使用 Travis CI 自动部署 Hexo 博客](https://printempw.github.io/deploy-hexo-blog-automatically-with-travis-ci/)
2. [使用Travis-CI持续构建Hexo博客](https://www.jianshu.com/p/f8fb2d949c95)