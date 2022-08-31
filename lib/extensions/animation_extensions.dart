import 'package:flutter/material.dart';
import 'package:playflutter/extensions/function_extensions.dart';

/// @author jv.lee
/// @date 2022/8/31
/// @description 动画扩展函数
extension AnimationExtensions on Animation {
  void addCompletedCallback(Function callback) {
    void handler(status) {
      if (status == AnimationStatus.completed) {
        removeStatusListener(handler);
        callback();
      }
    }

    addStatusListener(handler);
  }

  void addStatusCallback(
      {Function? onForward,
      Function? onReverse,
      Function? onDismissed,
      Function? onCompleted}) {
    void handler(status) {
      switch (status) {
        case AnimationStatus.forward:
          onForward?.checkNullInvoke();
          break;
        case AnimationStatus.reverse:
          onReverse?.checkNullInvoke();
          break;
        case AnimationStatus.dismissed:
          removeStatusListener(handler);
          onDismissed?.checkNullInvoke();
          break;
        case AnimationStatus.completed:
          removeStatusListener(handler);
          onCompleted?.checkNullInvoke();
          break;
      }
    }

    addStatusListener(handler);
  }
}
