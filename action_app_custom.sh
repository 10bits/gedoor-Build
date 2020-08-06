#!/bin/sh
#本脚本用来个性化定制app,不会修改任何程序代码

function app_clear_18plus()
{
    if [ $APP_NAME = 'legado' ]; then
        echo "清空18PlusList.txt"
        echo "">$APP_WORKSPACE/app/src/main/assets/18PlusList.txt
    fi
}
function app_color_set()
{
    if [ $APP_NAME = 'legado' ]; then
        #设置搜索界面浮动按钮颜色
        sed '/id\/fb_stop/a\        android:backgroundTint="#389099"' $APP_WORKSPACE/app/src/main/res/layout/activity_book_search.xml -i
    fi
}
function app_resources_unuse()
{
    if [ $APP_NAME = 'legado' ]; then
        echo "删除一些用不到的资源"
        rm $APP_WORKSPACE/app/src/main/assets/bg      -rf
        rm $APP_WORKSPACE/app/src/main/assets/web/new -rf
    fi
}
function app_minify()
{
    #缩小apk体积
    sed '/minifyEnabled/i\            shrinkResources true' $APP_WORKSPACE/app/build.gradle -i
    sed 's/minifyEnabled false/minifyEnabled true/'         $APP_WORKSPACE/app/build.gradle -i
}

function app_live_together()
{
    if [ $APP_NAME = 'legado' ]; then
        echo "解决安装程序共存问题"
        sed "s/'.release'/'.releaseA'/" $APP_WORKSPACE/app/build.gradle -i
        sed 's/.release/.releaseA/'     $APP_WORKSPACE/app/google-services.json -i 
    fi
}
function app_not_apply_plugin(){
    if [ $APP_NAME = 'MyBookshelf' ]; then
        echo "解决$APP_NAME google-services.json丢失"
        sed '/io.fabric/d'       $APP_WORKSPACE/app/build.gradle -i
        sed '/com.google.gms/d'  $APP_WORKSPACE/app/build.gradle -i
    fi
}
function app_sign()
{
    echo "给apk增加签名"
    cp $GITHUB_WORKSPACE/.github/workflows/legado.jks $APP_WORKSPACE/app/legado.jks
    sed '$a\RELEASE_STORE_FILE=./legado.jks'          $APP_WORKSPACE/gradle.properties -i 
    sed '$a\RELEASE_KEY_ALIAS=legado'                 $APP_WORKSPACE/gradle.properties -i
    sed '$a\RELEASE_STORE_PASSWORD=gedoor_legado'     $APP_WORKSPACE/gradle.properties -i
    sed '$a\RELEASE_KEY_PASSWORD=gedoor_legado'       $APP_WORKSPACE/gradle.properties -i
}
app_clear_18plus;app_sign;app_live_together;app_minify;app_resources_unuse;app_not_apply_plugin
