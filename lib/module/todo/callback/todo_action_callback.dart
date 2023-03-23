import 'package:playflutter/core/model/entity/todo.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';

/// @author jv.lee
/// @date 2022/8/19
/// @description 笔记模块页面动作回调接口
abstract class TodoActionCallback {
  void onTypeChange(TodoType type);

  void onAdd(Todo todo);

  void onUpdate(Todo todo);
}
