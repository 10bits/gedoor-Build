## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.22.041209.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.22.041209/legado-3.22.041209.apk) 上次构建时间:2022-04-12 14:17:51
<!--start-->
> **2022/04/012**
> 
> * 恢复epub加载方式
> * 添加替换超时判断,替换超时自动禁用替换规则并重启应用,正则无限执行会导致耗电异常且没有办法主动结束线程只能重启应用
> * 使用glide解码正文图片 by Xwite
> * fix:缓存图片后缀错误拼接 by Xwite
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

