#!/bin/sh
#本脚本会定时更新README.md里的最新tag显示

git clone https://github.com/gedoor/legado.git /opt/legado
cd /opt/legado
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
LatestCheck=$(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")

cd $GITHUB_WORKSPACE
sed "5c > 当前最新tag:$LatestTag 上次检查时间:$LatestCheck" README.md -i
sed "1i $LatestTag" .github/workflows/.lastcheck -i
git config user.name  github-actions
git config user.email github-actions@github.com
git commit -a -m "update README.md"
git push
