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
import 'package:playflutter/module/me/model/me_model.dart';
import 'package:playflutter/module/me/theme/theme_constants_me.dart';

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
        context.userKey(ThemeConstantsMe.LOCAL_COLLECT_LIST),
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
