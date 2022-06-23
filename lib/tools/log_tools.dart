import 'package:flutter/foundation.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description
class LogTools {
  static log(dynamic obj) {
    if (kDebugMode) {
      print(obj);
    }
  }
}
