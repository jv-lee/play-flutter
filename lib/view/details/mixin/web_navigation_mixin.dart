import 'package:flutter/material.dart';
import 'package:playflutter/extensions/function_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/8/26
/// @description webView导航栏距离控件显示状态控制
mixin WebNavigationMixin<T extends StatefulWidget> on State<T> {
  final webNavigationViewStates = _WebNavigationViewState();

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

  void bindWebViewController(WebViewController? webViewController) {
    webNavigationViewStates._webViewController = webViewController;
  }

  /// webView开始加载
  void onNavigationPageStarted(url) {
    webNavigationViewStates.pageHolderVisible = false;
    setState(() {});
  }

  /// webView加载完毕
  void onNavigationPageFinished(url) {
    webNavigationViewStates._webViewController?.run((self) async {
      webNavigationViewStates
        ..canGoBack = await self.canGoBack()
        ..canGoForward = await self.canGoForward()
        ..webNavigationInit = (webNavigationViewStates.canGoBack ||
            webNavigationViewStates.canGoForward);
      setState(() {});
    });
  }

  void onGoBack() {
    webNavigationViewStates._webViewController?.run((self) {
      self.goBack();
      Future.delayed(const Duration(milliseconds: 100), () async {
        webNavigationViewStates
          ..canGoBack = await self.canGoBack()
          ..canGoForward = await self.canGoForward();
        setState(() {});
      });
    });
  }

  void onGoForward() {
    webNavigationViewStates._webViewController?.run((self) async {
      self.goForward();
      Future.delayed(const Duration(milliseconds: 100), () async {
        webNavigationViewStates
          ..canGoBack = await self.canGoBack()
          ..canGoForward = await self.canGoForward();
        setState(() {});
      });
    });
  }

  void onMoveEvent(PointerMoveEvent event) {
    _changeNavigationVisible((controller) {
      // 手指移动距离
      var position = event.position.distance;
      // 判断移动方向差值
      var distance = position - webNavigationViewStates._lastMoveY;
      // 当前offsetY值
      var offsetY = webNavigationViewStates.offsetY;

      // update offsetY
      setState(() {
        if (distance > 0) {
          // 向下移动
          webNavigationViewStates._scrollBottomCount++;
          offsetY -= event.position.direction;
        } else {
          // 向上移动
          webNavigationViewStates._scrollTopCount++;
          offsetY += event.position.direction;
        }
        _changeOffset(offsetY);
      });

      webNavigationViewStates._lastMoveY = position;
    });
  }

  void onUpEvent(PointerUpEvent event) {
    _changeNavigationVisible((controller) {
      if (webNavigationViewStates._canAnimationVisible()) {
        _animationVisible();
      } else if (webNavigationViewStates._canAnimationHide()) {
        _animationHide();
      } else {
        webNavigationViewStates._clearScrollCount();
      }
    });
  }

  /// 查看是否满足显示webNavigation 且回调平移值
  _changeNavigationVisible(Function(WebViewController controller) function) {
    webNavigationViewStates._webViewController?.run((self) async {
      if (webNavigationViewStates._canNavigationVisible) {
        function(self);
        return;
      }

      // 当前支持前进回退模式（webNavigation显示状态）
      if ((await self.canGoBack() || await self.canGoForward())) {
        webNavigationViewStates._canNavigationVisible = true;
        function(self);
      }
    });
  }

  _changeOffset(offset) {
    if (offset < 0) {
      webNavigationViewStates.offsetY = 0;
    } else if (offset > webNavigationViewStates._offsetLimit) {
      webNavigationViewStates.offsetY = webNavigationViewStates._offsetLimit;
    } else {
      webNavigationViewStates.offsetY = offset;
    }
  }

  _initAnimation() {
    assert(this is TickerProvider);

    webNavigationViewStates._tickerProvider = this as TickerProvider;
    webNavigationViewStates._tickerProvider?.run((self) {
      webNavigationViewStates._animationController = AnimationController(
          duration: const Duration(milliseconds: 100), vsync: self);
    });
  }

  _disposeAnimation() {
    webNavigationViewStates._animationController?.run((self) => self.dispose());
  }

  _animationVisible() {
    webNavigationViewStates._animationController?.run((self) {
      webNavigationViewStates._isVisible = true;
      var animation =
          IntTween(begin: webNavigationViewStates.offsetY.toInt(), end: 0)
              .animate(self);
      animation.addListener(() => setState(
          () => webNavigationViewStates.offsetY = animation.value.toDouble()));
      self.reset();
      self.forward();
    });
  }

  _animationHide() {
    webNavigationViewStates._animationController?.run((self) {
      webNavigationViewStates._isVisible = false;
      var animation = IntTween(
              begin: webNavigationViewStates.offsetY.toInt(),
              end: webNavigationViewStates._offsetLimit.toInt())
          .animate(self);
      animation.addListener(() => setState(
          () => webNavigationViewStates.offsetY = animation.value.toDouble()));
      self.reset();
      self.forward();
    });
  }
}

class _WebNavigationViewState {
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
  var canGoBack = false; // web是否支持回退
  var canGoForward = false; // web是否支持前进
  var webNavigationInit = false; // webNavigation是否初始化显示
  var pageHolderVisible = true; // web是否显示占位widget

  bool _canAnimationVisible() {
    if (!_isVisible && _scrollBottomCount > _scrollTopCount) {
      _clearScrollCount();
      return true;
    }
    return false;
  }

  bool _canAnimationHide() {
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
