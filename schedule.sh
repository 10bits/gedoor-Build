#!/bin/sh

#定时更新readme.md里的最新tag
git clone https://github.com/gedoor/legado.git /opt/legado

cd /opt/legado
LatestCheck = $(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")
LatestTag   = $(git describe --tags `git rev-list --tags --max-count=1`)
echo "检查时间:$LatestCheck"
echo "最新tag:$LatestTag"

cd $GITHUB_WORKSPACE
sed "5c > 当前最新tag:$LatestTag 上次检查时间:$LatestCheck" readme.md -i

if git status|grep -wq "nothing to commit"
then
  echo "nothing to commit"
else
  git config user.name github-actions
  git config user.email github-actions@github.com
  git commit -a -m "update readme.md"
  git push
fi
