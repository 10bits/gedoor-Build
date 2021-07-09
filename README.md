## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.070914.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.070914/legado-3.21.070914.apk) 上次构建时间:2021-07-09 20:18:30
<!--start-->
> **2021/07/09**
> 1. 发现url添加json格式, 支持设置标签样式
> * 样式属性可以搜索 [FleboxLayout子元素支持的属性介绍](https://www.jianshu.com/p/3c471953e36d)
> * 样式属性可省略,有默认值
> ```json
> [
>   {
>     "title": "xxx",
>     "url": "",
>     "style": {
>       "layout_flexGrow": 0,
>       "layout_flexShrink": 1,
>       "layout_alignSelf": "auto",
>       "layout_flexBasisPercent": -1,
>       "layout_wrapBefore": false
>     }
>   }
> ]
> ```
<!--end-->
  
1. fork到你自己的仓库
2. 去你自己的仓库,点一下右上角star就会自动开始构建,已经star的点unstar,再点一下star就会进行新的构建,你的[Actions](https://github.com/10bits/gedoor-Build/actions)列表会有显示的
3. 每次构建完,apk会自动打包为`legado.apk.zip
`,去你自己的[Actions](https://github.com/10bits/gedoor-Build/actions)列表里找
4. 每次构建大概十几分钟,请耐心等待

## 如果你安装apk遇到以下问题

1. `安装失败(-102)`问题,给release apk增加了签名,已解决
2. `与已安装应用签名不同`问题,请卸载重新安装,已解决
3. `与已安装程序共存`问题,通过修改`applicationIdSuffix='.releaseA'`,已解决,不用卸载重装了
> 使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

