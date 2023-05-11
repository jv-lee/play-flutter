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

/// 笔记类型滑动选择类型实体
class TodoTypeWheelData {
  late final int startIndex;
  late final List<TodoTypeData> todoTypes;

  TodoTypeWheelData({required this.startIndex, required this.todoTypes});
}

/// 笔记类型
enum TodoType { DEFAULT, WORK, LIFE, PLAY }

/// 笔记状态
enum TodoStatus { UPCOMING, COMPLETE }

/// 笔记优先级
enum TodoPriority { LOW, HIGH }

/// 笔记修改结果实体 - （新增/修改）
class TodoResult {
  var isAdd = true;
  final Todo todo;

  TodoResult(this.isAdd, {required this.todo});
}
