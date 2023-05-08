## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.23.050309.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.23.050309/legado-3.23.050309.apk) 上次构建时间:2023-05-08 18:43:55
<!--start-->
> **2023/05/03**
> * 更新cronet: 113.0.5672.61
> * 文件类书源文件后缀识别：自动识别失败后会读取下载链接UrlOption的type字段
> ```
> https://www.example.com/file/ajzjxhxjncnc, {type: "txt"}
> ```
> * 更新cronet: 112.0.5615.135
> 
> * 源添加jsLib字段
> 
> > 注入JavaScript到RhinoJs引擎中，支持两种格式  
> > `JavaScript Code` 直接填写JavaScript片段
> > `{"example":"https://www.example.com/js/example.js", ...}` 自动复用已经下载的js文件
> 
> * 导入书源菜单添加选择选中更新源,选中新增源
> * web端迁移到vue3, 部分功能未实现
> * 添加本地密码设置,备份涉及到的敏感信息用密码加密后再备份,如webdav密码等
> * 修复epub章节异常分割的bug
> * 其它一些优化
> * 其中一些更新由 Xwite, Horis提供
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

