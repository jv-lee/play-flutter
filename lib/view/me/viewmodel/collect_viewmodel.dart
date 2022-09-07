import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/local_paging.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/me/model/me_model.dart';
import 'package:playflutter/widget/common/sliding_pane_container.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 收藏列表viewModel
class CollectViewModel extends BaseViewModel {
  final _model = MeModel();
  final slidingPaneController = SlidingPaneController();
  late Paging<Content> paging;

  CollectViewModel(super.context);

  @override
  void init() {
    paging = LocalPaging.build(
        notifier: this,
        localKey:
        context.userKey(ThemeConstants.LOCAL_COLLECT_LIST),
        createJson: (json) => ContentDataPage.fromJson(json));
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
    _model.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Collect", "requestData - $status");

    // request collect list data.
    paging.requestData(status,
        (page) => _model.getCollectListAsync(page).then((value) => value.data));
  }

  void requestDeleteItem(Content item) {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    Future.delayed(const Duration(milliseconds: 300), () {
      _model.postUnCollectAsync(item.id, item.originId).then((value) {
        paging.data.remove(item);
        paging.notifyDataChange();
      }).catchError((onError) {
        onFailedToast(onError);
      }).whenComplete(() => Navigator.of(context).pop());
    });
  }
}
