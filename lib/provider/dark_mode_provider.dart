// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:night/night.dart';
import 'package:playflutter/theme/theme_colors.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2020/6/1
/// @description 深色模式内容监听器工具类
class DarkModeProvider with ChangeNotifier {
  static const int MODE_LIGHT = 1; // 亮色模式
  static const int MODE_DARK = 2; // 深色模式
  static const int MODE_SYSTEM = 3; // 跟随系统
  static const int MODE_UN_SYSTEM = 4; //取消跟随系统

  BuildContext context;
  int darkMode = MODE_SYSTEM;

  late ThemeData lightThemeData;
  late ThemeData darkThemeData;

  DarkModeProvider({required this.context}) {
    _init();
    _setThemeData();
  }

  _init() async {
    var isSystem = await Night.isSystemTheme;
    if (isSystem) {
      darkMode = MODE_SYSTEM;
    } else {
      darkMode = await Night.isDarkTheme() ? MODE_DARK : MODE_LIGHT;
    }
    notifyListeners();
  }

  void _setThemeData() {
    switch (darkMode) {
      case DarkModeProvider.MODE_DARK:
        {
          StatusTools.transparentStatusBar(Brightness.dark);
          lightThemeData = ThemeColors.darkThemeData;
          darkThemeData = ThemeColors.darkThemeData;
        }
        break;
      case DarkModeProvider.MODE_LIGHT:
        {
          StatusTools.transparentStatusBar(Brightness.light);
          lightThemeData = ThemeColors.lightThemeData;
          darkThemeData = ThemeColors.lightThemeData;
        }
        break;
      default:
        {
          StatusTools.defaultStatusBar(context);
          lightThemeData = ThemeColors.lightThemeData;
          darkThemeData = ThemeColors.darkThemeData;
        }
    }
  }

  void _changeMode(int darkMode) async {
    this.darkMode = darkMode;
    if (darkMode == MODE_DARK) {
      Night.updateNightTheme(true);
    } else if (darkMode == MODE_LIGHT) {
      Night.updateNightTheme(false);
    } else if (darkMode == MODE_SYSTEM) {
      Night.updateSystemTheme(true);
    } else if (darkMode == MODE_UN_SYSTEM) {
      Night.updateSystemTheme(false);
    }
    notifyListeners();
  }

  static changeSystem(BuildContext context, enable) {
    context.read<DarkModeProvider>()._changeMode(enable
        ? DarkModeProvider.MODE_SYSTEM
        : DarkModeProvider.MODE_UN_SYSTEM);
  }

  static changeDark(BuildContext context, enable) {
    context.read<DarkModeProvider>()._changeMode(
        enable ? DarkModeProvider.MODE_DARK : DarkModeProvider.MODE_LIGHT);
  }
}
