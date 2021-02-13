#!/bin/sh
source $GITHUB_WORKSPACE/action_util.sh
function webdav_upload()
{
  if [[ "$WEBDAV_UPLOAD" = "true" ]] && [[ -n "$WEBDAV_AUTH" ]] && [[ -n "$WEBDAV_URL" ]] && [[ "$REPO_OWNER" = "$REPO_ACTOR" ]]; then
    debug "已开启webdav上传"
    curl -X MKCOL -u $WEBDAV_AUTH $WEBDAV_URL
    curl -u $WEBDAV_AUTH -T $1 $WEBDAV_URL
  fi
}

#TODO
function http_upload()
{
  debug "已开启http上传"
}

#TODO
function ftp_upload()
{
  debug "已开启ftp上传"
}

#TODO
function sftp_upload()
{
  debug "已开启sftp上传"
}

#TODO
function baiduyun_upload()
{
  debug "已开启百度网盘上传"
}
