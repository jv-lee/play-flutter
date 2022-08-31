import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/extensions/function_extensions.dart';

/// @author jv.lee
/// @date 2022/8/30
/// @description web进度条动画控制
mixin WebProgressMixin<T extends StatefulWidget> on State<T> {
  final webProgressViewStates = _WebProgressViewState();

  @override
  void initState() {
    _initAnimator();
    super.initState();
  }

  @override
  void dispose() {
    _disposeAnimator();
    super.dispose();
  }

  /// webView开始加载
  void onProgressPageStarted(url) {
    // initState 开始动画，pageStart过滤掉第一次动画
    if (!webProgressViewStates._firstAnimator) {
      _startAnimator();
    }
    webProgressViewStates._firstAnimator = false;
  }

  /// webView加载完毕
  void onProgressPageFinished(url) {
    _finishAnimator();
  }

  _initAnimator() {
    assert(this is TickerProvider);

    webProgressViewStates._tickerProvider = this as TickerProvider;
    webProgressViewStates._tickerProvider?.run((self) {
      webProgressViewStates._animationController = AnimationController(
          duration: const Duration(milliseconds: 100), vsync: self);
    });
    _startAnimator();
  }

  _disposeAnimator() {
    webProgressViewStates._animationController?.run((self) => self.dispose());
  }

  _startAnimator() {
    webProgressViewStates._animationController?.run((self) {
      self.duration = const Duration(milliseconds: 5000);
      setState(() {
        webProgressViewStates.progress = 0;
        webProgressViewStates.progressVisible = true;
      });
      final endProgress = Platform.isIOS ? 100 : 80;
      var animator = IntTween(
              begin: webProgressViewStates.progress, end: endProgress)
          .animate(CurvedAnimation(parent: self, curve: Curves.easeOutCubic));
      animator.addListener(() =>
          setState(() => webProgressViewStates.progress = animator.value));
      self.reset();
      self.forward();
    });
  }

  _finishAnimator() {
    webProgressViewStates._animationController?.run((self) {
      self.duration = const Duration(milliseconds: 300);
      var animator = IntTween(begin: webProgressViewStates.progress, end: 100)
          .animate(CurvedAnimation(parent: self, curve: Curves.linear));
      animator.addListener(() =>
          setState(() => webProgressViewStates.progress = animator.value));
      void handler(status) {
        if (status == AnimationStatus.completed) {
          animator.removeStatusListener(handler);
          setState(() {
            webProgressViewStates.progressVisible = false;
          });
        }
      }

      animator.addStatusListener(handler);
      self.reset();
      self.forward();
    });
  }
}

class _WebProgressViewState {
  TickerProvider? _tickerProvider; // 动画信号提供者
  AnimationController? _animationController; // 动画控制器
  bool _firstAnimator = true;
  int progress = 0; // 进度
  bool progressVisible = true; // progress是否显示
}
