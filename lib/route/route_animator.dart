import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description
class SplashPageRoute extends PageRouteBuilder {
  final Widget widget;

  SplashPageRoute({super.settings, required this.widget})
      : super(
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (context, animator1, animator2) => widget,
      transitionsBuilder: (context, animator1, animator2, child) {
        return FadeTransition(
          opacity: Tween(begin: 1.0, end: 1.0).animate(
              CurvedAnimation(parent: animator1, curve: Curves.linear)),
          child: child,
        );
      });
}
