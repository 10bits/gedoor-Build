#!/bin/sh
#本脚本会定时更新README.md里的最新tag显示
source $GITHUB_WORKSPACE/action_setenv.sh
source $GITHUB_WORKSPACE/action_clone.sh

LatestTag=$(init_workspace)
LatestCheck=$(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")
cd $GITHUB_WORKSPACE
sed "5c > 当前最新tag:$LatestTag 上次检查时间:$LatestCheck" README.md -i
git config user.name  github-actions
git config user.email github-actions@github.com
git commit -a -m "update readme.md"
git push

