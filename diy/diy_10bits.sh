#!/bin/sh
source $GITHUB_WORKSPACE/action_app_custom.sh
function my_launcher_icon(){
    debug "替换图标"
    find $APP_WORKSPACE/app/src -type d -regex '.*/res/drawable' -exec \
    cp $GITHUB_WORKSPACE/.github/legado/ic_launcher_my.xml {}/ic_launcher1.xml \;

    find $APP_WORKSPACE/app/src -regex '.*/res/.*/ic_launcher.xml' -exec \
    sed "/background/d" {} -i \;
}
function bookshelfAdd_no_alert()
{
    debug "关闭加入书架提示"
    find $APP_WORKSPACE/app/src -regex '.*/ReadBookActivity.kt' -exec \
    sed -e '/fun finish()/,/fun onDestroy()/{s/alert/\/*&/;s/show()/&*\//}' \
        -e '/!ReadBook.inBookshelf/a\viewModel.removeFromBookshelf{ super.finish() }' \
        {} -i \;
}
my_launcher_icon;
bookshelfAdd_no_alert;
