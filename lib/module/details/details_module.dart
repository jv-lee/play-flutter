import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/model/entity/details.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/details/page/details.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class DetailsModule extends BaseModule {
  @override
  String localizationFileName() => "details";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        RouteNames.details: (settings) {
          final arg = settings.arguments as DetailsData;
          return CupertinoPageRoute(
              settings: settings,
              builder: (_) => DetailsPage(detailsData: arg));
        }
      };
}
