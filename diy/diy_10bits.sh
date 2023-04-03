#!/bin/sh
source $GITHUB_WORKSPACE/action_util.sh
function my_launcher_icon(){
    debug "替换图标"
    find $APP_WORKSPACE/app/src -type d -regex '.*/res/drawable' -exec \
    cp $GITHUB_WORKSPACE/.github/legado/ic_launcher_my.xml {}/ic_launcher1.xml \;

    find $APP_WORKSPACE/app/src -regex '.*/res/.*/ic_launcher.xml' -exec \
    sed "/background/d" {} -i \;
}
my_launcher_icon;