#!/bin/sh
#本脚本会定时更新README.md里的最新tag显示

function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
function set_env() { echo ::set-env name=$1::$2; }

APP_NAME="legado"
APP_GIT_URL="https://github.com/gedoor/legado.git"
APP_SUFFIX="A"
APP_WORKSPACE="/opt/$APP_NAME"
APP_UPLOAD="$APP_WORKSPACE/app/build/outputs/apk/app/release"
SECRETS_MINIFY='true'

set_env APP_NAME        $APP_NAME
set_env APP_WORKSPACE   $APP_WORKSPACE
set_env APP_SUFFIX      $APP_SUFFIX
set_env APP_UPLOAD      $APP_UPLOAD
set_env SECRETS_MINIFY  $SECRETS_MINIFY 

git clone $APP_GIT_URL $APP_WORKSPACE
cd $APP_WORKSPACE
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
LatestCheck=$(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")
set_env APP_LATEST_TAG  $LatestTag
set_env APP_UPLOAD_NAME $APP_NAME_$LatestTag

cd $GITHUB_WORKSPACE
sed "5c > 当前最新tag:$LatestTag 上次检查时间:$LatestCheck" README.md -i
set_env APP_LAST_TAG    $(cat .github/workflows/.lastcheck|sed -n 1p)
if version_gt $LatestTag $(cat .github/workflows/.lastcheck|sed -n 1p); then
  sed "1i $LatestTag" .github/workflows/.lastcheck -i
fi

git config user.name  github-actions
git config user.email github-actions@github.com
git commit -a -m "update README.md"
git push
