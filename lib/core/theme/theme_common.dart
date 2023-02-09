// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 项目通用 资源引用类
class ThemeCommon {
  static _Constants constants = _Constants();
  static _Dimens dimens =_Dimens();
  static _Icons icons = _Icons();
  static _Images images = _Images();
  static _Strings strings = _Strings();
}

class _Constants {
  String isLogin = "local:is-login";
}

class _Dimens {
  // 全局通用组件数值
  double toolbarHeight = 56;
  double bannerHeight = 180;

  // 全局通用radius值
  double offsetRadiusLarge = 32;
  double offsetRadiusMedium = 16;
  double offsetRadiusSmall = 8;

  // 全局通用样式 （统一全局margin padding radius值）
  double offsetLarge = 16;
  double offsetMedium = 8;
  double offsetSmall = 4;

  // 全局通用字体size值
  double fontSizeLargeXX = 20;
  double fontSizeLargeX = 18;
  double fontSizeLarge = 16;
  double fontSizeMedium = 14;
  double fontSizeSmall = 12;
  double fontSizeSmallX = 10;

  // 通用圆角线宽度
  double borderWidth = 2;
  double floatingIconSize = 56;
}

class _Icons {
  IconData homeNormal = const IconData(0xe7d4, fontFamily: 'ThemeIcons');
  IconData homePress = const IconData(0xe7d8, fontFamily: 'ThemeIcons');

  IconData squareNormal = const IconData(0xe87c, fontFamily: 'ThemeIcons');
  IconData squarePress = const IconData(0xe887, fontFamily: 'ThemeIcons');

  IconData systemNormal = const IconData(0xe62f, fontFamily: 'ThemeIcons');
  IconData systemPress = const IconData(0xe612, fontFamily: 'ThemeIcons');

  IconData meNormal = const IconData(0xe601, fontFamily: 'ThemeIcons');
  IconData mePress = const IconData(0xe600, fontFamily: 'ThemeIcons');
}

class _Images {
  String launcherRoundPng = "assets/images/common/ic_launcher_round.png";
  String searchSvg = "assets/images/common/ic_common_search.svg";
  String addSvg = "assets/images/common/ic_common_add.svg";
  String arrowSvg = "assets/images/common/ic_common_arrow.svg";
  String helpSvg = "assets/images/common/ic_common_help.svg";
  String failedSvg = "assets/images/common/ic_common_failed.svg";
  String emptySvg = "assets/images/common/ic_common_empty.svg";
}

class _Strings {
  String loading = "loading".localized();
  String backAlertMessage = "back_alert_message".localized();
  String splashTimeText = "splash_time_text".localized();
  String loginAlert = "login_alert".localized();
  String itemDelete = "item_delete".localized();
  String titleCreate = "title_create".localized();
  String titleEdit = "title_edit".localized();
  String cancel = "cancel".localized();
  String confirm = "confirm".localized();
}
