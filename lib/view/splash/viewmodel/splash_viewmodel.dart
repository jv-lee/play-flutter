import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:provider/provider.dart';

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
  void onCleared() {}

  void requestSplashAd() async {
    // 获取账户配置
    context.read<AccountService>().requestAccountData();
    // 显示splashAd
    splashAdVisible = true;
    notifyListeners();
  }

  String findSplashRes() {
    if (DarkModeProvider.isDarkTheme(context)) {
      return ThemeImages.splash_dark_png;
    } else {
      return ThemeImages.splash_light_png;
    }
  }
}
