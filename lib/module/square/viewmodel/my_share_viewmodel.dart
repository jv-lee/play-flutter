import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/common/sliding_pane_container.dart';
import 'package:playflutter/core/widget/dialog/loading_dialog.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/square/model/square_model.dart';
import 'package:playflutter/module/square/theme/theme_square.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的分享页面viewModel
class MyShareViewModel extends BaseViewModel {
  final _squareModel = SquareModel();
  final slidingPaneController = SlidingPaneController();
  late Paging<Content> paging;

  MyShareViewModel(super.context);

  @override
  void init() {
    paging = LocalPaging.build(
        notifier: this,
        localKey: context.userKey(ThemeSquare.constants.shareList),
        createJson: (json) => ContentDataPage.fromJson(json),
        initPage: 1);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
    _squareModel.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("MyShare", "requestData - $status");

    // request square list data.
    paging.requestData(
        status,
        (page) => _squareModel
            .getMyShareDataSync(page)
            .then((value) => value.data.shareArticles));
  }

  void requestDeleteItem(Content item) {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    Future.delayed(const Duration(milliseconds: 300), () {
      _squareModel.postDeleteShareAsync(item.id).then((value) {
        paging.data.remove(item);
        paging.notifyDataChange();
      }).catchError((onError) {
        onFailedToast(onError);
      }).whenComplete(() => Navigator.of(context).pop());
    });
  }
}
