#!/bin/sh
#本脚本用来获取clone项目最新tag

git clone https://github.com/gedoor/legado.git /opt/legado
cd /opt/legado
LatestCheck=$(date -u -d"+8 hour" "+%Y-%m-%d %H:%M:%S")
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "检查时间:$LatestCheck"
echo "最新tag:$LatestTag"
