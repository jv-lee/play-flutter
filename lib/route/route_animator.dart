import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description AppPageRoute 基类 所有自定义动画路由类基于该类实现
abstract class AppPageRoute extends PageRoute {
  AppPageRoute({
    required super.settings,
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.barrierColor,
    this.barrierLabel,
    this.opaque = true,
    this.barrierDismissible = false,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (isActive) {
      return transitionIn(animation, secondaryAnimation, child);
    }
    return transitionOut(animation, secondaryAnimation, child);
  }

  Widget transitionIn(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child);

  Widget transitionOut(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return transitionIn(animation, secondaryAnimation, child);
  }
}

class SplashPageRoute extends AppPageRoute {
  SplashPageRoute({required super.settings, required super.builder});

  @override
  Widget transitionIn(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var tween = Tween(begin: 1.0, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: Curves.linear));
    return FadeTransition(opacity: tween, child: child);
  }
}

class MainPageRoute extends AppPageRoute {
  MainPageRoute({required super.settings, required super.builder});

  @override
  Widget transitionIn(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 当前页面执行动画
    var tween = Tween(begin: 1.0, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: Curves.linear));
    // 原页面执行动画
    var parentTween =
        Tween(begin: const Offset(0, 0), end: const Offset(-0.1, 0)).animate(
            CurvedAnimation(parent: secondaryAnimation, curve: Curves.ease));
    return FadeTransition(
        opacity: tween,
        child: SlideTransition(position: parentTween, child: child));
  }
}

class SlideInPageRoute extends AppPageRoute {
  SlideInPageRoute({required super.settings, required super.builder});

  @override
  Widget transitionIn(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 当前页面执行动画
    var tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
    // 原页面执行动画
    var parentTween =
        Tween(begin: const Offset(0, 0), end: const Offset(-0.1, 0)).animate(
            CurvedAnimation(parent: secondaryAnimation, curve: Curves.ease));
    return SlideTransition(
        position: tween,
        child: SlideTransition(position: parentTween, child: child));
  }
}

class ScaleInPageRoute extends AppPageRoute {
  ScaleInPageRoute({required super.settings, required super.builder});

  @override
  Widget transitionIn(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 当前页面执行动画
    var tween = Tween(begin: 0.95, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
    // 原页面执行动画
    var parentTween = Tween(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: secondaryAnimation, curve: Curves.ease));
    return ScaleTransition(
        scale: tween, child: ScaleTransition(scale: parentTween, child: child));
  }

  @override
  Widget transitionOut(Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // 当前页面执行动画
    var tween = Tween(begin: 0.0, end: 0.0)
        .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
    // 原页面执行动画
    var parentTween = Tween(begin: 1.0, end: 1.0).animate(
        CurvedAnimation(parent: secondaryAnimation, curve: Curves.ease));
    return FadeTransition(opacity: tween, child: ScaleTransition(scale: parentTween, child: child));
  }
}
