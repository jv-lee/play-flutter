import 'dart:io';

import 'package:dio/dio.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description
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
