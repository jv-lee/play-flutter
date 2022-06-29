import 'package:flutter/cupertino.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description
class AppBackPopScope extends StatefulWidget {
  final Widget child;
  final int limitMillisecond;
  final String alertMessage;

  const AppBackPopScope(
      {Key? key,
      required this.child,
      this.limitMillisecond = 2000,
      this.alertMessage = ThemeStrings.back_alert_message})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppBackPopScopeState();
  }
}

class _AppBackPopScopeState extends State<AppBackPopScope> {
  var firstTime = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var secondTime = DateTime.now().millisecondsSinceEpoch;
        // 如果两次back事件时间间隔大于限制时间内，则拦截掉back事件
        if ((secondTime - firstTime) > widget.limitMillisecond) {
          Toast.show(widget.alertMessage, context);
          firstTime = secondTime;
          return false;
        }
        // 两次back事件小于限制时间内，回调back事件
        return true;
      },
      child: widget.child,
    );
  }
}
