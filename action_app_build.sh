#!/bin/sh
source $GITHUB_WORKSPACE/action_util.sh
#开始构建
function app_build()
{
    debug "build with gradle"
    cd $APP_WORKSPACE
    chmod +x gradlew
    
    debug "加入Play版功能"
    [[ "$APP_NAME" == "legado" ]] && find $APP_WORKSPACE/app/src -regex '.*/help/AppConfig.kt' -exec \
        sed '/val isGooglePlay/c\val isGooglePlay = true' {} -i \;
        
    ./gradlew assembleAppRelease --build-cache --parallel
    
    APP_BUILD_APK=$(find $APP_WORKSPACE/app/build -regex .*/app/release/.*.apk)
    debug "build apk $APP_BUILD_APK"
    if [ -f $APP_BUILD_APK ]; then
        set_env APP_BUILD_APK $APP_BUILD_APK
        set_env APP_UPLOAD ${APP_BUILD_APK%/*}
        debug "upload apk dir ${APP_BUILD_APK%/*}"
    fi

    if [[ "$APP_NAME" == "legado" ]]; then
        ./gradlew assembleCronetRelease
        set_env CRONET_BUILD_APK $(find $APP_WORKSPACE/app/build -regex .*/cronet/release/.*.apk)
    fi
}
