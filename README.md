## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.21.070820.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.21.070820/legado-3.21.070820.apk) 上次构建时间:2021-07-09 02:14:50
<!--start-->
> **2021/07/07**
> 1. 默认规则新增类似`jsonPath`的索引写法 by bushixuanqi
> * 格式形如 `[index,index, ...]` 或 `[!index,index, ...]` 其中`[!`开头表示筛选方式为排除，`index`可以是单个索引，也可以是区间。
> * 区间格式为 `start:end` 或 `start:end:step`，其中`start`为`0`可省略，`end`为`-1`可省略。
> * 索引、区间两端、区间间隔都支持负数
> * 例如 `tag.div[-1, 3:-2:-10, 2]`
> * 特殊用法 `tag.div[-1:0]` 可在任意地方让列表反向
> 2. 允许索引作为@分段后每个部分的首规则，此时相当于前面是`children`
> * `head@.1@text` 与 `head@[1]@text` 与 `head@children[1]@text` 等价
> 3. 添加Umd格式支持 by ag2s20150909
> 4. 修复web页面按键重复监听的bug
> 5. 亮度条往中间移了一点,防止误触
> 6. 添加内置字典
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

