#!/bin/sh
#本脚本用来clone远端仓库
echo ${{ env.workspace }}
git clone https://github.com/gedoor/legado.git ${{ env.workspace }}
cd ${{ env.workspace }}
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "最新tag:$LatestTag"
git checkout $LatestTag
echo "清空18PlusList.txt"
echo "">${{ env.workspace }}/app/src/main/assets/18PlusList.txt
