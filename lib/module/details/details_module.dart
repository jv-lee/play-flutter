import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/model/entity/details.dart';
import 'package:playflutter/module/details/page/details.dart';
import 'package:playflutter/module/details/theme/theme_details.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description 详情页 模块类
class DetailsModule extends BaseModule {
  @override
  String localizationFileName() => "details";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeDetails.routes.details: (settings) {
          final arg = settings.arguments as DetailsData;
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => DetailsPage(detailsData: arg));
        }
      };
}
