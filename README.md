## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.22.011020.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.22.011020/legado-3.22.011020.apk) 上次构建时间:2022-01-11 02:16:28
<!--start-->
> **2022/01/10**
> 
> * 继续修复txt目录识别,现在识别启用的规则,再识别禁用的规则,按目录匹配数由多到少识别,如果有章节大于5万字就尝试下一个目录规则,如果没有任何目录匹配或每章都小于5万字则自动分段
> * 修复全局搜索跳转bug
> * 从外部打开的文件如果书架上已有会对比更新时间,如果打开的文件更新会替换原文件
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

