// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/theme/theme_strings.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description 页面拦截back事件，设置双击退出模式
class BackPopScope extends StatelessWidget {
  final Widget child;
  final int limitMillisecond;
  final String alertMessage;
  var firstTime = 0;

  BackPopScope(
      {Key? key,
      required this.child,
      this.limitMillisecond = 2000,
      this.alertMessage = ThemeStrings.backAlertMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          var secondTime = DateTime.now().millisecondsSinceEpoch;
          // 如果两次back事件时间间隔大于限制时间内，则拦截掉back事件
          if ((secondTime - firstTime) > limitMillisecond) {
            Toast.show(alertMessage);
            firstTime = secondTime;
            return false;
          }
          // 两次back事件小于限制时间内，回调back事件
          return true;
        },
        child: child);
  }
}
