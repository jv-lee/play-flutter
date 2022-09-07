import 'package:playflutter/core/theme/theme_images.dart';

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
        normalIcon: ThemeImages.todoUpcomingSvg,
        pressIcon: ThemeImages.todoUpcomingFillSvg,
        label: "upcoming"));

    list.add(TodoTab(
        normalIcon: ThemeImages.todoCompleteSvg,
        pressIcon: ThemeImages.todoCompleteFillSvg,
        label: "complete"));
    return list;
  }
}
