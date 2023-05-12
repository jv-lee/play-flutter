import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2023/1/4
/// @description 业务 Module
abstract class BaseModule {
  BaseModule();

  /// 模块初始化方法
  @mustCallSuper
  void onInit() {}

  /// 模块销毁方法
  @mustCallSuper
  void dispose() {}

  /// 模块页面注册方法
  Map<String, PageBuilder> pageBuilders();

  /// 返回当前模块本地字符文件名
  String localizationFileName();
}

typedef PageBuilder = Route<dynamic> Function(RouteSettings settings);