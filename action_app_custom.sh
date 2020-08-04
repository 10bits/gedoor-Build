#!/bin/sh
#本脚本用来个性化定制app,不会修改任何程序代码

echo "清空18PlusList.txt"
echo "">$workspace/app/src/main/assets/18PlusList.txt

#设置搜索界面浮动按钮颜色
#sed '/id\/fb_stop/a\        android:backgroundTint="#389099"' $workspace/app/src/main/res/layout/activity_book_search.xml -i

#缩小apk体积
sed '/minifyEnabled/i\            shrinkResources true' $workspace/app/build.gradle -i
sed 's/minifyEnabled false/minifyEnabled true/'         $workspace/app/build.gradle -i

#删除一些用不到的资源
rm $workspace/app/src/main/assets/bg      -rf
rm $workspace/app/src/main/assets/web/new -rf
