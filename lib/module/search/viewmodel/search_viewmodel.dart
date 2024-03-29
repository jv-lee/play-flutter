import 'package:flutter/widgets.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/search_hot.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/module/search/model/dao/search_history_dao.dart';
import 'package:playflutter/module/search/model/entity/search_history.dart';
import 'package:playflutter/module/search/model/entity/search_hot_ui.dart';
import 'package:playflutter/module/search/model/search_model.dart';
import 'package:playflutter/module/search/page/search.dart';
import 'package:playflutter/module/search/theme/theme_search.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索页面viewModel
class SearchViewModel extends BaseViewModel {
  final _searchModel = SearchModel();
  final _searchHistoryDao = SearchHistoryDao();
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
    _searchHistoryDao.insert(SearchHistory.buildSearchHistory(searchKey));
    _requestSearchHistoryList();
    Navigator.pushNamed(context, ThemeSearch.routes.searchResult,
        arguments: {SearchPage.ARG_SEARCH_KEY: searchKey});
  }

  void deleteSearchHistory(SearchHistory history) {
    if (viewStates.searchHistoryList.isEmpty) return;
    _searchHistoryDao.delete(history.searchKey);
    _requestSearchHistoryList();
  }

  void clearSearchHistory() {
    if (viewStates.searchHistoryList.isEmpty) return;
    _searchHistoryDao.deleteAll();
    _requestSearchHistoryList();
  }

  void _requestSearchHotList() {
    Preferences.requestCache<SearchHotData>(
        localKey: ThemeSearch.constants.searchHotList,
        createJson: (json) => SearchHotData.fromJson(json),
        requestFuture: _searchModel.getSearchHotDataAsync(),
        callback: (value) {
          viewStates.searchHots = value.data
              .map((e) => SearchHotUI.buildSearchHot(e.name))
              .toList();
          notifyListeners();
        },
        onError: (error) {});
  }

  void _requestSearchHistoryList() {
    _searchHistoryDao.queryAll().then((value) {
      viewStates.searchHistoryList = value;
      notifyListeners();
    });
  }
}

class _SearchViewState {
  List<SearchHotUI> searchHots = [];
  List<SearchHistory> searchHistoryList = [];
}
