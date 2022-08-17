import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:night/night.dart';
import 'package:playflutter/base/base_viewmodel.dart';
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
    // hide navigationBar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);

    // 当前页面执行动画
    animationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    // 页面执行逻辑
    findSplashResAsync();
    requestSplashAd();
  }

  @override
  void onCleared() {
    // show statusBar and navigationBar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    animationController.dispose();
  }

  void findSplashResAsync() async {
    Night.isDarkTheme().then((value) => viewStates.isDark = value);
  }

  void requestSplashAd() async {
    // 获取账户配置
    context.read<AccountService>().requestAccountData(() {
      // 开启动画显示splashAd
      animationController.forward();
      notifyListeners();
    });
  }
}

class _SplashViewState {
  late bool isDark;

  _SplashViewState({required this.isDark});

  String findSplashRes() {
    return isDark ? ThemeImages.splashDarkPng : ThemeImages.splashLightPng;
  }
}
