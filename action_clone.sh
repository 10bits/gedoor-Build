#!/bin/sh
#本脚本用来clone远端仓库

function set_env() { echo "$1=$2" >> $GITHUB_ENV; }

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
    set_env APP_UPLOAD_NAME $APP_NAME-$LatestTag
    echo $LatestTag
}
init_workspace;

