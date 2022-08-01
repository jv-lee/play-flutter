import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/theme/theme_images.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description
class SplashViewModel extends ViewModel {
  SplashViewModel(super.context);

  @override
  void init() {
    runViewContextDelay(const Duration(milliseconds: 1000), (context) {
      Navigator.pop(context);
    });
  }

  @override
  void unInit() {}

  String findSplashRes() {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) {
      return ThemeImages.splash_light_png;
    } else {
      return ThemeImages.splash_dark_png;
    }
  }
}
