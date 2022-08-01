import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/search/model/search_model.dart';
import 'package:playflutter/view/search/search.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索结果页viewModel
class SearchResultViewModel extends ViewModel {
  final _model = SearchModel();

  late String searchKey = "";
  late Paging<Content> paging;

  SearchResultViewModel(super.context);

  @override
  void init() {
    paging = Paging(
        data: [],
        initPage: 0,
        notify: notifyListeners,
        statusController: StatusController(pageStatus: PageStatus.loading));

    runViewContext((context) {
      final arguments =
          (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);
      searchKey = arguments[SearchPage.ARG_SEARCH_KEY];
      notifyListeners();
      requestData(LoadStatus.refresh);
    });
  }

  @override
  void unInit() {
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
