import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/project/page/project.dart';
import 'package:playflutter/module/project/project_route_names.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class ProjectModule extends BaseModule {
  @override
  String localizationFileName() => "";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ProjectRouteNames.project: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const ProjectPage()),
      };
}
