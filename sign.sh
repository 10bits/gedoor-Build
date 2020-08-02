#!/bin/sh
#本脚本用来给app增加签名

cp $GITHUB_WORKSPACE/.github/workflows/legado.jks /opt/legado/app/legado.jks
sed '$a\RELEASE_STORE_FILE=./legado.jks'          /opt/legado/gradle.properties -i 
sed '$a\RELEASE_KEY_ALIAS=legado'                 /opt/legado/gradle.properties -i
sed '$a\RELEASE_STORE_PASSWORD=gedoor_legado'     /opt/legado/gradle.properties -i
sed '$a\RELEASE_KEY_PASSWORD=gedoor_legado'       /opt/legado/gradle.properties -i
