#!/bin/sh
#本脚本会定时更新README.md里的最新tag显示

function set_env() { echo "$1=$2" >> $GITHUB_ENV; }

APP_NAME="legado"
APP_GIT_URL="https://github.com/gedoor/legado.git"
APP_SUFFIX="A"
APP_WORKSPACE="/opt/$APP_NAME"
APP_UPLOAD="$APP_WORKSPACE/app/build/outputs/apk/app/release"
APP_LAUNCH_NAME="阅读.$APP_SUFFIX"

set_env APP_NAME        $APP_NAME
set_env APP_LAUNCH_NAME $APP_LAUNCH_NAME
set_env APP_WORKSPACE   $APP_WORKSPACE
set_env APP_SUFFIX      $APP_SUFFIX
set_env APP_UPLOAD      $APP_UPLOAD
set_env SECRETS_MINIFY  $SECRETS_MINIFY 
set_env SECRETS_RENAME  $SECRETS_RENAME 

git clone $APP_GIT_URL $APP_WORKSPACE

cd $APP_WORKSPACE
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
LatestCheck=$(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")
git checkout $LatestTag
set_env APP_LATEST_TAG    $LatestTag
set_env APP_LATEST_CHECK  "$LatestCheck"
set_env APP_UPLOAD_NAME   $APP_NAME-$LatestTag
set_env APP_LAST_TAG      $(cat $GITHUB_WORKSPACE/.lastcheck|sed -n 1p)
