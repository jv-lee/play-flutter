import 'package:flutter/material.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/home/page/home.dart';
import 'package:playflutter/module/me/page/me.dart';
import 'package:playflutter/module/square/page/square.dart';
import 'package:playflutter/module/system/page/system.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description 主页多tabPage数据类
class MainTabPage {
  late final IconData normalIcon;
  late final IconData pressIcon;
  late final String label;
  late final Widget page;

  static const tabHome = "home";
  static const tabSquare = "square";
  static const tabSystem = "system";
  static const tabMe = "me";

  MainTabPage(
      {required this.normalIcon,
      required this.pressIcon,
      required this.label,
      required this.page});

  static List<MainTabPage> getMainTabPages() {
    var list = <MainTabPage>[];
    list.add(MainTabPage(
        normalIcon: ThemeCommon.icons.homeNormal,
        pressIcon: ThemeCommon.icons.homePress,
        label: tabHome,
        page: const HomePage()));

    list.add(MainTabPage(
        normalIcon: ThemeCommon.icons.squareNormal,
        pressIcon: ThemeCommon.icons.squarePress,
        label: tabSquare,
        page: const SquarePage()));

    list.add(MainTabPage(
        normalIcon: ThemeCommon.icons.systemNormal,
        pressIcon: ThemeCommon.icons.systemPress,
        label: tabSystem,
        page: const SystemPage()));

    list.add(MainTabPage(
        normalIcon: ThemeCommon.icons.meNormal,
        pressIcon: ThemeCommon.icons.mePress,
        label: tabMe,
        page: const MePage()));

    return list;
  }

}
