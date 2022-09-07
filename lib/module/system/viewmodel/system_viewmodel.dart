import 'package:flutter/widgets.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/module/system/navigation_content.dart';
import 'package:playflutter/module/system/system_content.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 体系tab viewModel
class SystemViewModel extends BaseViewModel {
  final viewStates = _SystemViewState(initIndex: 0);

  SystemViewModel(super.context);

  @override
  void init() {}

  @override
  void onCleared() {
    viewStates.pageController.dispose();
  }

  void pageChange(int index) {
    viewStates.pageController.jumpToPage(index);
    viewStates.selectedIndex = index;
    notifyListeners();
  }

  void tabChange(int index) {
    viewStates.selectedIndex = index;
    notifyListeners();
  }
}

class _SystemViewState {
  late var selectedIndex = 0;
  late List<Widget> pageList;
  late PageController pageController;

  _SystemViewState({required int initIndex}) {
    selectedIndex = initIndex;
    pageList = const [SystemContentPage(), NavigationContentPage()];
    pageController = PageController(initialPage: selectedIndex, keepPage: true);
  }
}
