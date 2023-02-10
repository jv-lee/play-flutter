import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/project/page/project.dart';
import 'package:playflutter/module/project/theme/theme_project.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class ProjectModule extends BaseModule {
  @override
  String localizationFileName() => "";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeProject.routes.project: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const ProjectPage()),
      };
}
