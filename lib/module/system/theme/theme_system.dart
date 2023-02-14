// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 系统模块 资源引用类
class ThemeSystem {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Strings strings = _Strings();
  static _Routes routes = _Routes();
}

class _Constants {
  String systemList = "local:system-list";
  String navigationList = "local:navigation-list";
}

class _Dimens {
  double tabWidth = 100;
  double tabHeight = 24;
  double tabRadius = 12;
  double navigationTabHeight = 56;
}

class _Strings {
  String systemTab = "system_system_tab".localized();
  String navigationTab = "system_navigation_tab".localized();
  String moreText = "system_more_text".localized();
}

class _Routes {
  String systemContentTab = "/systemContentTab";
}
