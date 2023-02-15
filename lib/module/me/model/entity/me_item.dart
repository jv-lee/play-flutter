import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/square/theme/theme_square.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 首页分类本地实体
class MeItem {
  late final String route;
  late final String name;
  late final String iconSvgPath;
  late final String arrowSvgPath = ThemeCommon.images.arrowSvg;

  MeItem({required this.route, required this.name, required this.iconSvgPath});

  static List<MeItem> getMeItems() {
    var list = <MeItem>[];
    list.add(MeItem(
        route: ThemeMe.routes.coin,
        name: ThemeMe.strings.meItemCoin,
        iconSvgPath: ThemeMe.images.coinSvg));
    list.add(MeItem(
        route: ThemeMe.routes.collect,
        name: ThemeMe.strings.meItemCollect,
        iconSvgPath: ThemeMe.images.collectSvg));
    list.add(MeItem(
        route: ThemeSquare.routes.myShare,
        name: ThemeMe.strings.meItemShare,
        iconSvgPath: ThemeMe.images.shareSvg));
    list.add(MeItem(
        route: ThemeTodo.routes.todo,
        name: ThemeMe.strings.meItemTodo,
        iconSvgPath: ThemeMe.images.todoSvg));
    list.add(MeItem(
        route: ThemeMe.routes.settings,
        name: ThemeMe.strings.meItemSettings,
        iconSvgPath: ThemeMe.images.settingsSvg));
    return list;
  }
}
