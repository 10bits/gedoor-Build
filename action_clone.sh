#!/bin/sh
#本脚本用来clone远端仓库

#建立工作目录
function init_workspace()
{
    git clone $APP_GIT_URL $APP_WORKSPACE
    cd $APP_WORKSPACE
    LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
    if [ -n "$SECRETS_TAG" ]; then
        LatestTag=$SECRETS_TAG
    fi
    git checkout $LatestTag
    echo ::set-env name=APP_LATEST_TAG::$LatestTag
    echo ::set-env name=APP_UPLOAD_NAME::$APP_NAME-$LatestTag
    echo $LatestTag
}
init_workspace;

