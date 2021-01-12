#!/bin/sh

function debug() { echo "::debug::$1"; }

function webdav_upload()
{
  if [ $WEBDAV_UPLOAD = 'true' ] && [ -n "$WEBDAV_USER" ] && [ -n "$WEBDAV_PASS" ] && [ -n "$WEBDAV_URL" ] && [ $REPO_OWNER = $REPO_ACTOR ]; then
    debug "已开启webdav上传"
    curl -X MKCOL -u $WEBDAV_USER:$WEBDAV_PASS $WEBDAV_URL
    curl -u $WEBDAV_USER:$WEBDAV_PASS -T $1 $WEBDAV_URL
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
