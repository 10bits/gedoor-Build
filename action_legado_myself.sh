#!/bin/sh

function debug() { echo "::debug::$1"; }

#阅读3.0自用定制脚本
if [[ "$APP_NAME" = "legado" ]] && [[ "$REPO_ACTOR" = "10bits" ]]; then 

    debug "maven中心仓库回归"
    sed "/google()/i\        mavenCentral()" $APP_WORKSPACE/build.gradle -i

    debug "发现书籍界面优化"
    find $APP_WORKSPACE/app/src -regex '.*/ExploreShowActivity.kt' -exec \
    sed -e "/loadMoreView.error(it)/i\isLoading = false" \
        -e "/ExploreShowActivity/i\import org.jetbrains.anko.toast" \
        -e '/loadMoreView.error(it)/i\toast(it)' \
        -e 's/loadMoreView.error(it)/loadMoreView.error("网络请求失败或超时")/' \
        {} -i \;
    find $APP_WORKSPACE/app/src -regex '.*/ExploreShowViewModel.kt' -exec \
    sed "s/30000L/6000L/" {} -i \;
        
    debug "关闭加入书架提示"
    START=$(sed -n '/!ReadBook.inBookshelf/=' $APP_WORKSPACE/app/src/main/java/io/legado/app/ui/book/read/ReadBookActivity.kt)
    find $APP_WORKSPACE/app/src -regex '.*/ReadBookActivity.kt' -exec \
    sed -e "$(echo $START+1|bc),$(echo $START+8|bc)d" \
        -e '/!ReadBook.inBookshelf/a\viewModel.removeFromBookshelf{ super.finish() }' \
        {} -i \;
        
    debug "发现界面支持搜索书籍"
    find $APP_WORKSPACE/app/src -regex '.*/ExploreFragment.kt' -exec \
    sed -e 's/getString(R.string.screen_find)/"搜索书籍、书源"/' \
        -e '/fun initSearchView()/i\override fun onResume(){super.onResume();searchView.clearFocus()}' \
        -e '/ExploreFragment/i\import io.legado.app.ui.book.search.SearchActivity' \
        -e '/onQueryTextSubmit/a\if(!query?.contains("group:")!!){startActivity<SearchActivity>(Pair("key", query))}' \
        {} -i \;

    debug "safe JsExtensions.kt"
    find $APP_WORKSPACE/app/src -type d -regex '.*/app/help' -exec \
    cp $GITHUB_WORKSPACE/fake/safe_JsExtensions.kt {}/JsExtensions.kt \;
    
    debug "开启Rhino安全沙箱,移步https://github.com/10bits/rhino-android"
    sed "/gedoor:rhino-android/c\    implementation 'com.github.10bits:rhino-android:1.6'" $APP_WORKSPACE/app/build.gradle -i

fi
