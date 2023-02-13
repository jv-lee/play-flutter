// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 搜索模块 资源引用类
class ThemeSearch {
  static _Constants constants = _Constants();
  static _Strings strings = _Strings();
  static _Routes routes = _Routes();
}

class _Constants {
  String searchHotList = "local:search-hot-list";
}

class _Strings {
  String searchHintText = "search_hint_text".localized();
  String searchHotLabel = "search_hot_label".localized();
  String searchHistoryLabel = "search_history_label".localized();
  String searchClearText = "search_clear_text".localized();
  String searchHistoryEmptyText = "search_history_empty_text".localized();
}

class _Routes {
  String search = "/search";
  String searchResult = "/searchResult";
}
