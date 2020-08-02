#!/bin/sh
#本脚本用来个性化定制app,不会修改任何程序代码

#解决安装程序共存问题
sed "s/'.release'/'.releaseA'/" $workspace/app/build.gradle -i
sed 's/.release/.releaseA/g'    $workspace/app/google-services.json -i 

#设置搜索界面浮动按钮颜色
sed '/id\/fb_stop/a\        android:backgroundTint="#389099"' $workspace/app/src/main/res/layout/activity_book_search.xml -i

#缩小apk体积
#sed '/minifyEnabled/i\            shrinkResources true' $workspace/app/build.gradle -i
#sed 's/minifyEnabled false/minifyEnabled true/'         $workspace/app/build.gradle -i
