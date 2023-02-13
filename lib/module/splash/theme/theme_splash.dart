// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description 闪屏模块 资源引用类
class ThemeSplash {
  static _Images images = _Images();
  static _Routes routes = _Routes();
}

class _Images {
  String splashLightPng = "assets/images/splash/ic_splash_light.png";
  String splashDarkPng = "assets/images/splash/ic_splash_dark.png";
  String splashAdPng = "assets/images/splash/ic_splash_ad.png";
}

class _Routes {
  String splash = "/splash";
}
