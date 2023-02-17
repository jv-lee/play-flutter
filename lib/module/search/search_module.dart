import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/search/page/search.dart';
import 'package:playflutter/module/search/page/search_result.dart';
import 'package:playflutter/module/search/theme/theme_search.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description 搜索模块类
class SearchModule extends BaseModule {
  @override
  String localizationFileName() => "search";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeSearch.routes.search: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SearchPage()),
        ThemeSearch.routes.searchResult: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SearchResultPage())
      };
}
