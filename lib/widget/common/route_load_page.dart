import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/30
/// @description route动画执行完毕后加载view
/// 某些view加载效率较差或者比较复杂的使用该方式让route动画先执行完毕再加载widget
class RouteLoadPage extends StatefulWidget {
  final Widget child;

  const RouteLoadPage({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RouteLoadState();
}

class _RouteLoadState extends State<RouteLoadPage> {
  bool _animationCompleted = false;

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);
    if (route != null && !_animationCompleted) {
      void handler(status) {
        if (status == AnimationStatus.completed) {
          route.animation?.removeStatusListener(handler);
          setState(() {
            _animationCompleted = true;
          });
        }
      }

      route.animation?.addStatusListener(handler);
    } else {
      return widget.child;
    }
    return _animationCompleted ? widget.child : Container();
  }
}
