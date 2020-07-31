## legado阅读3.0自动构建

> 会自动清空18PlusList.txt,如果你喜欢的话

> 默认从最新TAG构建

> 最新TAG: 3.20.072917
  
1. fork到自己的仓库
2. 在你自己的仓库,点一下右上角star就会自动构建,点一下右上角unstar,再点一下star就会再次构建了
3. apk自动打包,去[Actions](https://github.com/10bits/gedoor-Build/actions)里找
4. 每次构建大概十几分钟,喝杯茶的功夫再去Actions列表看看构建完没有
5. 为什么要去自己的仓库构建,因为这么多人一起构建,Actions列表会显的乱七八糟

## 如果你遇到以下问题

1. `安装失败(-102)`问题,给release apk增加了签名,已解决
2. `与已安装应用签名不同`问题,请卸载重新安装,已解决
3. `共存问题`已解决,默认生成debug包,不用卸载重装了
4. 使用过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

## 免责声明

* 使用github actions自动构建,不会对原仓库代码程序进行任何修改
* 如果你使用了自动打包的apk对你的设备产生伤害,与本人无关,一切都是自动构建的
