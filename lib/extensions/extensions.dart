import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description
extension FunctionExtension on Function? {
  void checkNullInvoke() {
    if (this != null) {
      this!();
    }
  }
}

typedef CheckWidget = Widget Function(Object object);

extension ObjectExtension on Object? {
  Widget hasVisible(CheckWidget checkWidget) {
    if (this != null) {
      return checkWidget(this!);
    } else {
      return Container();
    }
  }
}

extension BolleanExtension on bool {
  Widget isVisible(Widget widget) {
    if (this) {
      return widget;
    } else {
      return Container();
    }
  }
}
