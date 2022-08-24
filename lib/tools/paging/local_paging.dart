// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/8/24
/// @description 支持首页缓存的分页加载工具
class LocalPaging<T> extends Paging<T> {
  final String localKey;
  final CreateJson<PagingData<T>> createJson;
  var initRequest = true;

  LocalPaging(
      {required this.localKey,
      required this.createJson,
      required super.data,
      required super.initPage,
      required super.notify,
      required super.statusController,
      required super.scrollController});

  static LocalPaging<T> build<T>(
      {required ChangeNotifier notifier,
      required String localKey,
      required CreateJson<PagingData<T>> createJson,
      List<T>? data,
      int? initPage,
      StatusController? statusController,
      ScrollController? scrollController}) {
    return LocalPaging(
        localKey: localKey,
        createJson: createJson,
        data: data ?? [],
        initPage: initPage ?? 0,
        notify: notifier.notifyListeners,
        statusController: statusController ??
            StatusController(pageStatus: PageStatus.loading),
        scrollController: scrollController ?? ScrollController());
  }

  @override
  requestData(LoadStatus status,
      Future<PagingData<T>> Function(int) requestBlock) async {
    // 首次请求刷新使用缓存数据 + 网络数据填充
    if (initRequest && status == LoadStatus.refresh) {
      initRequest = false;

      // 获取缓存数据
      var localData =
          await LocalTools.localData(localKey, (json) => createJson(json));

      // 校验缓存数据
      if (localData != null && localData.getDataSource().isNotEmpty) {
        data.addAll(localData.getDataSource());
        notifyDataChange();
      }
    }
    // 网络请求
    super.requestData(status, requestBlock);
  }

  @override
  requestDataComplete(LoadStatus status, PagingData<T> data) {
    // 首页数据缓存
    if (status == LoadStatus.refresh && data.getDataSource().isNotEmpty) {
      LocalTools.localSave(localKey, data);
    }
  }
}
