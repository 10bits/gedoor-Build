#!/bin/sh
#本脚本用来clone远端仓库
echo $workspace
git clone https://github.com/gedoor/legado.git $workspace
cd $workspace
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "最新tag:$LatestTag"
git checkout $LatestTag

