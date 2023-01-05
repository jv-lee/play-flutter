import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/todo/page/create_todo.dart';
import 'package:playflutter/module/todo/page/todo.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class TodoModule extends BaseModule {
  @override
  String localizationFileName() => "todo";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        RouteNames.todo: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const TodoPage()),
        RouteNames.create_todo: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CreateTodoPage())
      };
}
