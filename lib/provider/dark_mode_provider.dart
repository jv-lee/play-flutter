import 'package:flutter/material.dart';
import 'package:night/night.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2020/6/1
/// @description
class DarkModeProvider with ChangeNotifier {
  static const int MODE_LIGHT = 1; // 亮色模式
  static const int MODE_DARK = 2; // 深色模式
  static const int MODE_SYSTEM = 3; // 跟随系统
  static const int MODE_UN_SYSTEM = 4; //取消跟随系统

  int darkMode = MODE_SYSTEM;

  DarkModeProvider() {
    _init();
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

  static changeSystem(context, enable) {
    Provider.of<DarkModeProvider>(context, listen: false)._changeMode(enable
        ? DarkModeProvider.MODE_SYSTEM
        : DarkModeProvider.MODE_UN_SYSTEM);
  }

  static changeDark(context, enable) {
    Provider.of<DarkModeProvider>(context, listen: false)._changeMode(
        enable ? DarkModeProvider.MODE_DARK : DarkModeProvider.MODE_LIGHT);
  }
}
