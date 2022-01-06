## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.22.010615.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.22.010615/legado-3.22.010615.apk) 上次构建时间:2022-01-06 20:22:58
<!--start-->
> **2022/01/06**
> 
> * 弃用java.getCookie(tag,key)，请使用cookie.getKey(url,key)
> * js添加java.cacheFile(url, saveTime),缓存网络链接，返回文件内容，可实现代码共用和减少代码量
> ```js
> eval(String(java.cacheFile(url)))
> ```
> * 设置里增加书籍文件夹配置,方便切换外部书籍保存文件夹
> * 修复打开Web服务，切出app后很快崩溃 #1489
> * 修复低版本手机打开本地文件出错的bug #1491
> * 校验和调试时不保存正文
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

