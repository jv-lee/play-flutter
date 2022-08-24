import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/square/model/square_model.dart';
import 'package:playflutter/widget/common/sliding_pane_container.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的分享页面viewModel
class MyShareViewModel extends BaseViewModel {
  final _model = SquareModel();
  final slidingPaneController = SlidingPaneController();
  late Paging<Content> paging;

  MyShareViewModel(super.context);

  @override
  void init() {
    paging = Paging.build(notifier: this, initPage: 1);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
    _model.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("MyShare", "requestData - $status");

    // request square list data.
    paging.requestData(status,
        (page) => _model.getMyShareDataSync(page).then((value) => value.data.shareArticles));
  }

  void requestDeleteItem(Content item) {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    Future.delayed(const Duration(milliseconds: 300), () {
      _model.postDeleteShareAsync(item.id).then((value) {
        paging.data.remove(item);
        paging.notifyDataChange();
      }).catchError((onError) {
        onFailedToast(onError);
      }).whenComplete(() => Navigator.of(context).pop());
    });
  }
}
