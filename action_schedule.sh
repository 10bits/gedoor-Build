#!/bin/sh
#本脚本会定时更新README.md里的最新tag显示

function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
function set_env() { echo "$1=$2" >> $GITHUB_ENV; }

APP_NAME="legado"
APP_GIT_URL="https://github.com/gedoor/legado.git"
APP_SUFFIX="A"
APP_WORKSPACE="/opt/$APP_NAME"
APP_UPLOAD="$APP_WORKSPACE/app/build/outputs/apk/app/release"

set_env APP_NAME        $APP_NAME
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
set_env APP_LATEST_TAG  $LatestTag
set_env APP_UPLOAD_NAME $APP_NAME-$LatestTag

cd $GITHUB_WORKSPACE
set_env APP_LAST_TAG  $(cat .lastcheck|sed -n 1p)
if version_gt $LatestTag $(cat .lastcheck|sed -n 1p); then
  sed "5c > 当前最新tag:$LatestTag 上次检查时间:$LatestCheck" README.md -i
  sed "1i $LatestTag" .lastcheck -i
  git config user.name  github-actions
  git config user.email github-actions@github.com
  git commit -a -m "$APP_NAME-$LatestTag release"
  git push
fi
