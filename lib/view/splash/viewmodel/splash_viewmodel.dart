import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description
class SplashViewModel extends ViewModel {
  SplashViewModel(super.context);

  late Timer _timer;
  bool isToMain = false;
  bool splashAdVisible = false;
  String timeText = "";

  @override
  void init() {
    requestSplashAd();
  }

  @override
  void unInit() {}

  void requestSplashAd() {
    var readTime = 5;
    timeText = "${ThemeStrings.splash_time_text}$readTime";
    splashAdVisible = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      readTime--;
      timeText = "${ThemeStrings.splash_time_text}$readTime";
      if (readTime == 0 && !isToMain) {
        jumpToMain();
      } else {
        notifyListeners();
      }
    });
  }

  void jumpToMain() {
    isToMain = true;
    _timer.cancel();
    Navigator.pop(context);
  }

  String findSplashRes() {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) {
      return ThemeImages.splash_light_png;
    } else {
      return ThemeImages.splash_dark_png;
    }
  }
}
