## legado阅读3.0自动构建

> 默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 当前最新tag:3.20.121712 上次检查时间:2020-12-17 14:16:47
  
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
## 如何定制你自己的APP(举例)
请在`action_app_custom.sh`脚本里进行定制

```bash
#!/bin/sh
#设置搜索界面浮动按钮颜色
sed '/id\/fb_stop/a\        android:backgroundTint="#389099"' /opt/legado/app/src/main/res/layout/activity_book_search.xml -i
#缩小apk体积
sed '/minifyEnabled/i\            shrinkResources true' /opt/legado/app/build.gradle -i
sed 's/minifyEnabled false/minifyEnabled true/'         /opt/legado/app/build.gradle -i
```
## 构建任务过程中用到的脚本
* `action_setenv.sh`用来设置环境变量
* `action_clone.sh`用来clone远端仓库
* `action_app_custom.sh`用来定制app
> 脚本中用的的环境变量

|环境变量名      |描述|
|--|--|
|APP_NAME       |构建app的名字|
|APP_GIT_URL    |构建app的git url|
|APP_WORKSPACE  |构建app的工作目录|
|APP_UPLOAD_NAME|构建完打包名|
|APP_UPLOAD     |构建完apk打包路径|

> SECRETS环境变量

|环境变量名      |描述|
|--|--|
|APP_NAME       |构建其他仓库app的名字|
|GIT_URL        |构建其他仓库app的git url|
|ENABLE         |是否开启构建其他仓库|
|MINIFY         |是否启用压缩apk体积|
|RENAME         |是否更改桌面启动名称|
|SUFFIX         |后缀名|

<img src="https://i.loli.net/2020/10/21/7LqornKzC2hmsUd.png" width = "50%" height = "50%" alt="" align=center />

## 编译其他开源APP(MyBookshelf阅读2.0)
> 修改`action_setenv.sh`脚本里的坏境变量`APP_NAME`,`APP_GIT_URL`
```bash
APP_NAME='MyBookshelf'
APP_GIT_URL='https://github.com/gedoor/MyBookshelf.git'
```
## 免责声明
* 使用github actions自动构建,不会对原仓库代码程序进行任何修改
* 如果你使用了自动打包的apk对你的设备产生伤害,与本人无关,一切都是自动构建的
