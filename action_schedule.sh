#!/bin/sh
#本脚本会定时更新README.md里的最新tag显示
if [ $APP_NAME = 'legado' ]; then
  cd $GITHUB_WORKSPACE
  LatestCheck=$(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")
  sed "5c > 当前最新tag:$APP_LATEST_TAG 上次检查时间:$LatestCheck" README.md -i
  sed "1i $APP_LATEST_TAG" $APP_WORKSPACE/.github/workflows/.lastcheck -i
  git config user.name  github-actions
  git config user.email github-actions@github.com
  git commit -a -m "update README.md"
  git push
fi
