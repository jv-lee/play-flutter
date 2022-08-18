// ignore_for_file: constant_identifier_names
import 'package:playflutter/theme/theme_strings.dart';

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
        type: TodoType.DEFAULT.index, name: ThemeStrings.todoTypeDefault));
    list.add(TodoTypeData(
        type: TodoType.WORK.index, name: ThemeStrings.todoTypeWork));
    list.add(TodoTypeData(
        type: TodoType.LIFE.index, name: ThemeStrings.todoTypeLife));
    list.add(TodoTypeData(
        type: TodoType.PLAY.index, name: ThemeStrings.todoTypePlay));
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
