import 'package:flutter/widgets.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/search_hot.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/module/search/model/dao/search_history_dao.dart';
import 'package:playflutter/module/search/model/entity/search_history.dart';
import 'package:playflutter/module/search/model/entity/search_hot_ui.dart';
import 'package:playflutter/module/search/model/search_model.dart';
import 'package:playflutter/module/search/page/search.dart';
import 'package:playflutter/module/search/search_route_names.dart';
import 'package:playflutter/module/search/theme/theme_search.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索页面viewModel
class SearchViewModel extends BaseViewModel {
  final _model = SearchModel();
  final _dao = SearchHistoryDao();
  final viewStates = _SearchViewState();

  SearchViewModel(super.context);

  @override
  void init() {
    _requestSearchHotList();
    _requestSearchHistoryList();
  }

  @override
  void onCleared() {}

  void navigationSearchKey(String searchKey) {
    _dao.insert(SearchHistory.buildSearchHistory(searchKey));
    _requestSearchHistoryList();
    Navigator.pushNamed(context, SearchRouteNames.search_result,
        arguments: {SearchPage.ARG_SEARCH_KEY: searchKey});
  }

  void deleteSearchHistory(SearchHistory history) {
    if (viewStates.searchHistoryList.isEmpty) return;
    _dao.delete(history.searchKey);
    _requestSearchHistoryList();
  }

  void clearSearchHistory() {
    if (viewStates.searchHistoryList.isEmpty) return;
    _dao.deleteAll();
    _requestSearchHistoryList();
  }

  void _requestSearchHotList() {
    Preferences.requestCache<SearchHotData>(
        localKey: ThemeSearch.constants.searchHotList,
        createJson: (json) => SearchHotData.fromJson(json),
        requestFuture: _model.getSearchHotDataAsync(),
        callback: (value) {
          viewStates.searchHots = value.data
              .map((e) => SearchHotUI.buildSearchHot(e.name))
              .toList();
          notifyListeners();
        },
        onError: (error) {});
  }

  void _requestSearchHistoryList() {
    _dao.queryAll().then((value) {
      viewStates.searchHistoryList = value;
      notifyListeners();
    });
  }
}

class _SearchViewState {
  List<SearchHotUI> searchHots = [];
  List<SearchHistory> searchHistoryList = [];
}
