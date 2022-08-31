import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/extensions/animation_extensions.dart';
import 'package:playflutter/extensions/function_extensions.dart';

/// @author jv.lee
/// @date 2022/8/30
/// @description web进度条动画控制
mixin WebProgressMixin<T extends StatefulWidget> on State<T> {
  final webProgressViewStates = _WebProgressViewState();

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _disposeAnimation();
    super.dispose();
  }

  /// webView开始加载
  void onProgressPageStarted(url) {
    // initState 开始动画，pageStart过滤掉第一次动画
    if (!webProgressViewStates._firstAnimation) {
      _startAnimation();
    }
    webProgressViewStates._firstAnimation = false;
  }

  /// webView加载完毕
  void onProgressPageFinished(url) {
    _finishAnimation();
  }

  _initAnimation() {
    assert(this is TickerProvider);

    webProgressViewStates._tickerProvider = this as TickerProvider;
    webProgressViewStates._tickerProvider?.run((self) {
      webProgressViewStates._animationController = AnimationController(
          duration: const Duration(milliseconds: 100), vsync: self);
    });
    _startAnimation();
  }

  _disposeAnimation() {
    webProgressViewStates._animationController?.run((self) => self.dispose());
  }

  _startAnimation() {
    webProgressViewStates._animationController?.run((self) {
      self.duration = const Duration(milliseconds: 8000);
      setState(() {
        webProgressViewStates.progress = 0;
        webProgressViewStates.progressVisible = true;
      });
      final endProgress = Platform.isIOS ? 100 : 80;
      var animation = IntTween(
              begin: webProgressViewStates.progress, end: endProgress)
          .animate(CurvedAnimation(parent: self, curve: Curves.easeOutCubic));
      animation.addListener(() =>
          setState(() => webProgressViewStates.progress = animation.value));
      self.reset();
      self.forward();
    });
  }

  _finishAnimation() {
    webProgressViewStates._animationController?.run((self) {
      self.duration = const Duration(milliseconds: 300);
      var animation = IntTween(begin: webProgressViewStates.progress, end: 100)
          .animate(CurvedAnimation(parent: self, curve: Curves.linear));
      animation.addListener(() =>
          setState(() => webProgressViewStates.progress = animation.value));
      animation.addCompletedCallback(() {
        setState(() => webProgressViewStates.progressVisible = false);
      });
      self.reset();
      self.forward();
    });
  }
}

class _WebProgressViewState {
  TickerProvider? _tickerProvider; // 动画信号提供者
  AnimationController? _animationController; // 动画控制器
  bool _firstAnimation = true;
  int progress = 0; // 进度
  bool progressVisible = true; // progress是否显示
}
