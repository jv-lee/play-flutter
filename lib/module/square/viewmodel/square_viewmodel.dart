import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/event/constants/event_constants.dart';
import 'package:playflutter/core/event/entity/tab_selected_event.dart';
import 'package:playflutter/core/event/events_bus.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';
import 'package:playflutter/module/main/model/entity/main_tab_page.dart';
import 'package:playflutter/module/square/model/square_model.dart';
import 'package:playflutter/module/square/theme/theme_square.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description 广场页面viewModel
class SquareViewModel extends BaseViewModel {
  final _squareModel = SquareModel();
  late AccountService accountService;
  late Paging<Content> paging;

  SquareViewModel(super.context);

  @override
  void init() {
    eventBus.bind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    accountService = context.read<AccountService>();
    accountService.addListener(notifyListeners);
    paging = LocalPaging.build(
        notifier: this,
        localKey: ThemeSquare.constants.squareList,
        createJson: (json) => ContentDataPage.fromJson(json));
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    eventBus.unbind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    accountService.removeListener(notifyListeners);
    paging.dispose();
    _squareModel.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Square", "requestData - $status");

    // request square list data.
    paging.requestData(status,
        (page) => _squareModel.getSquareDataAsync(page).then((value) => value.data));
  }

  void navigationCreateShared() {
    if (accountService.viewStates.isLogin) {
      Navigator.pushNamed(context, ThemeSquare.routes.createShare);
    } else {
      Toast.show(ThemeCommon.strings.loginAlert);
      Navigator.pushNamed(context, ThemeAccount.routes.login);
    }
  }

  void _onTabSelectedEvent(dynamic arg) {
    if (!isDisposed() && arg is TabSelectedEvent) {
      arg.onEvent(MainTabPage.tabSquare, paging.scrollController);
      notifyListeners();
    }
  }
}
