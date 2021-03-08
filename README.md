## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.030812.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.030812/legado-3.21.030812.apk) 上次构建时间:2021-03-08 14:13:32
<!--start-->
> **2021/03/08**
> * 阅读页面停留10分钟之后自动备份进度
> * 添加了针对中文的断行排版处理-by hoodie13, 需要再阅读界面设置里手动开启
> * 添加朗读快捷方式
> * 优化Epub解析 by hoodie13
> * epub书籍增加cache by hoodie13
> * 修复切换书籍或者章节时的断言崩溃问题。看漫画容易复现。 by hoodie13
> * 修正增加书签alert的正文内容较多时，确定键溢出屏幕问题 by hoodie13
> * 图片样式添加TEXT, 阅读界面菜单里可以选择图片样式
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

