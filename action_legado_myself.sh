#!/bin/sh
source $GITHUB_WORKSPACE/action_util.sh
#阅读3.0自用定制脚本
function build_gradle_setting()
{
    debug "maven中央仓库回归"
    sed "/google()/i\        mavenCentral()" $APP_WORKSPACE/build.gradle -i

    debug "Speed Up Gradle"
    sed -e '/android {/r '"$GITHUB_WORKSPACE/.github/legado/speedup.gradle"'' \
        -e '/kapt {/a\  useBuildCache = true' \
        -e '/minSdkVersion/c\        minSdkVersion 26' \
        $APP_WORKSPACE/app/build.gradle -i
}

function bookshelfAdd_no_alert()
{
    debug "关闭加入书架提示"
    find $APP_WORKSPACE/app/src -regex '.*/ReadBookActivity.kt' -exec \
    sed -e '/fun finish()/,/fun onDestroy()/{s/alert/\/*&/;s/show()/&*\//}' \
        -e '/!ReadBook.inBookshelf/a\viewModel.removeFromBookshelf{ super.finish() }' \
        {} -i \;
}

function exploreShow_be_better()
{
    debug "发现书籍界面优化"
    find $APP_WORKSPACE/app/src -regex '.*/ExploreShowActivity.kt' -exec \
    sed -e "/loadMoreView.error(it)/i\isLoading = false" \
        -e "/ExploreShowActivity/i\import io.legado.app.utils.longToastOnUi" \
        -e '/loadMoreView.error(it)/i\longToastOnUi(it)' \
        -e 's/loadMoreView.error(it)/loadMoreView.error("目标网站连接失败或超时")/' \
        {} -i \;
    find $APP_WORKSPACE/app/src -regex '.*/ExploreShowViewModel.kt' -exec \
    sed "s/30000L/8000L/" {} -i \;
}

function explore_can_search()
{
    debug "发现界面支持搜索书籍"
    find $APP_WORKSPACE/app/src -regex '.*/ExploreFragment.kt' -exec \
    sed -e 's/getString(R.string.screen_find)/"搜索书籍、书源"/' \
        -e '/fun initSearchView()/i\override fun onResume(){super.onResume();searchView.clearFocus()}' \
        -e '/ExploreFragment/i\import io.legado.app.ui.book.search.SearchActivity' \
        -e '/onQueryTextSubmit/a\if(!query?.contains("group:")!!){startActivity<SearchActivity> { putExtra("key", query) }}' \
        {} -i \;
}

function rhino_safe_js()
{
    debug "safe JsExtensions.kt"
    if version_ge "$APP_TAG" "3.21.021012"; then
        sed -e '/^import io.legado.app.App$/c\import splitties.init.appCtx' \
            -e 's/(App.INSTANCE)/(appCtx)/' \
            $GITHUB_WORKSPACE/.github/fake/safe_JsExtensions.kt -i
    fi
    if version_ge "$APP_TAG" "3.21.031511"; then
        sed "s/str.htmlFormat()/HtmlFormatter.formatKeepImg(str)/" \
            $GITHUB_WORKSPACE/.github/fake/safe_JsExtensions.kt -i
    fi
    find $APP_WORKSPACE/app/src -type d -regex '.*/app/help' -exec \
    cp $GITHUB_WORKSPACE/.github/fake/safe_JsExtensions.kt {}/JsExtensions.kt \;

    debug "开启Rhino安全沙箱,移步https://github.com/10bits/rhino-android"
    sed "/gedoor:rhino-android/c\    implementation 'com.github.10bits:rhino-android:1.6'" \
        $APP_WORKSPACE/app/build.gradle -i
}

function no_google_services()
{
    debug "删除google services相关"
    sed -e "/com.google.firebase/d" \
        -e "/com.google.gms/d" \
        -e "/androidx.appcompat/a\    implementation 'androidx.documentfile:documentfile:1.0.1'" \
        $APP_WORKSPACE/app/build.gradle -i
}

if [[ "$APP_NAME" == "legado" ]] && [[ "$REPO_ACTOR" == "10bits" ]]; then
    exploreShow_be_better;
    bookshelfAdd_no_alert;
    build_gradle_setting;
    explore_can_search;
    no_google_services;
    rhino_safe_js;
fi
