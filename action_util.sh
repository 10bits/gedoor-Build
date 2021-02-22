#!/bin/sh
function set_env() { echo "$1=$2" >> $GITHUB_ENV; }
function debug() { echo "::debug::$1"; }
function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
function version_le() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" == "$1"; }
function version_lt() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; }
function version_ge() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"; }

function update_info()
{
    cd $GITHUB_WORKSPACE
    if version_gt $APP_LATEST_TAG $APP_LAST_TAG; then
        sed -e 's/^/> &/' \
            -e '1i\<!--start-->' \
            -e '$a\<!--end-->' \
            -e 's/\r//' \
            $APP_LATEST_BODY -i
        sed -e '/<!--start-->/,/<!--end-->/d' \
            -e '5r '"$APP_LATEST_BODY"'' \
            -e "5c > 最新构建下载:[$APP_RELEASE_NAME]($APP_DOWNLOAD) 上次构建时间:$APP_LATEST_CHECK" \
            README.md -i
        sed "1i $APP_LATEST_TAG" .lastcheck -i
 
        git config user.name  github-actions
        git config user.email github-actions@github.com
        git commit -a -m "$APP_NAME-$APP_LATEST_TAG release"
        git push
    fi
}

function webdav_upload()
{
    if [[ "$WEBDAV_UPLOAD" == "true" ]] && [[ -n "$WEBDAV_AUTH" ]] && [[ -n "$WEBDAV_URL" ]] && [[ "$REPO_OWNER" == "$REPO_ACTOR" ]]; then
        debug "已开启webdav上传"
        curl -X MKCOL -u $WEBDAV_AUTH $WEBDAV_URL
        curl -u $WEBDAV_AUTH -T $1 $WEBDAV_URL
    fi
}
