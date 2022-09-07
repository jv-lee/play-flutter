import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/event/constants/event_constants.dart';
import 'package:playflutter/event/entity/navigation_login_event.dart';
import 'package:playflutter/event/entity/tab_selected_event.dart';
import 'package:playflutter/event/events_bus.dart';
import 'package:playflutter/view/main/model/entity/main_tab_page.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description 主页ViewModel
class MainViewModel extends BaseViewModel {
  final viewStates = _MainViewState();

  MainViewModel(super.context);

  @override
  void init() {
    eventBus.bind(EventConstants.EVENT_NAVIGATION_LOGIN, _onNavigationLogin);
  }

  @override
  void onCleared() {
    eventBus.unbind(EventConstants.EVENT_NAVIGATION_LOGIN, _onNavigationLogin);
    viewStates.pageController.dispose();
  }

  @override
  void onResume() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
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
    if (!isDisposed() && arg is NavigationLoginEvent) {
      arg.onEvent(context);
    }
  }
}

class _MainViewState {
  var tabIndex = 0;
  final mainTabPages = MainTabPage.getMainTabPages();
  final pageController = PageController(initialPage: 0);
}
