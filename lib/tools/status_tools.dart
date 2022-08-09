import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2020/4/30
/// @description 状态栏操作工具
class StatusTools {
  // 默认系统statusBar or navigationBar 样式设置
  static defaultSystemBar(BuildContext context) {
    transparentSystemBar(Theme.of(context).brightness);
  }

  // 根据当前主题色设置状态栏导航栏沉浸式
  static transparentSystemBar(Brightness mode) {
    if (Platform.isAndroid) {
      if (mode == Brightness.dark) {
        SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      } else {
        SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    }
  }

  static updateStatusBarIcon(Brightness mode) {
    if (mode == Brightness.dark) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // 获取状态栏高度
  static getStatusHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  // 获取navigationBar高度
  static getNavigationHeight() {
    return MediaQueryData.fromWindow(window).padding.bottom;
  }

  // 获取appBarLayoutHeight - 2 校正
  static getAppBarLayoutHeight() {
    return ThemeDimens.toolbar_height + getStatusHeight() - 2;
  }
}
