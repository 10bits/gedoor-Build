#!/bin/sh

function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }

cd $GITHUB_WORKSPACE
if version_gt $APP_LATEST_TAG $APP_LAST_TAG; then
  sed "5c > 最新构建下载:[$APP_RELEASE_NAME]($APP_DOWNLOAD) 上次构建时间:$APP_LATEST_CHECK" README.md -i
  sed "1i $APP_LATEST_TAG" .lastcheck -i
  git config user.name  github-actions
  git config user.email github-actions@github.com
  git commit -a -m "$APP_NAME-$APP_LATEST_TAG release"
  git push
fi
