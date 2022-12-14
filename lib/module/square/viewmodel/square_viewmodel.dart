import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/event/constants/event_constants.dart';
import 'package:playflutter/core/event/entity/tab_selected_event.dart';
import 'package:playflutter/core/event/events_bus.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/core/theme/theme_constants.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/main/model/entity/main_tab_page.dart';
import 'package:playflutter/module/square/model/square_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description
class SquareViewModel extends BaseViewModel {
  final _model = SquareModel();
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
        localKey: ThemeConstants.LOCAL_SQUARE_LIST,
        createJson: (json) => ContentDataPage.fromJson(json));
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    eventBus.unbind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    accountService.removeListener(notifyListeners);
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
      Toast.show("login_alert".localized());
      Navigator.pushNamed(context, RouteNames.login);
    }
  }

  void _onTabSelectedEvent(dynamic arg) {
    if (!isDisposed() && arg is TabSelectedEvent) {
      arg.onEvent(MainTabPage.tabSquare, paging.scrollController);
      notifyListeners();
    }
  }
}
