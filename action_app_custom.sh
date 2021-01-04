#!/bin/sh
#本脚本用来个性化定制app,不会修改任何程序代码

function set_env() { echo "$1=$2" >> $GITHUB_ENV; }

#去除河蟹,默认启用
function app_clear_18plus() 
{
    if [ $APP_NAME = 'legado' ]; then
        echo "清空18PlusList.txt"
        echo "">$APP_WORKSPACE/app/src/main/assets/18PlusList.txt
    fi
}

#修改桌面阅读名为阅读.A,安装多个阅读时候方便识别,默认启用
function app_rename() 
{
    if [ $APP_NAME = 'legado' ] && [ $SECRETS_RENAME = 'true' ]; then
        #更改桌面启动名称
        sed 's/"app_name">阅读/"app_name">'"$APP_LAUNCH_NAME"'/' $APP_WORKSPACE/app/src/main/res/values-zh/strings.xml -i
        #更改webdav备份目录legado为legado+后缀名
        sed "s/legado\//legado$APP_SUFFIX\//"                    $APP_WORKSPACE/app/src/main/java/io/legado/app/help/storage/BookWebDav.kt -i
    fi
}

#满足本人的一些小优化
function app_bugme()
{
    if [ $APP_NAME = 'legado' ] && [ $REPO_OWNER = '10bits' ]; then
        sed "/error(it)/i\isLoading = false"            $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/explore/ExploreShowActivity.kt -i
        sed 's/error(it)/error("网络错误!请尝试继续")/'  $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/explore/ExploreShowActivity.kt -i
        sed "s/30000L/10000L/"                          $APP_WORKSPACEapp/src/main/java/io/legado/app/ui/book/explore/ExploreShowViewModel.kt -i
    fi
}

#软件内一些颜色调整,默认不启用
function app_color_set()
{
    if [ $APP_NAME = 'legado' ]; then
        #设置搜索界面浮动按钮颜色
        sed '/id\/fb_stop/a\        android:backgroundTint="#389099"' $APP_WORKSPACE/app/src/main/res/layout/activity_book_search.xml -i
    fi
}

#删除一些用不到的资源
function app_resources_unuse()
{
    if [ $APP_NAME = 'legado' ]; then
        echo "删除一些用不到的资源"
        rm $APP_WORKSPACE/app/src/main/assets/bg      -rf
        #rm $APP_WORKSPACE/app/src/main/assets/web/new -rf
    fi
}

#最小化生成apk体积
function app_minify()
{
    if [ $APP_NAME = 'legado' ]; then
        #缩小apk体积
        sed '/minifyEnabled/i\            shrinkResources true' $APP_WORKSPACE/app/build.gradle -i
        sed 's/minifyEnabled false/minifyEnabled true/'         $APP_WORKSPACE/app/build.gradle -i
    fi
}

#和已有阅读共存,默认启用
function app_live_together()
{
    if [ $APP_NAME = 'legado' ]; then
        echo "解决安装程序共存问题"
        sed "s/'.release'/'.release$APP_SUFFIX'/" $APP_WORKSPACE/app/build.gradle -i
        sed "s/.release/.release$APP_SUFFIX/"     $APP_WORKSPACE/app/google-services.json -i 
    fi
}

#apk增加签名,默认启用
function app_sign()
{
    echo "给apk增加签名"
    cp $GITHUB_WORKSPACE/.github/workflows/legado.jks  $APP_WORKSPACE/app/legado.jks
    sed '$a\RELEASE_STORE_FILE=./legado.jks'           $APP_WORKSPACE/gradle.properties -i 
    sed '$a\RELEASE_KEY_ALIAS=legado'                  $APP_WORKSPACE/gradle.properties -i
    sed '$a\RELEASE_STORE_PASSWORD=gedoor_legado'      $APP_WORKSPACE/gradle.properties -i
    sed '$a\RELEASE_KEY_PASSWORD=gedoor_legado'        $APP_WORKSPACE/gradle.properties -i
}

#禁用一些库
function app_not_apply_plugin()
{
    if [ $APP_NAME = 'MyBookshelf' ]; then
        echo "删除google services相关"
        sed '/io.fabric/d'            $APP_WORKSPACE/app/build.gradle -i
        sed '/com.google.firebase/d'  $APP_WORKSPACE/app/build.gradle -i
        sed '/com.google.gms/d'       $APP_WORKSPACE/app/build.gradle -i
    fi
}

#进入收尾工作
function app_other()
{
    if [ $APP_NAME = 'MyBookshelf' ]; then
        echo "$APP_NAME 解压MyBookshelf_Keys.zip"
        unzip -o $APP_WORKSPACE/app/MyBookshelf_Keys.zip -d $APP_WORKSPACE/app
        rm $APP_WORKSPACE/app/gradle.properties       
        #sed 's/com.gedoor.monkeybook/com.kunfei.bookshelf/' $APP_WORKSPACE/app/build.gradle -i
    fi
}

#先进行一些准备工作再开始编译
function app_build()
{
    echo "build with gradle"
    cd $APP_WORKSPACE
    chmod +x gradlew
    ./gradlew assembleAppRelease
    if [ $APP_NAME = 'MyBookshelf' ]; then
        set_env APP_UPLOAD $APP_WORKSPACE/app/build/outputs/apk/release
    fi
}

#是否启用缩减apk体积
if [ $SECRETS_MINIFY = 'true' ]; then
    app_minify;app_resources_unuse
fi

#准备工作在这里,可以删除你不需要的
app_bugme;app_clear_18plus;app_rename;app_sign;app_live_together;app_not_apply_plugin
