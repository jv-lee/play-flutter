import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @author jv.lee
/// @date 2020/4/30
/// @description 状态栏操作工具
class StatusTools {
  //android状态栏沉浸式设置
  static transparentStatusBar() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  //android获取状态栏高度
  static getStatusHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }
}
