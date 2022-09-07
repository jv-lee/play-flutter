import 'package:flutter/widgets.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/db/dao/search_history_dao.dart';
import 'package:playflutter/core/model/db/entity/search_history.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/search/model/entity/search_hot.dart';
import 'package:playflutter/module/search/search.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索页面viewModel
class SearchViewModel extends BaseViewModel {
  final SearchHistoryDao _dao = SearchHistoryDao();
  final viewStates = _SearchViewState();

  SearchViewModel(super.context);

  @override
  void init() {
    _requestSearchHistoryList();
  }

  @override
  void onCleared() {}

  void navigationSearchKey(String searchKey) {
    _dao.insert(SearchHistory.buildSearchHistory(searchKey));
    _requestSearchHistoryList();
    Navigator.pushNamed(context, RouteNames.search_result,
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

  void _requestSearchHistoryList() {
    _dao.queryAll().then((value) {
      viewStates.searchHistoryList = value;
      notifyListeners();
    });
  }
}

class _SearchViewState {
  List<SearchHot> searchHots = SearchHot.getSearchHots();
  List<SearchHistory> searchHistoryList = [];
}
