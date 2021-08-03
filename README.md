## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.080316.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.080316/legado-3.21.080316.apk) 上次构建时间:2021-08-03 20:19:52
<!--start-->
> **2021/08/02**
> 
> * 关于最近版本有时候界面没有数据的问题是因为把LiveData组件换成了谷歌推荐的Flow组件导致的问题,正在查找解决办法
> 
> 1. 换源界面功能添加：置顶，置底，删除 by h11128
> 2. Cronet:优化 by ag2s20150909
> 3. 优化自动翻页 by jiuZhouWorlds
> 4. 封面设置移到主题里面,白天和夜间可分别设置
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

