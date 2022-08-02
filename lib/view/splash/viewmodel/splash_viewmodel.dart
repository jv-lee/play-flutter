import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/theme/theme_images.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description app闪屏页viewModel类
class SplashViewModel extends ViewModel {
  SplashViewModel(super.context);

  bool splashAdVisible = false;

  @override
  void init() {
    requestSplashAd();
  }

  @override
  void unInit() {}

  void requestSplashAd() {
    splashAdVisible = true;
  }

  String findSplashRes() {
    final brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.light) {
      return ThemeImages.splash_light_png;
    } else {
      return ThemeImages.splash_dark_png;
    }
  }
}
