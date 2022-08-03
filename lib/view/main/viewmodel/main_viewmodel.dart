import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/view/main/model/entity/main_tab_page.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description
class MainViewModel extends ViewModel {
  MainViewModel(super.context);

  int tabIndex = 0;
  late PageController pageController;
  final mainTabPages = MainTabPage.getMainTabPages();

  @override
  void init() {
    pageController = PageController(initialPage: 0);
  }

  @override
  void onCleared() {
    pageController.dispose();
  }

  void changeTab(index) {
    tabIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
