import 'dart:math';

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/7/18
/// @description 搜索热门词汇本地实体数据
class SearchHotUI {
  final String hotKey;
  final Color color;

  const SearchHotUI({required this.hotKey, required this.color});

  static getSearchHots() => [
        SearchHotUI.buildSearchHot("MVVM"),
        SearchHotUI.buildSearchHot("面试"),
        SearchHotUI.buildSearchHot("gradle"),
        SearchHotUI.buildSearchHot("动画"),
        SearchHotUI.buildSearchHot("CameraX"),
        SearchHotUI.buildSearchHot("自定义View"),
        SearchHotUI.buildSearchHot("性能优化"),
        SearchHotUI.buildSearchHot("Jetpack"),
        SearchHotUI.buildSearchHot("Kotlin"),
        SearchHotUI.buildSearchHot("Flutter"),
        SearchHotUI.buildSearchHot("OpenGL"),
        SearchHotUI.buildSearchHot("FFmpeg")
      ];

  static SearchHotUI buildSearchHot(String hotKey) {
    var random = Random();
    var color = Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
    return SearchHotUI(hotKey: hotKey, color: color);
  }

}
