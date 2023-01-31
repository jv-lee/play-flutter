import 'package:playflutter/module/todo/theme/theme_todo.dart';

/// @author jv.lee
/// @date 2022/8/18
/// @description
class TodoTab {
  late final String normalIcon;
  late final String pressIcon;
  late final String label;

  TodoTab(
      {required this.normalIcon, required this.pressIcon, required this.label});

  static List<TodoTab> getTodoTabs() {
    var list = <TodoTab>[];
    list.add(TodoTab(
        normalIcon: ThemeTodo.images.upcomingSvg,
        pressIcon: ThemeTodo.images.upcomingFillSvg,
        label: "upcoming"));

    list.add(TodoTab(
        normalIcon: ThemeTodo.images.completeSvg,
        pressIcon: ThemeTodo.images.completeFillSvg,
        label: "complete"));
    return list;
  }
}
