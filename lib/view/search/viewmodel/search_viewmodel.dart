import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/db/dao/search_history_dao.dart';
import 'package:playflutter/db/entity/search_history.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/search/model/entity/search_hot.dart';
import 'package:playflutter/view/search/search.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索页面viewModel
class SearchViewModel extends ViewModel {
  final SearchHistoryDao _dao = SearchHistoryDao();
  List<SearchHot> searchHots = SearchHot.getSearchHots();
  List<SearchHistory> searchHistoryList = [];

  @override
  void init() {
    _requestSearchHistoryList();
  }

  @override
  void unInit() {}

  void navigationSearchKey(String searchKey) {
    _dao.insert(SearchHistory.buildSearchHistory(searchKey));
    _requestSearchHistoryList();
    runViewContext((context) => Navigator.pushNamed(
        context, RouteNames.search_result,
        arguments: {SearchPage.ARG_SEARCH_KEY: searchKey}));
  }

  void deleteSearchHistory(SearchHistory history) {
    if (searchHistoryList.isEmpty) return;
    _dao.delete(history.searchKey);
    _requestSearchHistoryList();
  }

  void clearSearchHistory() {
    if (searchHistoryList.isEmpty) return;
    _dao.deleteAll();
    _requestSearchHistoryList();
  }

  void _requestSearchHistoryList() {
    _dao.queryAll().then((value) {
      searchHistoryList = value;
      notifyListeners();
    });
  }
}
