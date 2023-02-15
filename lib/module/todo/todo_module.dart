import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/todo/page/create_todo.dart';
import 'package:playflutter/module/todo/page/todo.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class TodoModule extends BaseModule {
  @override
  String localizationFileName() => "todo";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeTodo.routes.todo: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const TodoPage()),
        ThemeTodo.routes.createTodo: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CreateTodoPage())
      };
}
