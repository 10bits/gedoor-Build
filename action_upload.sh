#!/bin/sh

#上传到webdav
if [ $UPLOAD = 'true' ] && [ -n "$WEBDAV_USER" ] && [ -n "$WEBDAV_PASS" ] && [ -n "$WEBDAV_URL" ] && [ $REPO_OWNER = $REPO_ACTOR ]; then
  echo "::debug::开始上传到webdav"
  curl -X MKCOL -u $WEBDAV_USER:$WEBDAV_PASS $WEBDAV_URL
  curl -u $WEBDAV_USER:$WEBDAV_PASS -T $APP_UPLOAD/*.apk $WEBDAV_URL
fi
