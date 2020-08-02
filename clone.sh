#!/bin/sh
#本脚本用来clone远端仓库

git clone https://github.com/gedoor/legado.git /opt/legado
cd /opt/legado
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "最新tag:$LatestTag"
git checkout $LatestTag
echo "清空18PlusList.txt"
echo "">/opt/legado/app/src/main/assets/18PlusList.txt
