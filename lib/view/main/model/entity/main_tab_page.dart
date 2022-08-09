import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_icons.dart';
import 'package:playflutter/view/home/home.dart';
import 'package:playflutter/view/me/me.dart';
import 'package:playflutter/view/square/square.dart';
import 'package:playflutter/view/system/system.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description
class MainTabPage {
  late final IconData normalIcon;
  late final IconData pressIcon;
  late final String label;
  late final Widget page;

  MainTabPage(
      {required this.normalIcon,
      required this.pressIcon,
      required this.label,
      required this.page});

  static List<MainTabPage> getMainTabPages() {
    var list = <MainTabPage>[];
    list.add(MainTabPage(
        normalIcon: ThemeIcons.homeNormal,
        pressIcon: ThemeIcons.homePress,
        label: "home",
        page: const HomePage()));

    list.add(MainTabPage(
        normalIcon: ThemeIcons.squareNormal,
        pressIcon: ThemeIcons.squarePress,
        label: "square",
        page: const SquarePage()));

    list.add(MainTabPage(
        normalIcon: ThemeIcons.systemNormal,
        pressIcon: ThemeIcons.systemPress,
        label: "system",
        page: const SystemPage()));

    list.add(MainTabPage(
        normalIcon: ThemeIcons.meNormal,
        pressIcon: ThemeIcons.mePress,
        label: "me",
        page: const MePage()));

    return list;
  }

}
