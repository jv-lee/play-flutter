import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description 模块间全局使用服务基类 （应用存活全局常驻服务，全局通用模块数据及方法）
abstract class BaseModuleService with ChangeNotifier {
  final BuildContext context;

  BaseModuleService(this.context) {
    init();
  }

  /// service初始化
  void init();
}
