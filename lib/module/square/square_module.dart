import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/square/page/create_share.dart';
import 'package:playflutter/module/square/page/my_share.dart';
import 'package:playflutter/module/square/theme/theme_square.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description 广场 模块类
class SquareModule extends BaseModule {
  @override
  String localizationFileName() => "square";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeSquare.routes.createShare: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CreateSharePage()),
        ThemeSquare.routes.myShare: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const MySharePage())
      };
}
