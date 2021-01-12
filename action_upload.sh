#!/bin/sh

#上传到webdav
function webdav_upload()
{
  if [ $WEBDAV_UPLOAD = 'true' ] && [ -n "$WEBDAV_USER" ] && [ -n "$WEBDAV_PASS" ] && [ -n "$WEBDAV_URL" ] && [ $REPO_OWNER = $REPO_ACTOR ]; then
    echo "::debug::开始上传到webdav"
    curl -X MKCOL -u $WEBDAV_USER:$WEBDAV_PASS $WEBDAV_URL
    curl -u $WEBDAV_USER:$WEBDAV_PASS -T $1 $WEBDAV_URL
  fi
}

#TODO
function http_upload()
{

}

#TODO
function ftp_upload()
{

}

#TODO
function sftp_upload()
{

}

#TODO
function baiduyun_upload()
{

}
