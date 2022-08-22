import 'package:playflutter/model/entity/todo.dart';
import 'package:playflutter/view/todo/model/entity/todo_type.dart';

/// @author jv.lee
/// @date 2022/8/19
/// @description
abstract class TodoActionCallback {
  void onTypeChange(TodoType type);

  void onAdd(Todo todo);

  void onUpdate(Todo todo);
}
