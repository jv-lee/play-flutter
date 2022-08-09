import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description app闪屏页viewModel类
class SplashViewModel extends BaseViewModel {
  SplashViewModel(super.context);

  final viewStates = _SplashViewState();

  @override
  void init() {
    requestSplashAd();
  }

  @override
  void onCleared() {}

  void requestSplashAd() async {
    // 获取账户配置
    context.read<AccountService>().requestAccountData();
    // 显示splashAd
    viewStates.splashAdVisible = true;
    notifyListeners();
  }

  String findSplashRes() {
    if (DarkModeProvider.isDarkTheme(context)) {
      return ThemeImages.splashDarkPng;
    } else {
      return ThemeImages.splashLightPng;
    }
  }
}

class _SplashViewState {
  var splashAdVisible = false;
}
