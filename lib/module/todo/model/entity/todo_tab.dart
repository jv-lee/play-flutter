import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/module/todo/theme/theme_images_todo.dart';

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
        normalIcon: ThemeImagesTodo.upcomingSvg,
        pressIcon: ThemeImagesTodo.upcomingFillSvg,
        label: "upcoming"));

    list.add(TodoTab(
        normalIcon: ThemeImagesTodo.completeSvg,
        pressIcon: ThemeImagesTodo.completeFillSvg,
        label: "complete"));
    return list;
  }
}
