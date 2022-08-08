import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
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
    viewStates.tabIndex = index;
    viewStates.pageController.jumpToPage(index);
    notifyListeners();
  }
}

class _MainViewState {
  int tabIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  final mainTabPages = MainTabPage.getMainTabPages();
}
