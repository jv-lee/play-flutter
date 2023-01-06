import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/model/entity/parent_tab.dart';
import 'package:playflutter/module/system/page/system_content_tab.dart';
import 'package:playflutter/module/system/system_route_names.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class SystemModule extends BaseModule {
  @override
  String localizationFileName() => "system";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        SystemRouteNames.system_content_tab: (settings) {
          final arg = settings.arguments as ParentTab;
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => SystemContentTabPage(item: arg));
        }
      };
}
