#!/bin/sh
#本脚本用来解决安装程序共存问题

#解决安装程序共存问题
sed "s/'.release'/'.releaseA'/" $workspace/app/build.gradle -i
sed 's/.release/.releaseA/'     $workspace/app/google-services.json -i 