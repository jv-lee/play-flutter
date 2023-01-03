import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night/night.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/module/account/service/account_service.dart';
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
    _changeTheme();
    _initAnimation();
    _initAccountData();
  }

  @override
  void onCleared() {
    animationController.dispose();
  }

  /// 设置当前默认主题模式
  void _changeTheme() {
    Night.isDarkTheme().then((value) {
      viewStates.isDark = value;
      notifyListeners();
    });
  }

  /// 当前页面执行动画
  void _initAnimation() {
    animationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
  }

  /// 请求账户信息 完成后回调splashAd动画
  void _initAccountData() {
    context.read<AccountService>().requestAccountData(() {
      viewStates.adVisible = true;
      // 开启动画显示splashAd
      animationController.forward();
      notifyListeners();
    });
  }

  /// 导航至首页
  void navigationMain() {
    Navigator.popAndPushNamed(context, RouteNames.main);
  }
}

class _SplashViewState {
  late bool isDark;
  bool adVisible = false;

  _SplashViewState({required this.isDark});

  String getThemeModeBg() {
    return isDark ? ThemeImages.splashDarkPng : ThemeImages.splashLightPng;
  }
}
