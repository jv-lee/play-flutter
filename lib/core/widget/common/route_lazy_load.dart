import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/animation_extensions.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';

/// @author jv.lee
/// @date 2022/8/30
/// @description route动画执行完毕后加载view
/// 某些view加载效率较差或者比较复杂的使用该方式让route动画先执行完毕再加载widget
class RouteLazyLoad extends StatefulWidget {
  final Widget child;
  final Widget? placeholder;

  const RouteLazyLoad({Key? key, required this.child, this.placeholder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RouteLazyLoadState();
}

class _RouteLazyLoadState extends State<RouteLazyLoad> {
  bool _animationCompleted = false;

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)?.run((self) {
      self.animation?.addCompletedCallback(() {
        setState(() => _animationCompleted = true);
      });
    });

    return _animationCompleted
        ? widget.child
        : widget.placeholder ?? Container();
  }
}
