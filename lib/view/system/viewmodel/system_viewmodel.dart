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

  @override
  void init() {
    pageController = PageController(initialPage: selectedIndex, keepPage: true);
  }

  void pageChange(int index) {
    pageController.jumpToPage(index);
    setViewState(() => {selectedIndex = index});
  }

  void tabChange(int index) {
    setViewState(() => {selectedIndex = index});
  }
}
