import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/square/model/square_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description
class SquareViewModel extends BaseViewModel {
  final _model = SquareModel();
  late AccountService accountService;
  late VoidCallback _accountListener;
  late Paging<Content> paging;

  SquareViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(_accountListener = () => notifyListeners());
    paging = Paging.build(notifier: this);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    accountService.removeListener(_accountListener);
    paging.dispose();
    _model.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Square", "requestData - $status");

    // request square list data.
    paging.requestData(status,
        (page) => _model.getSquareDataAsync(page).then((value) => value.data));
  }

  void navigationCreateShared() {
    if (accountService.viewStates.isLogin) {
      Navigator.pushNamed(context, RouteNames.create_share);
    } else {
      Toast.show(ThemeStrings.loginAlert);
      Navigator.pushNamed(context, RouteNames.login);
    }
  }
}
