import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/search/model/search_model.dart';
import 'package:playflutter/module/search/page/search.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索结果页viewModel
class SearchResultViewModel extends BaseViewModel {
  final _searchModel = SearchModel();
  final viewStates = _SearchResultViewState();

  SearchResultViewModel(super.context);

  @override
  void init() {
    viewStates.paging = Paging.build(notifier: this);

    runViewContext((context) {
      final arguments =
          (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      viewStates.searchKey = arguments[SearchPage.ARG_SEARCH_KEY];
      notifyListeners();
      requestData(LoadStatus.refresh);
    });
  }

  @override
  void onCleared() {
    viewStates.paging.dispose();
    _searchModel.dispose();
  }

  void requestData(LoadStatus status) async {
    // request searchResult list data.
    viewStates.paging.requestData(
        status,
        (page) => _searchModel
            .getSearchDataAsync(page, viewStates.searchKey)
            .then((value) => value.data));
  }
}

class _SearchResultViewState {
  late String searchKey = "";
  late Paging<Content> paging;
}
