import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description tab选中事件实体
class TabSelectedEvent {
  final String tabName;

  TabSelectedEvent({required this.tabName});

  void onEvent(name, ScrollController scrollController) {
    if (tabName == name) {
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
}
