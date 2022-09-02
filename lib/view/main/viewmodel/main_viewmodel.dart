import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/event/constants/event_constants.dart';
import 'package:playflutter/event/entity/tab_selected_event.dart';
import 'package:playflutter/event/events_bus.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/main/model/entity/main_tab_page.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description 主页ViewModel
class MainViewModel extends BaseViewModel {
  final viewStates = _MainViewState();
  late AccountService accountService;

  MainViewModel(super.context);

  @override
  void init() {
    eventBus.bind(EventConstants.EVENT_NAVIGATION_LOGIN, _onNavigationLogin);
    accountService = context.read<AccountService>();
  }

  @override
  void onCleared() {
    eventBus.unbind(EventConstants.EVENT_NAVIGATION_LOGIN, _onNavigationLogin);
    viewStates.pageController.dispose();
  }

  void changeTab(index) {
    // 当前tab页面重复点击发送确认事件给当前页面
    if (index == viewStates.tabIndex) {
      eventBus.send(EventConstants.EVENT_TAB_SELECTED,
          TabSelectedEvent(tabName: viewStates.mainTabPages[index].label));
    }
    viewStates.tabIndex = index;
    viewStates.pageController.jumpToPage(index);
    notifyListeners();
  }

  void _onNavigationLogin(dynamic arg) {
    if (!isDispose()) {
      // 注销登陆状态及登陆数据
      accountService.updateAccountStatus(null, false);
      // 导航至登陆页面
      Navigator.pushNamed(context, RouteNames.login);
    }
  }
}

class _MainViewState {
  var tabIndex = 0;
  final mainTabPages = MainTabPage.getMainTabPages();
  final pageController = PageController(initialPage: 0);
}
