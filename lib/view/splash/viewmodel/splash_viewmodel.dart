import 'package:flutter/material.dart';
import 'package:night/night.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description app闪屏页viewModel类
class SplashViewModel extends BaseViewModel {
  SplashViewModel(super.context);

  late final viewStates = _SplashViewState(
      isDark: MediaQuery.platformBrightnessOf(context) == Brightness.dark);

  @override
  void init() {
    findSplashResAsync();
    requestSplashAd();
  }

  @override
  void onCleared() {}

  void findSplashResAsync() async {
    Night.isDarkTheme().then((value) => viewStates.isDark = value);
  }

  void requestSplashAd() async {
    // 获取账户配置
    context.read<AccountService>().requestAccountData(() {
      // 显示splashAd
      viewStates.splashAdVisible = true;
      notifyListeners();
    });
  }
}

class _SplashViewState {
  var splashAdVisible = false;
  late bool isDark;

  _SplashViewState({required this.isDark});

  String findSplashRes() {
    return isDark ? ThemeImages.splashDarkPng : ThemeImages.splashLightPng;
  }
}
