import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/view/system/navigation_content.dart';
import 'package:playflutter/view/system/system_content.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 体系tab viewModel
class SystemViewModel extends ViewModel {
  var selectedIndex = 0;
  var pageList = const [SystemContentPage(), NavigationContentPage()];
  late PageController pageController;

  SystemViewModel(super.context);

  @override
  void init() {
    pageController = PageController(initialPage: selectedIndex, keepPage: true);
  }

  @override
  void onCleared() {
    pageController.dispose();
  }

  void pageChange(int index) {
    pageController.jumpToPage(index);
    selectedIndex = index;
    notifyListeners();
  }

  void tabChange(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
