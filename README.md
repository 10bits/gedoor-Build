## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.22.112222.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.22.112222/legado-3.22.112222.apk) 上次构建时间:2022-11-23 02:18:13
<!--start-->
> **2022/11/22**
> 
> * 修复朗读长时间暂停后恢复时朗读速度可能不对的bug
> * addBookshelf url参数添加origin,可以指定书源
> * 通过增加特定标识使用无UA请求，适用于网络导入书源等,用法：http://xxx.xxx/xxxx#requestWithoutUA
> * 修复cookie.getCookie(source.getKey())返回的cookie不及时的bug
> * 书签添加导出功能
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

