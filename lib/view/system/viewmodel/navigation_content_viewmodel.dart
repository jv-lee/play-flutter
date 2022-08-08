import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/navigation_tab.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/model/system_model.dart';
import 'package:playflutter/widget/scroll/scroll_to_index.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 体系tab navigationContent数据viewModel
class NavigationContentViewModel extends BaseViewModel {
  final _model = SystemModel();

  // 当前tab选中index
  var tabSelectedIndex = 0;

  // 当前tab点击锁定状态（锁定后滚动监听事件不处理）
  var isChangeTab = true;

  ScrollController tabScrollController = ScrollController();
  ScrollToIndexController tagScrollController = ScrollToIndexController();
  late Paging<NavigationTab> paging;

  NavigationContentViewModel(super.context);

  @override
  void init() {
    paging = Paging.build(notifier: this, initPage: 1);
    requestData();
  }

  @override
  void onCleared() {
    tabScrollController.dispose();
    tagScrollController.dispose();
  }

  void requestData() async {
    LogTools.log("NavigationContent", "requestData");

    // request systemContent list data.
    paging.requestData(
        LoadStatus.refresh,
        (page) => Future.delayed(const Duration(milliseconds: 500),
            () => _model.getNavigationTabAsync()));
  }

  /// tab点击切换index选中状态
  void changeTabIndex(int index) {
    isChangeTab = false;
    tagScrollController.jumpTo(index);
    tabSelectedIndex = index;
    isChangeTab = true;
    notifyListeners();
  }

  /// tag列表滚动监听当前显示index动态更新tab选中
  void changeTagIndex(int index) {
    // 当前tab点击切换锁定滚动状态时 和 index重复change时不进行处理
    if (isChangeTab && index != tabSelectedIndex) {
      var scrollOffset = ThemeDimens.system_navigation_tab_height * index;
      // 限制滚动最大值
      if (scrollOffset >= tabScrollController.position.maxScrollExtent) {
        scrollOffset = tabScrollController.position.maxScrollExtent;
      }

      tabScrollController.jumpTo(scrollOffset);
      tabSelectedIndex = index;
      notifyListeners();
    }
  }
}
