// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description 项目模块 资源引用类
class ThemeProject {
  static _Constants constants = _Constants();
  static _Routes routes = _Routes();
}

class _Constants {
  String projectTab = "local:project-tab";
}

class _Routes {
  String project = "/project";
}
