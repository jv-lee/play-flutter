import 'package:flutter/material.dart';
import 'package:playflutter/extensions/function_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/8/26
/// @description webView滚动距离控制
mixin WebScrollMixin<T extends StatefulWidget> on State<T> {
  final webScrollViewStates = _WebScrollViewState();

  @override
  void dispose() {
    webScrollViewStates._animationController?.run((self) => self.dispose());
    super.dispose();
  }

  bindWebViewController(WebViewController? webViewController) {
    webScrollViewStates._webViewController = webViewController;
  }

  bindTickerProvider(TickerProvider provider) {
    webScrollViewStates._tickerProvider = provider;
    _initAnimator();
  }

  void onMoveEvent(PointerMoveEvent event) {
    _changeNavigationVisible((controller) {
      // 手指移动距离
      var position = event.position.distance;
      // 判断移动方向差值
      var distance = position - webScrollViewStates._lastMoveY;
      // 当前offsetY值
      var offsetY = webScrollViewStates.offsetY;

      // update offsetY
      setState(() {
        if (distance > 0) {
          // 向下移动
          webScrollViewStates._scrollBottomCount++;
          offsetY -= event.position.direction;
        } else {
          // 向上移动
          webScrollViewStates._scrollTopCount++;
          offsetY += event.position.direction;
        }
        _changeOffset(offsetY);
      });

      webScrollViewStates._lastMoveY = position;
    });
  }

  void onUpEvent(PointerUpEvent event) {
    _changeNavigationVisible((controller) {
      if (webScrollViewStates._canAnimatorVisible()) {
        _animatorVisible();
      } else if (webScrollViewStates._canAnimatorHide()) {
        _animatorHide();
      } else {
        webScrollViewStates._clearScrollCount();
      }
    });
  }

  /// 查看是否满足显示webNavigation 且回调平移值
  _changeNavigationVisible(Function(WebViewController controller) function) {
    webScrollViewStates._webViewController?.run((self) async {
      if (webScrollViewStates._canNavigationVisible) {
        function(self);
        return;
      }

      // 当前支持前进回退模式（webNavigation显示状态）
      if ((await self.canGoBack() || await self.canGoForward())) {
        webScrollViewStates._canNavigationVisible = true;
        function(self);
      }
    });
  }

  _changeOffset(offset) {
    if (offset < 0) {
      webScrollViewStates.offsetY = 0;
    } else if (offset > webScrollViewStates._offsetLimit) {
      webScrollViewStates.offsetY = webScrollViewStates._offsetLimit;
    } else {
      webScrollViewStates.offsetY = offset;
    }
  }

  _initAnimator() {
    webScrollViewStates._tickerProvider?.run((self) {
      webScrollViewStates._animationController = AnimationController(
          duration: const Duration(milliseconds: 100), vsync: self);
    });
  }

  _animatorVisible() {
    webScrollViewStates._animationController?.run((self) {
      webScrollViewStates._isVisible = true;
      var animator =
          IntTween(begin: webScrollViewStates.offsetY.toInt(), end: 0)
              .animate(self);
      animator.addListener(() => setState(
          () => webScrollViewStates.offsetY = animator.value.toDouble()));
      self.reset();
      self.forward();
    });
  }

  _animatorHide() {
    webScrollViewStates._animationController?.run((self) {
      webScrollViewStates._isVisible = false;
      var animator = IntTween(
              begin: webScrollViewStates.offsetY.toInt(),
              end: webScrollViewStates._offsetLimit.toInt())
          .animate(self);
      animator.addListener(() => setState(
          () => webScrollViewStates.offsetY = animator.value.toDouble()));
      self.reset();
      self.forward();
    });
  }
}

class _WebScrollViewState {
  final _offsetLimit = ThemeDimens.toolbarHeight; // webNavigation高度，最大平移距离
  WebViewController? _webViewController; // web控制器
  TickerProvider? _tickerProvider; // 动画信号提供者
  AnimationController? _animationController; // 动画控制器
  var _canNavigationVisible =
      false; // 当前是否初始化显示webNavigation状态，显示状态初始化后才可以处理平移操作
  var _lastMoveY = 0.0; // 最后移动y轴距离
  var _isVisible = true; // 当前是否是显示状态 根据该状态设置up后的动画
  var _scrollTopCount = 0; // 向上滑动次数
  var _scrollBottomCount = 0; // 上下滑动次数
  var offsetY = 0.0; // 实际webNavigation使用平移的offsetY值

  bool _canAnimatorVisible() {
    if (!_isVisible && _scrollBottomCount > _scrollTopCount) {
      _clearScrollCount();
      return true;
    }
    return false;
  }

  bool _canAnimatorHide() {
    if (_isVisible && _scrollTopCount > _scrollBottomCount) {
      _clearScrollCount();
      return true;
    }
    return false;
  }

  void _clearScrollCount() {
    _scrollTopCount = 0;
    _scrollBottomCount = 0;
  }
}
