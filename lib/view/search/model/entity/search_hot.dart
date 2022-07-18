import 'dart:math';

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/7/18
/// @description 搜索热门词汇本地实体数据
class SearchHot {
  final String hotKey;
  final Color color;

  const SearchHot({required this.hotKey, required this.color});

  static getSearchHots() => [
        SearchHot.buildSearchHot("MVVM"),
        SearchHot.buildSearchHot("面试"),
        SearchHot.buildSearchHot("gradle"),
        SearchHot.buildSearchHot("动画"),
        SearchHot.buildSearchHot("CameraX"),
        SearchHot.buildSearchHot("自定义View"),
        SearchHot.buildSearchHot("性能优化"),
        SearchHot.buildSearchHot("Jetpack"),
        SearchHot.buildSearchHot("Kotlin"),
        SearchHot.buildSearchHot("Flutter"),
        SearchHot.buildSearchHot("OpenGL"),
        SearchHot.buildSearchHot("FFmpeg")
      ];

  static SearchHot buildSearchHot(String hotKey) {
    var random = Random();
    var color = Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
    return SearchHot(hotKey: hotKey, color: color);
  }

}
