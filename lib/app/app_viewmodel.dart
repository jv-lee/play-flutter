import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/module/module_manager.dart';
import 'package:playflutter/module/account/account_module.dart';
import 'package:playflutter/module/details/details_module.dart';
import 'package:playflutter/module/home/home_module.dart';
import 'package:playflutter/module/main/main_module.dart';
import 'package:playflutter/module/me/me_module.dart';
import 'package:playflutter/module/official/official_module.dart';
import 'package:playflutter/module/project/project_module.dart';
import 'package:playflutter/module/search/search_module.dart';
import 'package:playflutter/module/splash/page/splash.dart';
import 'package:playflutter/module/splash/splash_module.dart';
import 'package:playflutter/module/square/square_module.dart';
import 'package:playflutter/module/system/system_module.dart';
import 'package:playflutter/module/todo/todo_module.dart';
import 'package:provider/single_child_widget.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description app初始化数据处理
class AppViewModel {
  /// 项目模块管理器
  final ModuleManager moduleManager = ModuleManager();

  late Map<String, PageBuilder> pages;

  AppViewModel() {
    loadModules();
  }

  void loadModules() {
    moduleManager.registerModule(AccountModule());
    moduleManager.registerModule(DetailsModule());
    moduleManager.registerModule(HomeModule());
    moduleManager.registerModule(MainModule());
    moduleManager.registerModule(MeModule());
    moduleManager.registerModule(OfficialModule());
    moduleManager.registerModule(ProjectModule());
    moduleManager.registerModule(SearchModule());
    moduleManager.registerModule(SplashModule());
    moduleManager.registerModule(SquareModule());
    moduleManager.registerModule(SystemModule());
    moduleManager.registerModule(TodoModule());
    moduleManager.onInit();
    pages = moduleManager.getPageBuilders();
  }

  /// 注册模块服务
  List<SingleChildWidget> onGenerateProviders(BuildContext context) =>
      moduleManager.getModuleProviders();

  /// 注册模块路由
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return pages[settings.name]!(settings);
  }

  Widget onHome() {
    return const SplashPage();
  }
}
