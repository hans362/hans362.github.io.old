title: 使用WPScan扫描WordPress博客安全性
date: 2018-07-16 07:23:00
toc: true
categories: 技术向
tags: []
thumbnail: 
---
> 写在前面：本文介绍的工具建议仅用于安全性测试，使用请遵守国家规定，本博客不承担任何责任。

最近看到隔壁的[@崇宫苟道][1]的一篇文章[《冻果果？00后网络团队？抄袭？（持续更新ing）》][2]，看完真的是被吓到了...我暂且先不对冻果果的行为做任何评价，毕竟今天的主题是使用WPScan扫描WordPress博客安全性，既然这个冻果果团队自称很厉害，那么就~~免费~~帮他们做下测试吧~

首先感谢[@崇宫苟道][3]给出的信息，该站的首页是个基于WordPress的论坛（真的长见识了...WP也能做论坛）

那么就拿出WPScan扫一下吧~

（前方大量代码块来啦～为避免影响主页效果，文章已折叠，点击下方继续阅读）


<!--more-->


## 准备工作

咳咳...忘了还没讲怎么安装呢

准备一个Linux操作系统，推荐Kali Linux，已经自带WPScan，无需安装

然而本文还是用的WSL的Ubuntu~~不要问为什么~~（手动滑稽

安装一下Git和必备的组件

```
sudo apt-get install libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev build-essential libgmp-dev zlib1g-dev
```

安装Ruby2.3

```
sudo apt-get -y install software-properties-common 
sudo apt-add-repository ppa:brightbox/ruby-ng 
sudo apt-get update
sudo apt-get -y install ruby2.3
sudo apt-get install ruby2.3-dev
gem update --system
gem install rubygems-update
update_rubygems
```

接着Clone一份WPScan并安装

```
git clone https://github.com/wpscanteam/wpscan.git
cd wpscan
sudo gem install bundler && bundle install --without test
```

就OK啦~

![捕获.PNG][4]

## 小试牛刀

运行`./wpscan.rb`就可以看到说明啦~

```
    hans362@WIN-562CUJC625F:~/wpscan$ ./wpscan.rb
    _______________________________________________________________
            __          _______   _____
            \ \        / /  __ \ / ____|
             \ \  /\  / /| |__) | (___   ___  __ _ _ __ ®
              \ \/  \/ / |  ___/ \___ \ / __|/ _` | '_ \
               \  /\  /  | |     ____) | (__| (_| | | | |
                \/  \/   |_|    |_____/ \___|\__,_|_| |_|
    
            WordPress Security Scanner by the WPScan Team
                           Version 2.9.5-dev
              Sponsored by Sucuri - https://sucuri.net
          @_WPScan_, @ethicalhack3r, @erwan_lr, @_FireFart_
    _______________________________________________________________
    
    
    Examples :
    
    -Further help ...
    ruby ./wpscan.rb --help
    
    -Do 'non-intrusive' checks ...
    ruby ./wpscan.rb --url www.example.com
    
    -Do wordlist password brute force on enumerated users using 50 threads ...
    ruby ./wpscan.rb --url www.example.com --wordlist darkc0de.lst --threads 50
    
    -Do wordlist password brute force on the 'admin' username only ...
    ruby ./wpscan.rb --url www.example.com --wordlist darkc0de.lst --username admin
    
    -Enumerate installed plugins ...
    ruby ./wpscan.rb --url www.example.com --enumerate p
    
    -Enumerate installed themes ...
    ruby ./wpscan.rb --url www.example.com --enumerate t
    
    -Enumerate users (from 1 - 10)...
    ruby ./wpscan.rb --url www.example.com --enumerate u
    
    -Enumerate users (from 1 - 20)...
    ruby ./wpscan.rb --url www.example.com --enumerate u[1-20]
    
    -Enumerate installed timthumbs ...
    ruby ./wpscan.rb --url www.example.com --enumerate tt
    
    -Use a HTTP proxy ...
    ruby ./wpscan.rb --url www.example.com --proxy 127.0.0.1:8118
    
    -Use a SOCKS5 proxy ... (cURL >= v7.21.7 needed)
    ruby ./wpscan.rb --url www.example.com --proxy socks5://127.0.0.1:9000
    
    -Use custom content directory ...
    ruby ./wpscan.rb -u www.example.com --wp-content-dir custom-content
    
    -Use custom plugins directory ...
    ruby ./wpscan.rb -u www.example.com --wp-plugins-dir wp-content/custom-plugins
    
    -Update the Database ...
    ruby ./wpscan.rb --update
    
    -Debug output ...
    ruby ./wpscan.rb --url www.example.com --debug-output 2>debug.log
    
    See README for further information.
    
    
    [!] No argument supplied
```

So...我们就拿冻果果的论坛试试看吧~

```
./wpscan.rb -u www.dongguoshare.com
```

然后去泡杯咖啡吧~等脚本跑完

嗯最后扫描结果如下：

```
    root@WIN-562CUJC625F:/home/hans362/wpscan# ./wpscan.rb -u www.dongguoshare.com
    _______________________________________________________________
            __          _______   _____
            \ \        / /  __ \ / ____|
             \ \  /\  / /| |__) | (___   ___  __ _ _ __ ®
              \ \/  \/ / |  ___/ \___ \ / __|/ _` | '_ \
               \  /\  /  | |     ____) | (__| (_| | | | |
                \/  \/   |_|    |_____/ \___|\__,_|_| |_|
    
            WordPress Security Scanner by the WPScan Team
                           Version 2.9.5-dev
              Sponsored by Sucuri - https://sucuri.net
          @_WPScan_, @ethicalhack3r, @erwan_lr, @_FireFart_
    _______________________________________________________________
    
    
    [i] It seems like you have not updated the database for some time
    [?] Do you want to update now? [Y]es  [N]o  [A]bort update, default: [N] > y
    [i] Updating the Database ...
    [i] Update completed
    [i] The remote host tried to redirect to: https://www.dongguoshare.com/
    [?] Do you want follow the redirection ? [Y]es [N]o [A]bort, default: [N] >y
    [+] URL: https://www.dongguoshare.com/
    [+] Started: Sun Jul 15 15:22:26 2018
    
    [+] Interesting header: EAGLEID: 7ae3a4a615316393468481471e
    [+] Interesting header: LINK: <https://www.dongguoshare.com/wp-json/>; rel="https://api.w.org/", <https://www.dongguoshare.com/>; rel=shortlink
    [+] Interesting header: SERVER: Tengine
    [+] Interesting header: SET-COOKIE: gdbbx_tracking_activity=1531639348; expires=Fri, 11-Jan-2019 07:22:28 GMT; Max-Age=15552000; path=/
    [+] Interesting header: TIMING-ALLOW-ORIGIN: *
    [+] Interesting header: VIA: cache1.l2et2[2918,200-0,M], cache46.l2et2[2918,0], kunlun8.cn198[2944,200-0,M], kunlun6.cn198[2945,0]
    [+] Interesting header: X-CACHE: MISS TCP_MISS dirn:-2:-2 mlen:-1
    [+] Interesting header: X-SWIFT-CACHETIME: 0
    [+] Interesting header: X-SWIFT-SAVETIME: Sun, 15 Jul 2018 07:22:29 GMT
    [+] robots.txt available under: https://www.dongguoshare.com/robots.txt   [HTTP 200]
    [+] This site has 'Must Use Plugins' (http://codex.wordpress.org/Must_Use_Plugins)
    [+] XML-RPC Interface available under: https://www.dongguoshare.com/xmlrpc.php   [HTTP 405]
    [+] API exposed: https://www.dongguoshare.com/wp-json/   [HTTP 200]
    [!] 8 users exposed via API: https://www.dongguoshare.com/wp-json/wp/v2/users
    +------+------------+---------------------------------------------------------+
    | ID   | Name       | URL                                                     |
    +------+------------+---------------------------------------------------------+
    | 1    | Galaxy     | https://www.dongguoshare.com/articles/author/xianghui   |
    | 30   | 露娜       | https://www.dongguoshare.com/articles/author/luna       |
    | 38   | 歌者       | https://www.dongguoshare.com/articles/author/none       |
    | 41   | 清姬       | https://www.dongguoshare.com/articles/author/kiyohime   |
    | 71   | @wyf       | https://www.dongguoshare.com/articles/author/wyf        |
    | 87   | 天鹰       | https://www.dongguoshare.com/articles/author/fengtingyi |
    | 1290 | Monicfenga | https://www.dongguoshare.com/articles/author/monicfenga |
    | 1462 | 冻果小精灵 | https://www.dongguoshare.com/articles/author/dgg-notify |
    +------+------------+---------------------------------------------------------+
    [+] Found an RSS Feed: https://www.dongguoshare.com/activity/feed/   [HTTP 200]
    [!] Missing Author field. Maybe non-standard WordPress RSS feed?
    
    [+] Enumerating WordPress version ...
    
    [+] WordPress version 4.8 (Released on 2017-06-08) identified from sitemap generator
    [!] 18 vulnerabilities identified from the version number
    
    [!] Title: WordPress 2.3.0-4.8.1 - $wpdb->prepare() potential SQL Injection
        Reference: https://wpvulndb.com/vulnerabilities/8905
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/70b21279098fc973eae803693c0705a548128e48
        Reference: https://github.com/WordPress/WordPress/commit/fc930d3daed1c3acef010d04acc2c5de93cd18ec
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 2.9.2-4.8.1 - Open Redirect
        Reference: https://wpvulndb.com/vulnerabilities/8910
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41398
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14725
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 3.0-4.8.1 - Path Traversal in Unzipping
        Reference: https://wpvulndb.com/vulnerabilities/8911
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41457
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14719
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 4.4-4.8.1 - Path Traversal in Customizer
        Reference: https://wpvulndb.com/vulnerabilities/8912
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41397
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14722
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 4.4-4.8.1 - Cross-Site Scripting (XSS) in oEmbed
        Reference: https://wpvulndb.com/vulnerabilities/8913
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41448
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14724
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 4.2.3-4.8.1 - Authenticated Cross-Site Scripting (XSS) in Visual Editor
        Reference: https://wpvulndb.com/vulnerabilities/8914
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41395
        Reference: https://blog.sucuri.net/2017/09/stored-cross-site-scripting-vulnerability-in-wordpress-4-8-1.html
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14726
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 2.3-4.8.3 - Host Header Injection in Password Reset
        Reference: https://wpvulndb.com/vulnerabilities/8807
        Reference: https://exploitbox.io/vuln/WordPress-Exploit-4-7-Unauth-Password-Reset-0day-CVE-2017-8295.html
        Reference: http://blog.dewhurstsecurity.com/2017/05/04/exploitbox-wordpress-security-advisories.html
        Reference: https://core.trac.wordpress.org/ticket/25239
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8295
    
    [!] Title: WordPress <= 4.8.2 - $wpdb->prepare() Weakness
        Reference: https://wpvulndb.com/vulnerabilities/8941
        Reference: https://wordpress.org/news/2017/10/wordpress-4-8-3-security-release/
        Reference: https://github.com/WordPress/WordPress/commit/a2693fd8602e3263b5925b9d799ddd577202167d
        Reference: https://twitter.com/ircmaxell/status/923662170092638208
        Reference: https://blog.ircmaxell.com/2017/10/disclosure-wordpress-wpdb-sql-injection-technical.html
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-16510
    [i] Fixed in: 4.8.3
    
    [!] Title: WordPress 2.8.6-4.9 - Authenticated JavaScript File Upload
        Reference: https://wpvulndb.com/vulnerabilities/8966
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/67d03a98c2cae5f41843c897f206adde299b0509
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17092
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 1.5.0-4.9 - RSS and Atom Feed Escaping
        Reference: https://wpvulndb.com/vulnerabilities/8967
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/f1de7e42df29395c3314bf85bff3d1f4f90541de
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17094
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 4.3.0-4.9 - HTML Language Attribute Escaping
        Reference: https://wpvulndb.com/vulnerabilities/8968
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/3713ac5ebc90fb2011e98dfd691420f43da6c09a
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17093
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 3.7-4.9 - 'newbloguser' Key Weak Hashing
        Reference: https://wpvulndb.com/vulnerabilities/8969
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/eaf1cfdc1fe0bdffabd8d879c591b864d833326c
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17091
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 3.7-4.9.1 - MediaElement Cross-Site Scripting (XSS)
        Reference: https://wpvulndb.com/vulnerabilities/9006
        Reference: https://github.com/WordPress/WordPress/commit/3fe9cb61ee71fcfadb5e002399296fcc1198d850
        Reference: https://wordpress.org/news/2018/01/wordpress-4-9-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/ticket/42720
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5776
    [i] Fixed in: 4.8.5
    
    [!] Title: WordPress <= 4.9.4 - Application Denial of Service (DoS) (unpatched)
        Reference: https://wpvulndb.com/vulnerabilities/9021
        Reference: https://baraktawily.blogspot.fr/2018/02/how-to-dos-29-of-world-wide-websites.html
        Reference: https://github.com/quitten/doser.py
        Reference: https://thehackernews.com/2018/02/wordpress-dos-exploit.html
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6389
    
    [!] Title: WordPress 3.7-4.9.4 - Remove localhost Default
        Reference: https://wpvulndb.com/vulnerabilities/9053
        Reference: https://wordpress.org/news/2018/04/wordpress-4-9-5-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/804363859602d4050d9a38a21f5a65d9aec18216
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10101
    [i] Fixed in: 4.8.6
    
    [!] Title: WordPress 3.7-4.9.4 - Use Safe Redirect for Login
        Reference: https://wpvulndb.com/vulnerabilities/9054
        Reference: https://wordpress.org/news/2018/04/wordpress-4-9-5-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/14bc2c0a6fde0da04b47130707e01df850eedc7e
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10100
    [i] Fixed in: 4.8.6
    
    [!] Title: WordPress 3.7-4.9.4 - Escape Version in Generator Tag
        Reference: https://wpvulndb.com/vulnerabilities/9055
        Reference: https://wordpress.org/news/2018/04/wordpress-4-9-5-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/31a4369366d6b8ce30045d4c838de2412c77850d
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10102
    [i] Fixed in: 4.8.6
    
    [!] Title: WordPress <= 4.9.6 - Authenticated Arbitrary File Deletion
        Reference: https://wpvulndb.com/vulnerabilities/9100
        Reference: https://blog.ripstech.com/2018/wordpress-file-delete-to-code-execution/
        Reference: http://blog.vulnspy.com/2018/06/27/Wordpress-4-9-6-Arbitrary-File-Delection-Vulnerbility-Exploit/
        Reference: https://github.com/WordPress/WordPress/commit/c9dce0606b0d7e6f494d4abe7b193ac046a322cd
        Reference: https://wordpress.org/news/2018/07/wordpress-4-9-7-security-and-maintenance-release/
        Reference: https://www.wordfence.com/blog/2018/07/details-of-an-additional-file-deletion-vulnerability-patched-in-wordpress-4-9-7/
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12895
    [i] Fixed in: 4.8.7
    
    [+] WordPress theme in use: buddyapp - v1.5.3
    
    [+] Name: buddyapp - v1.5.3
     |  Location: https://www.dongguoshare.com/wp-content/themes/buddyapp/
     |  Style URL: https://www.dongguoshare.com/wp-content/themes/buddyapp/style.css
     |  Referenced style.css: wp-content/themes/buddyapp/assets/fonts/style.css
     |  Theme Name: BuddyApp
     |  Theme URI: http://seventhqueen.com/themes/buddyapp
     |  Description: First Mobile Private Community Premium WordPress Theme
     |  Author: SeventhQueen
     |  Author URI: http://themeforest.net/user/SeventhQueen
    
    [+] Enumerating plugins from passive detection ...
     | 11 plugins found:
    
    [+] Name: bbp-user-ranking - v2.7
     |  Latest version: 2.7 (up to date)
     |  Last updated: 2017-12-08T18:18:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/bbp-user-ranking/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/bbp-user-ranking/readme.txt
    
    [+] Name: bbpress - v2.5.14
     |  Latest version: 2.5.14 (up to date)
     |  Last updated: 2017-10-13T18:29:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/bbpress/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/bbpress/readme.txt
    
    [+] Name: buddypress - v2.9.4
     |  Last updated: 2018-06-05T19:44:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/buddypress/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/buddypress/readme.txt[!] The version is out of date, the latest version is 3.1.0
    
    [+] Name: buddypress-global-search - v1.1.8
     |  Last updated: 2018-05-24T06:56:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/buddypress-global-search/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/buddypress-global-search/readme.txt
    [!] The version is out of date, the latest version is 1.1.9
    
    [+] Name: buddypress-media - v4.4.7
     |  Last updated: 2018-07-11T12:48:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/buddypress-media/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/buddypress-media/readme.txt
    [!] The version is out of date, the latest version is 4.5.2
    
    [+] Name: gears
     |  Location: https://www.dongguoshare.com/wp-content/plugins/gears/
    
    [+] Name: image-upload-for-bbpress - v1.1.15
     |  Latest version: 1.1.15 (up to date)
     |  Last updated: 2017-10-02T17:49:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/image-upload-for-bbpress/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/image-upload-for-bbpress/readme.txt
    
    [+] Name: inline-spoilers - v1.3.1
     |  Latest version: 1.3.1 (up to date)
     |  Last updated: 2017-12-21T20:30:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/inline-spoilers/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/inline-spoilers/readme.txt
    
    [+] Name: js_composer
     |  Location: https://www.dongguoshare.com/wp-content/plugins/js_composer/
    
    [!] We could not determine the version installed. All of the past known vulnerabilities will be output to allow you to do your own manual investigation.
    
    [!] Title: Visual Composer <= 4.7.3 - Multiple Unspecified Cross-Site Scripting (XSS)
        Reference: https://wpvulndb.com/vulnerabilities/8208
        Reference: http://codecanyon.net/item/visual-composer-page-builder-for-wordpress/242431
        Reference: https://forums.envato.com/t/visual-composer-security-vulnerability-fix/10494/7
    [i] Fixed in: 4.7.4
    
    [+] Name: wp-ulike - v2.9.1
     |  Last updated: 2018-06-27T12:50:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/wp-ulike/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/wp-ulike/readme.txt
    [!] The version is out of date, the latest version is 3.4
    
    [!] Title: WP ULike <= 3.1 - Unauthenticated Stored XSS
        Reference: https://wpvulndb.com/vulnerabilities/9083
        Reference: https://advisories.dxw.com/advisories/stored-xss-wp-ulike/
        Reference: https://plugins.trac.wordpress.org/changeset/1863114/wp-ulike
        Reference: http://seclists.org/fulldisclosure/2018/May/33
    [i] Fixed in: 3.2
    
    [+] Name: yet-another-related-posts-plugin - v4.4
     |  Latest version: 4.4 (up to date)
     |  Last updated: 2017-01-31T15:17:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/yet-another-related-posts-plugin/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/yet-another-related-posts-plugin/readme.txt
    
    [+] Finished: Sun Jul 15 15:38:00 2018
    [+] Elapsed time: 00:15:34
    [+] Requests made: 479
    
    [!] -Infinity
```

## 结果汇总

我们主要留意有感叹号的地方，说明可能存在漏洞

```
    [+] WordPress version 4.8 (Released on 2017-06-08) identified from sitemap generator
    [!] 18 vulnerabilities identified from the version number
    
    [!] Title: WordPress 2.3.0-4.8.1 - $wpdb->prepare() potential SQL Injection
        Reference: https://wpvulndb.com/vulnerabilities/8905
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/70b21279098fc973eae803693c0705a548128e48
        Reference: https://github.com/WordPress/WordPress/commit/fc930d3daed1c3acef010d04acc2c5de93cd18ec
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 2.9.2-4.8.1 - Open Redirect
        Reference: https://wpvulndb.com/vulnerabilities/8910
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41398
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14725
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 3.0-4.8.1 - Path Traversal in Unzipping
        Reference: https://wpvulndb.com/vulnerabilities/8911
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41457
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14719
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 4.4-4.8.1 - Path Traversal in Customizer
        Reference: https://wpvulndb.com/vulnerabilities/8912
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41397
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14722
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 4.4-4.8.1 - Cross-Site Scripting (XSS) in oEmbed
        Reference: https://wpvulndb.com/vulnerabilities/8913
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41448
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14724
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 4.2.3-4.8.1 - Authenticated Cross-Site Scripting (XSS) in Visual Editor
        Reference: https://wpvulndb.com/vulnerabilities/8914
        Reference: https://wordpress.org/news/2017/09/wordpress-4-8-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/changeset/41395
        Reference: https://blog.sucuri.net/2017/09/stored-cross-site-scripting-vulnerability-in-wordpress-4-8-1.html
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14726
    [i] Fixed in: 4.8.2
    
    [!] Title: WordPress 2.3-4.8.3 - Host Header Injection in Password Reset
        Reference: https://wpvulndb.com/vulnerabilities/8807
        Reference: https://exploitbox.io/vuln/WordPress-Exploit-4-7-Unauth-Password-Reset-0day-CVE-2017-8295.html
        Reference: http://blog.dewhurstsecurity.com/2017/05/04/exploitbox-wordpress-security-advisories.html
        Reference: https://core.trac.wordpress.org/ticket/25239
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8295
    
    [!] Title: WordPress <= 4.8.2 - $wpdb->prepare() Weakness
        Reference: https://wpvulndb.com/vulnerabilities/8941
        Reference: https://wordpress.org/news/2017/10/wordpress-4-8-3-security-release/
        Reference: https://github.com/WordPress/WordPress/commit/a2693fd8602e3263b5925b9d799ddd577202167d
        Reference: https://twitter.com/ircmaxell/status/923662170092638208
        Reference: https://blog.ircmaxell.com/2017/10/disclosure-wordpress-wpdb-sql-injection-technical.html
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-16510
    [i] Fixed in: 4.8.3
    
    [!] Title: WordPress 2.8.6-4.9 - Authenticated JavaScript File Upload
        Reference: https://wpvulndb.com/vulnerabilities/8966
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/67d03a98c2cae5f41843c897f206adde299b0509
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17092
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 1.5.0-4.9 - RSS and Atom Feed Escaping
        Reference: https://wpvulndb.com/vulnerabilities/8967
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/f1de7e42df29395c3314bf85bff3d1f4f90541de
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17094
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 4.3.0-4.9 - HTML Language Attribute Escaping
        Reference: https://wpvulndb.com/vulnerabilities/8968
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/3713ac5ebc90fb2011e98dfd691420f43da6c09a
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17093
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 3.7-4.9 - 'newbloguser' Key Weak Hashing
        Reference: https://wpvulndb.com/vulnerabilities/8969
        Reference: https://wordpress.org/news/2017/11/wordpress-4-9-1-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/eaf1cfdc1fe0bdffabd8d879c591b864d833326c
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17091
    [i] Fixed in: 4.8.4
    
    [!] Title: WordPress 3.7-4.9.1 - MediaElement Cross-Site Scripting (XSS)
        Reference: https://wpvulndb.com/vulnerabilities/9006
        Reference: https://github.com/WordPress/WordPress/commit/3fe9cb61ee71fcfadb5e002399296fcc1198d850
        Reference: https://wordpress.org/news/2018/01/wordpress-4-9-2-security-and-maintenance-release/
        Reference: https://core.trac.wordpress.org/ticket/42720
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-5776
    [i] Fixed in: 4.8.5
    
    [!] Title: WordPress <= 4.9.4 - Application Denial of Service (DoS) (unpatched)
        Reference: https://wpvulndb.com/vulnerabilities/9021
        Reference: https://baraktawily.blogspot.fr/2018/02/how-to-dos-29-of-world-wide-websites.html
        Reference: https://github.com/quitten/doser.py
        Reference: https://thehackernews.com/2018/02/wordpress-dos-exploit.html
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6389
    
    [!] Title: WordPress 3.7-4.9.4 - Remove localhost Default
        Reference: https://wpvulndb.com/vulnerabilities/9053
        Reference: https://wordpress.org/news/2018/04/wordpress-4-9-5-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/804363859602d4050d9a38a21f5a65d9aec18216
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10101
    [i] Fixed in: 4.8.6
    
    [!] Title: WordPress 3.7-4.9.4 - Use Safe Redirect for Login
        Reference: https://wpvulndb.com/vulnerabilities/9054
        Reference: https://wordpress.org/news/2018/04/wordpress-4-9-5-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/14bc2c0a6fde0da04b47130707e01df850eedc7e
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10100
    [i] Fixed in: 4.8.6
    
    [!] Title: WordPress 3.7-4.9.4 - Escape Version in Generator Tag
        Reference: https://wpvulndb.com/vulnerabilities/9055
        Reference: https://wordpress.org/news/2018/04/wordpress-4-9-5-security-and-maintenance-release/
        Reference: https://github.com/WordPress/WordPress/commit/31a4369366d6b8ce30045d4c838de2412c77850d
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-10102
    [i] Fixed in: 4.8.6
    
    [!] Title: WordPress <= 4.9.6 - Authenticated Arbitrary File Deletion
        Reference: https://wpvulndb.com/vulnerabilities/9100
        Reference: https://blog.ripstech.com/2018/wordpress-file-delete-to-code-execution/
        Reference: http://blog.vulnspy.com/2018/06/27/Wordpress-4-9-6-Arbitrary-File-Delection-Vulnerbility-Exploit/
        Reference: https://github.com/WordPress/WordPress/commit/c9dce0606b0d7e6f494d4abe7b193ac046a322cd
        Reference: https://wordpress.org/news/2018/07/wordpress-4-9-7-security-and-maintenance-release/
        Reference: https://www.wordfence.com/blog/2018/07/details-of-an-additional-file-deletion-vulnerability-patched-in-wordpress-4-9-7/
        Reference: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-12895
    [i] Fixed in: 4.8.7
```

首先看到WordPress版本仅为4.8！这个冻果果这么大胆的吗？多久没更新啦，共检出18个可利用漏洞，经过我的尝试，其中有两个极有可能被利用

接着看主题和插件，这里还行，主要有一个Ulike点赞插件的高危漏洞，并且非常容易实施

```
    [+] Name: wp-ulike - v2.9.1
     |  Last updated: 2018-06-27T12:50:00.000Z
     |  Location: https://www.dongguoshare.com/wp-content/plugins/wp-ulike/
     |  Readme: https://www.dongguoshare.com/wp-content/plugins/wp-ulike/readme.txt
    [!] The version is out of date, the latest version is 3.4
    
    [!] Title: WP ULike <= 3.1 - Unauthenticated Stored XSS
        Reference: https://wpvulndb.com/vulnerabilities/9083
        Reference: https://advisories.dxw.com/advisories/stored-xss-wp-ulike/
        Reference: https://plugins.trac.wordpress.org/changeset/1863114/wp-ulike
        Reference: http://seclists.org/fulldisclosure/2018/May/33
    [i] Fixed in: 3.2
```

So...这个冻果果还敢说自己的技术很好？最起码的连WordPress都不知道要时刻更新，万一来个高危漏洞不就傻眼啦

WPScan还贴心的在每个漏洞下贴出了相关链接甚至是复现方法

## 结语

发这篇文章除了为了介绍WPScan这个强大的工具之外，也想告诉这个冻果果团队，千万不要会一点技术就得瑟，请永远保持一颗谦卑的心，接受他人的合理的意见。再这么嚣张下去，迟早要gg的

哎呀~说多了，那么感谢各位的阅读~也请各位注意网站的安全，做好必要的防护哟~

注：本文仅对冻果果论坛安全性进行评估，没有通过检出漏洞对冻果果实施攻击等操作。


  [1]: https://blog.lzh441.club
  [2]: https://blog.lzh441.club/index.php/archives/58/
  [3]: https://blog.lzh441.club
  [4]: https://blog-img-1251828412.image.myqcloud.com/2018/07/16/3600694451.png!webp_1920w