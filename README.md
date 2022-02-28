## legado阅读3.0自动构建[![Android CI](https://github.com/10bits/gedoor-Build/workflows/Android%20CI/badge.svg)](https://github.com/10bits/gedoor-Build/actions)

默认从最新发布的tag构建,每次构建会自动清空18PlusList.txt

> 最新构建下载:[legado-3.22.022814.apk](https://github.com/10bits/gedoor-Build/releases/download/legado-3.22.022814/legado-3.22.022814.apk) 上次构建时间:2022-02-28 20:23:04
<!--start-->
> **2022/02/27**
> 
> * APP内编写规则时，对由XPath|JSOUP|CSS组成的规则进行简单的默认补全。
>   * 对需求文本的获取text
>   * 对需求文本的img元素(以img结尾)的获取alt属性
>   * 对需求链接的获取href属性
>   * 对需求图片的获取src属性
>   * 详情页预处理存在js/json/正则的不对详情页规则进行补全
>   * 多条规则只补全最后一条规则
>   * 书源编辑页点击调试/保存时补全开始生效
>   * 注意:不改变编辑框内容显示，保存后再次编辑可查看补全后的规则，方便调试时快速修改规则
> * 在线朗读采用exoPlayer
> 
<!--end-->
  
使用app过程中遇到问题,请到这里解决[gedoor/legado](https://github.com/gedoor/legado/issues)

