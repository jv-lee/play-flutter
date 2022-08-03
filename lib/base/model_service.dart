import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description
abstract class ModuleService with ChangeNotifier {
  final BuildContext context;

  ModuleService(this.context) {
    init();
  }

  /// service初始化
  void init();
}
