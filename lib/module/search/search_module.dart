import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/search/model/search_route_names.dart';
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
        SearchRouteNames.search: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SearchPage()),
        SearchRouteNames.search_result: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SearchResultPage())
      };
}
