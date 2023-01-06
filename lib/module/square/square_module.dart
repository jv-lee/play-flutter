import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/square/page/create_share.dart';
import 'package:playflutter/module/square/page/my_share.dart';
import 'package:playflutter/module/square/square_route_names.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class SquareModule extends BaseModule {
  @override
  String localizationFileName() => "square";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        SquareRouteNames.create_share: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CreateSharePage()),
        SquareRouteNames.my_share: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const MySharePage())
      };
}
