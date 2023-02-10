// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description 公众号模块 资源引用类
class ThemeOfficial {
  static _Constants constants = _Constants();
  static _Routes routes = _Routes();
}

class _Constants {
  String officialTab = "local:official-tab";
}

class _Routes {
  String official = "/official";
}