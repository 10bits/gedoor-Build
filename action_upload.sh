#!/bin/sh

function debug() { echo "::debug::$1"; }

#上传到webdav
function webdav_upload()
{
  if [ $WEBDAV_UPLOAD = 'true' ] && [ -n "$WEBDAV_USER" ] && [ -n "$WEBDAV_PASS" ] && [ -n "$WEBDAV_URL" ] && [ $REPO_OWNER = $REPO_ACTOR ]; then
    debug "开始上传到webdav"
    curl -X MKCOL -u $WEBDAV_USER:$WEBDAV_PASS $WEBDAV_URL
    curl -u $WEBDAV_USER:$WEBDAV_PASS -T $1 $WEBDAV_URL
  fi
}

#TODO
function http_upload()
{
  debug "上传到http服务器"
}

#TODO
function ftp_upload()
{
  debug "上传到ftp服务器"
}

#TODO
function sftp_upload()
{
  debug "上传到sftp服务器"
}

#TODO
function baiduyun_upload()
{
 debug "上传到百度云盘"
}
