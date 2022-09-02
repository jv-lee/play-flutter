import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:night/night.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description app闪屏页viewModel类
class SplashViewModel extends BaseViewModel {
  late final viewStates = _SplashViewState(
      isDark: MediaQuery.platformBrightnessOf(context) == Brightness.dark);
  late TickerProvider tickerProvider;
  late AnimationController animationController;
  late Animation<double> animation;

  SplashViewModel(super.context, {required this.tickerProvider});

  @override
  void init() {
    // 设置当前默认主题模式
    Night.isDarkTheme().then((value) {
      viewStates.isDark = value;
      notifyListeners();
    });

    // hide navigationBar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);

    // 当前页面执行动画
    animationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    // 请求账户信息 完成后回调splashAd动画
    context.read<AccountService>().requestAccountData(() {
      // 开启动画显示splashAd
      animationController.forward();
      notifyListeners();
    });
  }

  @override
  void onCleared() {
    // show statusBar and navigationBar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    animationController.dispose();
  }

  void navigation() {
    Navigator.popAndPushNamed(context, RouteNames.main);
  }
}

class _SplashViewState {
  late bool isDark;

  _SplashViewState({required this.isDark});

  String getThemeModeBg() {
    return isDark ? ThemeImages.splashDarkPng : ThemeImages.splashLightPng;
  }
}
