import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/account/page/login.dart';
import 'package:playflutter/module/account/page/register.dart';
import 'package:playflutter/module/search/page/search.dart';
import 'package:playflutter/module/search/page/search_result.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class SearchModule extends BaseModule {
  @override
  String localizationFileName() => "search";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        RouteNames.search: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SearchPage()),
        RouteNames.search_result: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SearchResultPage())
      };
}
