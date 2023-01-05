import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/official/page/official.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class OfficialModule extends BaseModule {
  @override
  String localizationFileName() => "";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        RouteNames.official: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const OfficialPage()),
      };
}
