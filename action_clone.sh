#!/bin/sh
#本脚本用来clone远端仓库
source $GITHUB_WORKSPACE/action_util.sh
#建立工作目录
function init_workspace()
{
    git clone $APP_GIT_URL $APP_WORKSPACE
    cd $APP_WORKSPACE
    LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
    if [[ -n "$SECRETS_TAG" ]] && [[ "$REPO_ACTOR" = "$REPO_OWNER" ]]; then
        [[ "$SECRETS_TAG" = "master" ]] && LatestTag="master"
        if [[ "$APP_NAME" = "legado" ]]; then 
            if [[ -n "$(echo $LatestTag|grep -o '3\.[0-9]\{2\}\.[0-9]\{6\}')" ]]; then
                LatestTag=$SECRETS_TAG
            fi
        elif [[ "$APP_NAME" = "MyBookshelf" ]]; then
            if [[ -n "$(echo $LatestTag|grep -o '2\.[0-9]\{2\}\.[0-9]\{6\}')" ]]; then
                LatestTag=$SECRETS_TAG
            fi
        else
            [[ "$SECRETS_ENABLE" = "true" ]] && LatestTag=$SECRETS_TAG
        fi
    fi
    git checkout $LatestTag
    set_env APP_UPLOAD_NAME $APP_NAME-$LatestTag
    debug "$APP_NAME latest tag is $LatestTag"
}
init_workspace;

