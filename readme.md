## legado阅读3.0自动构建

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新tag:3.20.072917
  
1. fork到你自己的仓库
2. 去你fork了的仓库,点一下右上角star就会自动构建,已经star的点unstar,再点一下star就会再次构建了
3. 构建完,apk会自动打包,去你自己的[Actions](https://github.com/10bits/gedoor-Build/actions)列表里找
4. 每次构建大概十几分钟,喝杯茶的功夫再去Actions列表看看构建完没有
5. 为什么要去自己的仓库构建,因为这么多人一起构建,Actions列表会显的乱七八糟

## 如果你遇到以下问题

1. `安装失败(-102)`问题,给release apk增加了签名,已解决
2. `与已安装应用签名不同`问题,请卸载重新安装,已解决
3. `与已安装程序共存`问题,通过修改`applicationIdSuffix='.releaseA'`,已解决,不用卸载重装了
4. 使用过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)
## 如何定制你自己的APP(举例)
> 来自酷安深情小奶思的需求:搜索界面,浮动停止加载按钮颜色修改为#389099
```yaml
- name: custom your app
      run: |
        sed '98a\        android:backgroundTint="#389099"' /opt/legado/app/src/main/res/layout/activity_book_search.xml -i
```
请触类旁通
## 免责声明

* 使用github actions自动构建,不会对原仓库代码程序进行任何修改
* 如果你使用了自动打包的apk对你的设备产生伤害,与本人无关,一切都是自动构建的
