// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description
class ThemeSystem {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
}

class _Constants {
  String systemList = "local:system-list";
  String navigationList = "local:navigation-list";
}

class _Dimens {
  double tabWidth = 100;
  double tabHeight = 24;
  double tabRadius = 12;
  double navigationTabHeight = 56;
}
