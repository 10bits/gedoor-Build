#!/bin/sh

#解决安装程序共存问题
sed "s/'.release'/'.releaseA'/" /opt/legado/app/build.gradle -i
sed 's/.release/.releaseA/g' /opt/legado/app/google-services.json -i 

#设置搜索界面浮动按钮颜色
sed '98a\        android:backgroundTint="#389099"' /opt/legado/app/src/main/res/layout/activity_book_search.xml -i

#缩小apk体积
#sed 's/minifyEnabled false/minifyEnabled true/g' /opt/legado/app/build.gradle -i
#sed '59a\            shrinkResources true'       /opt/legado/app/build.gradle -i
