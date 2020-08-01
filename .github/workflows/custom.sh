#!/bin/sh
#设置搜索界面浮动按钮颜色
sed '98a\        android:backgroundTint="#389099"' /opt/legado/app/src/main/res/layout/activity_book_search.xml -i

#缩小apk体积
sed '59a\            shrinkResources true' /opt/legado/app/build.gradle -i
