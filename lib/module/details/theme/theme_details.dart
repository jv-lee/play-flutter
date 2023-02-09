// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 详情页模块 资源引用类
class ThemeDetails {
  static _Strings strings = _Strings();
  static _Routes routes = _Routes();
}

class _Strings {
  String menuCollect = "menu_collect".localized();
  String menuShare = "menu_share".localized();
  String menuCollectCompleted = "menu_collect_completed".localized();
  String menuCollectComplete = "menu_collect_complete".localized();
}

class _Routes {
  String details = "/details";
}
