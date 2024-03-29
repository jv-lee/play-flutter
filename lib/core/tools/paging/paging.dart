// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/status/status.dart';
import 'package:playflutter/core/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2020/5/14
/// @description 分页加载工具
class Paging<T> {
  final String _TAG = "Paging";

  List<T> data;
  int initPage;
  int _page = 0;
  Function notify;
  StatusController statusController;
  ScrollController scrollController;
  bool isDispose = false;

  Paging({
    required this.data,
    required this.initPage,
    required this.notify,
    required this.statusController,
    required this.scrollController,
  }) {
    _page = initPage;
  }

  static Paging<T> build<T>(
      {required ChangeNotifier notifier,
      List<T>? data,
      int? initPage,
      StatusController? statusController,
      ScrollController? scrollController}) {
    return Paging(
        data: data ?? [],
        initPage: initPage ?? 0,
        notify: notifier.notifyListeners,
        statusController: statusController ??
            StatusController(pageStatus: PageStatus.loading),
        scrollController: scrollController ?? ScrollController());
  }

  requestData(LoadStatus status,
      Future<PagingData<T>> Function(int) requestBlock) async {
    if (status == LoadStatus.refresh) {
      _page = initPage;
      LogTools.log("Paging", "refresh:$_page");
    } else if (status == LoadStatus.loadMore) {
      ++_page;
      LogTools.log("Paging", "loadMore:$_page");
    } else {
      // reload直接复用page , 如果_page == initPage代表首页数据为缓存直接递增至第二页
      if (_page == initPage) ++_page;
      LogTools.log("Paging", "reload:$_page");
    }

    requestBlock(_page).then((response) {
      if (isDispose) return;
      requestDataComplete(status, response);
      // 首页数据
      if (_page == initPage) {
        // 首页空数据
        if (response.getDataSource().isEmpty) {
          data.clear();
          statusController.pageEmpty();
          notify();
          return;
        }

        // 加载首页数据
        data.clear();
        data.addAll(response.getDataSource());
        statusController.pageComplete();

        // 是否只有一页数据
        if (response.getPageNumber() == response.getPageTotalNumber() ||
            response.getPageTotalNumber() == 1) {
          statusController.itemComplete();
        } else {
          statusController.itemLoading();
        }

        notify();
        return;
      }

      // 加载更多数据
      if (response.getPageNumber() < response.getPageTotalNumber()) {
        data.addAll(response.getDataSource());
        statusController.itemLoading();
        notify();
        return;
      }

      // 加载更多至尾页
      if (response.getPageNumber() == response.getPageTotalNumber()) {
        data.addAll(response.getDataSource());
        statusController.itemComplete();
        notify();
        return;
      }

      notify();
    }).catchError((onError) {
      if (isDispose) return;
      LogTools.log(_TAG, onError);
      submitFailed();
    });
  }

  requestDataComplete(LoadStatus status, PagingData<T> data) {}

  submitFailed() {
    // 当前列表数据加载成功，分页item不是最后一项，且数据不为空则显示itemError状态
    if (statusController.pageStatus == PageStatus.completed &&
        statusController.itemStatus != ItemStatus.end &&
        data.isNotEmpty) {
      statusController.itemError();
      // 当前列表数据未加载成功，且数据为空
    } else if (statusController.pageStatus != PageStatus.completed &&
        data.isEmpty) {
      statusController.pageError();
    }
    notify();
  }

  notifyDataChange() {
    if (data.isEmpty) {
      statusController.pageEmpty();
    } else {
      statusController.pageComplete();
    }
    notify();
  }

  dispose() {
    isDispose = true;
    statusController.dispose();
    scrollController.dispose();
    data.clear();
  }
}
