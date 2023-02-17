import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/official/page/official.dart';
import 'package:playflutter/module/official/theme/theme_official.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description 公众号 模块类
class OfficialModule extends BaseModule {
  @override
  String localizationFileName() => "";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeOfficial.routes.official: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const OfficialPage()),
      };
}
