import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2023/1/4
/// @description 业务 Module
abstract class BaseModule {
  BaseModule();

  @mustCallSuper
  void onInit() {}

  @mustCallSuper
  void dispose() {}

  Map<String, PageBuilder> pageBuilders();

  String localizationFileName();
}

typedef PageBuilder = Route<dynamic> Function(RouteSettings settings);