// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:night/night.dart';
import 'package:playflutter/theme/theme_colors.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2020/6/1
/// @description 深色模式内容监听器工具类
class DarkModeProvider with ChangeNotifier {
  late BuildContext context;
  late ThemeData lightThemeData;
  late ThemeData darkThemeData;
  var _isSystem = true;
  var _isDark = false;

  DarkModeProvider({required this.context}) {
    _initTheme();
    _changeTheme();
  }

  void _initTheme() {
    StatusTools.defaultSystemBar(context);
    lightThemeData = ThemeColors.lightThemeData;
    darkThemeData = ThemeColors.darkThemeData;
  }

  void _changeTheme() async {
    _isSystem = await Night.isSystemTheme();
    _isDark = await Night.isDarkTheme();
    if (_isSystem) {
      StatusTools.transparentSystemBar(_isDark ? Brightness.dark : Brightness.light);
      lightThemeData = ThemeColors.lightThemeData;
      darkThemeData = ThemeColors.darkThemeData;
    } else {
      if (_isDark) {
        StatusTools.transparentSystemBar(Brightness.dark);
        lightThemeData = ThemeColors.darkThemeData;
        darkThemeData = ThemeColors.darkThemeData;
      } else {
        StatusTools.transparentSystemBar(Brightness.light);
        lightThemeData = ThemeColors.lightThemeData;
        darkThemeData = ThemeColors.lightThemeData;
      }
    }
    notifyListeners();
  }

  void _updateSystemTheme(enable) {
    Night.updateSystemTheme(enable);
    _changeTheme();
  }

  void _updateDarkTheme(enable) {
    Night.updateDarkTheme(enable);
    _changeTheme();
  }

  static isSystemTheme(BuildContext context) {
    return Provider.of<DarkModeProvider>(context)._isSystem;
  }

  static isDarkTheme(BuildContext context) {
    return Provider.of<DarkModeProvider>(context)._isDark;
  }

  static changeSystem(BuildContext context, enable) {
    context.read<DarkModeProvider>()._updateSystemTheme(enable);
  }

  static changeDark(BuildContext context, enable) {
    final provider = context.read<DarkModeProvider>();
    if(!provider._isSystem) {
      context.read<DarkModeProvider>()._updateDarkTheme(enable);
    }
  }
}
