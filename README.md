## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.101221.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.101221/legado-3.21.101221.apk) 上次构建时间:2021-10-13 02:14:20
<!--start-->
> **2021/10/10**
> 
> * 阿里云语音自动登录
> * 修复一些bug
> * 优化阿里云登录,需重新登录
> 
> ```
> source登录相关方法,可在js内通过source.调用,可以参考阿里云语音登录
> login()
> getHeaderMap(hasLoginHeader: Boolean = false)
> getLoginHeader(): String?
> getLoginHeaderMap(): Map<String, String>?
> putLoginHeader(header: String)
> removeLoginHeader()
> setVariable(variable: String?)
> getVariable(): String?
> AnalyzeUrl相关函数,js中通过java.调用
> initUrl() //重新解析url,可以用于登录检测js登录后重新解析url重新访问
> getHeaderMap().putAll(source.getHeaderMap(true)) //重新设置登录头
> getStrResponse( jsStr: String? = null, sourceRegex: String? = null) //返回访问结果,文本类型,书源内部重新登录后可调用此方法重新返回结果
> getResponse(): Response //返回访问结果,网络朗读引擎采用的是这个,调用登录后在调用这方法可以重新访问,参考阿里云登录检测
> ```
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

