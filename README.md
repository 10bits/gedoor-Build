## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.091421.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.091421/legado-3.21.091421.apk) 上次构建时间:2021-09-15 02:13:19
<!--start-->
> **2021/09/10**
> 
> 1. 书架菜单添加了日志,更新失败的和下载失败的信息会显示在里面
> 2. 书源添加校验关键字,有校验关键字的书源用此关键字校验
> 3. 目录添加购买标识规则
> 4. 正文标题使用替换,简繁转换,正文中已书名,标题开头的自动去重
> 5. 其它一些优化
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

