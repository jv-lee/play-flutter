import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/search/model/search_model.dart';
import 'package:playflutter/view/search/search.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索结果页viewModel
class SearchResultViewModel extends BaseViewModel {
  final _model = SearchModel();

  late String searchKey = "";
  late Paging<Content> paging;

  SearchResultViewModel(super.context);

  @override
  void init() {
    paging = Paging.build(notifier: this);

    runViewContext((context) {
      final arguments =
          (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      searchKey = arguments[SearchPage.ARG_SEARCH_KEY];
      notifyListeners();
      requestData(LoadStatus.refresh);
    });
  }

  @override
  void onCleared() {
    paging.dispose();
  }

  void requestData(LoadStatus status) async {
    // request searchResult list data.
    paging.requestData(
        status,
        (page) => _model
            .getSearchDataAsync(page, searchKey)
            .then((value) => value.data));
  }
}
