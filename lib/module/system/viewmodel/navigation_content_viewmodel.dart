import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/navigation_tab.dart';
import 'package:playflutter/core/theme/theme_constants.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/system/model/system_model.dart';
import 'package:playflutter/core/widget/scroll/scroll_to_index.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 体系tab navigationContent数据viewModel
class NavigationContentViewModel extends BaseViewModel {
  final _model = SystemModel();
  final viewStates = _NavigationContentViewState();
  late Paging<NavigationTab> paging;

  NavigationContentViewModel(super.context);

  @override
  void init() {
    paging = LocalPaging.build(
        notifier: this,
        initPage: 1,
        localKey: ThemeConstants.LOCAL_NAVIGATION_LIST,
        createJson: (json) => NavigationTabData.fromJson(json));
    requestData();
  }

  @override
  void onCleared() {
    viewStates.tabScrollController.dispose();
    viewStates.tagScrollController.dispose();
    _model.dispose();
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
    viewStates.isChangeTab = false;
    viewStates.tagScrollController.jumpTo(index);
    viewStates.tabSelectedIndex = index;
    viewStates.isChangeTab = true;
    notifyListeners();
  }

  /// tag列表滚动监听当前显示index动态更新tab选中
  void changeTagIndex(int index) {
    // 当前tab点击切换锁定滚动状态时 和 index重复change时不进行处理
    if (viewStates.isChangeTab && index != viewStates.tabSelectedIndex) {
      var scrollOffset = ThemeDimens.systemNavigationTabHeight * index;
      // 限制滚动最大值
      if (scrollOffset >=
          viewStates.tabScrollController.position.maxScrollExtent) {
        scrollOffset = viewStates.tabScrollController.position.maxScrollExtent;
      }

      viewStates.tabScrollController.jumpTo(scrollOffset);
      viewStates.tabSelectedIndex = index;
      notifyListeners();
    }
  }
}

class _NavigationContentViewState {
  var tabSelectedIndex = 0; // 当前tab选中index
  var isChangeTab = true; // 当前tab点击锁定状态（锁定后滚动监听事件不处理）
  ScrollController tabScrollController = ScrollController();
  ScrollToIndexController tagScrollController = ScrollToIndexController();
}
