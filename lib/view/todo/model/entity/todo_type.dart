// ignore_for_file: constant_identifier_names
/// @author jv.lee
/// @date 2022/8/15
/// @description todo本地实体类
class TodoType {
  late final int type; // TodoTypes
  late final String name;

  TodoType({required this.type, required this.name});

  static List<TodoType> getTodoTypes() {
    var list = <TodoType>[];
    list.add(TodoType(type: 1, name: ""));
    list.add(TodoType(type: 1, name: ""));
    list.add(TodoType(type: 1, name: ""));
    list.add(TodoType(type: 1, name: ""));
    return list;
  }
}

class TodoTypeWheelData {
  late final int startIndex;
  late final List<TodoType> todoTypes;

  TodoTypeWheelData({required this.startIndex, required this.todoTypes});
}

enum TodoTypes { DEFAULT, WORK, LIFE, PLAY }

extension TodoTypesExtension on TodoTypes {
  getTypeValue() {
    switch (this) {
      case TodoTypes.WORK:
        return 1;
      case TodoTypes.LIFE:
        return 2;
      case TodoTypes.PLAY:
        return 3;
      default:
        return 0;
    }
  }
}
