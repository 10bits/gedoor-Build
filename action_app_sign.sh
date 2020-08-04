#!/bin/sh
#本脚本用来给app增加签名

cp $GITHUB_WORKSPACE/.github/workflows/legado.jks $workspace/app/legado.jks
sed '$a\RELEASE_STORE_FILE=./legado.jks'          $workspace/gradle.properties -i 
sed '$a\RELEASE_KEY_ALIAS=legado'                 $workspace/gradle.properties -i
sed '$a\RELEASE_STORE_PASSWORD=gedoor_legado'     $workspace/gradle.properties -i
sed '$a\RELEASE_KEY_PASSWORD=gedoor_legado'       $workspace/gradle.properties -i
