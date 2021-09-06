## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.090617.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.090617/legado-3.21.090617.apk) 上次构建时间:2021-09-06 20:19:21
<!--start-->
> **2021/09/06**
> 
> 1. 采用exoPlayer播放音频,支持更多格式
> 2. 替换不再阻塞
> 3. 修复详情页初始化:规则bug
> 4. 书源内的并发率生效,两种格式
>     * 时间 格式: 如 500, 访问间隔500毫秒
>     * 次数/时间 格式: 如 5/60000, 每分钟最多访问5次
> 
> 5. url参数添加js, 和webJs参数,js参数传入url返回新的url, webJs参数在webView内执行直到返回不为空,和正文规则webJs一样
> 6. 重写离线缓存
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

