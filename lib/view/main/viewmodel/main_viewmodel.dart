import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/event/constants/event_constants.dart';
import 'package:playflutter/event/entity/tab_selected_event.dart';
import 'package:playflutter/event/events_bus.dart';
import 'package:playflutter/view/main/model/entity/main_tab_page.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description
class MainViewModel extends BaseViewModel {
  MainViewModel(super.context);

  final viewStates = _MainViewState();

  @override
  void init() {}

  @override
  void onCleared() {
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
}

class _MainViewState {
  var tabIndex = 0;
  final mainTabPages = MainTabPage.getMainTabPages();
  final pageController = PageController(initialPage: 0);
}
