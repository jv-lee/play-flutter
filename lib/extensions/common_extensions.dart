import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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

extension Exception on Object {
  onFailed(dynamic onError, Function(String message) callback) {
    if (onError is HttpException) {
      callback(onError.message);
    } else if (onError is DioError) {
      callback(onError.message);
    }
  }

  onFailedToast(dynamic onError) {
    if (onError is HttpException) {
      Toast.show(onError.message);
    } else if (onError is DioError) {
      Toast.show(onError.message);
    }
  }
}
