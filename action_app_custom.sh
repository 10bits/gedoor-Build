#!/bin/sh
#本脚本用来个性化定制app,不会修改任何程序代码

function set_env() { echo "$1=$2" >> $GITHUB_ENV; }
function debug() { echo "::debug::$1"; }

#去除河蟹,默认启用
function app_clear_18plus() 
{
    if [ $APP_NAME = 'legado' ]; then
        debug "清空18PlusList.txt"
        echo "">$APP_WORKSPACE/app/src/main/assets/18PlusList.txt
    fi
}

#修改桌面阅读名为阅读.A,安装多个阅读时候方便识别,默认启用
function app_rename() 
{
    if [ $APP_NAME = 'legado' ] && [ $SECRETS_RENAME = 'true' ]; then
        debug "更改桌面启动名称"
        sed 's/"app_name">阅读/"app_name">'"$APP_LAUNCH_NAME"'/' $APP_WORKSPACE/app/src/main/res/values-zh/strings.xml -i
        debug "更改webdav备份目录legado为legado+后缀名"
        sed "s/legado\//legado$APP_SUFFIX\//" $APP_WORKSPACE/app/src/main/java/io/legado/app/help/storage/BookWebDav.kt -i
    fi
}

#满足本人的一些小优化
function app_bugme()
{
    if [ $APP_NAME = 'legado' ] && [[ $REPO_ACTOR = '10bits' ]]; then 
        debug "发现书籍界面优化"
        sed -e "/error(it)/i\isLoading = false" \
            -e 's/error(it)/error("网络请求失败或超时")/' \
            $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/explore/ExploreShowActivity.kt -i
        sed "s/30000L/6000L/" $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/explore/ExploreShowViewModel.kt -i
        
        debug "关闭加入书架提示"
        START=$(sed -n '/!ReadBook.inBookshelf/=' $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/read/ReadBookActivity.kt)
        sed -e "$(echo $START+1|bc),$(echo $START+8|bc)d" \
            -e '/!ReadBook.inBookshelf/a\viewModel.removeFromBookshelf{ super.finish() }' \
            $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/read/ReadBookActivity.kt -i
        
        debug "发现界面支持搜索书籍"
        sed -e 's/getString(R.string.screen_find)/"搜索书籍、书源"/' \
            -e '/ExploreFragment/i\import io.legado.app.ui.book.search.SearchActivity' \
            -e '/onQueryTextSubmit/a\if(!query?.contains("group:")!!){startActivity<SearchActivity>(Pair("key", query))}' \
            $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/main/explore/ExploreFragment.kt -i
    fi
}

#软件内一些颜色调整,默认不启用
function app_color_set()
{
    if [ $APP_NAME = 'legado' ]; then
        debug "设置搜索界面浮动按钮颜色"
        sed '/id\/fb_stop/a\        android:backgroundTint="#389099"' $APP_WORKSPACE/app/src/main/res/layout/activity_book_search.xml -i
    fi
}

#删除一些用不到的资源
function app_resources_unuse()
{
    if [ $APP_NAME = 'legado' ]; then
        debug "删除一些用不到的资源"
        rm $APP_WORKSPACE/app/src/main/assets/bg      -rf
        #rm $APP_WORKSPACE/app/src/main/assets/web/new -rf
    fi
}

#最小化生成apk体积
function app_minify()
{
    if [ $APP_NAME = 'legado' ]; then
        debug "缩小apk体积"
        sed '/minifyEnabled/i\            shrinkResources true' $APP_WORKSPACE/app/build.gradle -i
        sed 's/minifyEnabled false/minifyEnabled true/'         $APP_WORKSPACE/app/build.gradle -i
    fi
}

#和已有阅读共存,默认启用
function app_live_together()
{
    if [ $APP_NAME = 'legado' ]; then
        debug "解决安装程序共存问题"
        sed "s/'.release'/'.release$APP_SUFFIX'/" $APP_WORKSPACE/app/build.gradle -i
        sed "s/.release/.release$APP_SUFFIX/"     $APP_WORKSPACE/app/google-services.json -i 
    fi
}

#apk增加签名,默认启用
function app_sign()
{
    debug "给apk增加签名"
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
        debug "删除google services相关"
        sed '/io.fabric/d'            $APP_WORKSPACE/app/build.gradle -i
        sed '/com.google.firebase/d'  $APP_WORKSPACE/app/build.gradle -i
        sed '/com.google.gms/d'       $APP_WORKSPACE/app/build.gradle -i
    fi
}

#进入收尾工作
function app_other()
{
    if [ $APP_NAME = 'MyBookshelf' ]; then
        debug "$APP_NAME 解压MyBookshelf_Keys.zip"
        unzip -o $APP_WORKSPACE/app/MyBookshelf_Keys.zip -d $APP_WORKSPACE/app
        rm $APP_WORKSPACE/app/gradle.properties       
        #sed 's/com.gedoor.monkeybook/com.kunfei.bookshelf/' $APP_WORKSPACE/app/build.gradle -i
    fi
}

#是否启用缩减apk体积
if [ $SECRETS_MINIFY = 'true' ]; then
    debug "开启混淆压缩代码"
    app_minify;app_resources_unuse
fi

#通用
app_sign
#阅读3.0
app_bugme;app_clear_18plus;app_rename;app_live_together
#阅读2.0
app_not_apply_plugin
