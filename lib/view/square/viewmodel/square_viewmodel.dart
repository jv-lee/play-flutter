import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/square/model/SquareModel.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description
class SquareViewModel extends ViewModel {
  final _model = SquareModel();
  late AccountService accountService;
  late VoidCallback accountListener;
  late Paging<Content> paging;

  SquareViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(accountListener = () => notifyListeners());
    paging = Paging(
        data: [],
        initPage: 0,
        notify: notifyListeners,
        statusController: StatusController(pageStatus: PageStatus.loading));
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    accountService.removeListener(accountListener);
    paging.dispose();
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
      Toast.show(ThemeStrings.login_alert);
      Navigator.pushNamed(context, RouteNames.login);
    }
  }
}
