// ignore_for_file: constant_identifier_names
import 'package:playflutter/core/model/entity/todo.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description todo本地实体类
class TodoTypeData {
  late final int type; // TodoTypes
  late final String name;

  TodoTypeData({required this.type, required this.name});

  static List<TodoTypeData> getTodoTypes() {
    var list = <TodoTypeData>[];
    list.add(TodoTypeData(
        type: TodoType.DEFAULT.index, name: ThemeTodo.strings.typeDefault));
    list.add(TodoTypeData(
        type: TodoType.WORK.index, name: ThemeTodo.strings.typeWork));
    list.add(TodoTypeData(
        type: TodoType.LIFE.index, name: ThemeTodo.strings.typeLife));
    list.add(TodoTypeData(
        type: TodoType.PLAY.index, name: ThemeTodo.strings.typePlay));
    return list;
  }
}

class TodoTypeWheelData {
  late final int startIndex;
  late final List<TodoTypeData> todoTypes;

  TodoTypeWheelData({required this.startIndex, required this.todoTypes});
}

enum TodoType { DEFAULT, WORK, LIFE, PLAY }

enum TodoStatus { UPCOMING, COMPLETE }

enum TodoPriority { LOW, HIGH }

class TodoResult {
  var isAdd = true;
  final Todo todo;

  TodoResult(this.isAdd, {required this.todo});
}
