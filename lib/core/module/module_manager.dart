import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/provider/dark_mode_provider.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// @author jv.lee
/// @date 2023/1/4
/// @description 业务模块管理类
class ModuleManager {
  final List<BaseModule> _modules = List.empty(growable: true);

  void registerModule(BaseModule module) {
    _modules.add(module);
  }

  void onInit() {
    for (var module in _modules) {
      module.onInit();
    }
  }

  void dispose() {
    for (var module in _modules) {
      module.dispose();
    }

    _modules.clear();
  }

  Map<String, PageBuilder> getPageBuilders() {
    Map<String, PageBuilder> pageBuilders = {};
    for (var module in _modules) {
      pageBuilders.addAll(module.pageBuilders());
    }
    return pageBuilders;
  }

  List<SingleChildWidget> getModuleProviders() {
    final List<SingleChildWidget> providers = [
      ChangeNotifierProvider(
          create: (context) => DarkModeProvider(context: context)),
      ChangeNotifierProvider(create: (context) => AccountService(context))
    ];

    return providers;
  }

  /// 获取多语言文件名字列表
  List<String> getLocalizationFileNames() {
    final list =
        _modules.map((module) => module.localizationFileName()).toList();
    list.add("common");
    return list;
  }
}
