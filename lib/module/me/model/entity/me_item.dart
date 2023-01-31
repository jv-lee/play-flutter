import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/module/me/me_route_names.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/square/square_route_names.dart';
import 'package:playflutter/module/todo/todo_route_names.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 首页分类本地实体
class MeItem {
  late final String route;
  late final String name;
  late final String iconSvgPath;
  late final String arrowSvgPath;

  MeItem(
      {required this.route,
      required this.name,
      required this.iconSvgPath,
      this.arrowSvgPath = ThemeImages.arrowSvg});

  static List<MeItem> getMeItems() {
    var list = <MeItem>[];
    list.add(MeItem(
        route: MeRouteNames.coin,
        name: ThemeMe.strings.meItemCoin,
        iconSvgPath: ThemeMe.images.coinSvg));
    list.add(MeItem(
        route: MeRouteNames.collect,
        name: ThemeMe.strings.meItemCollect,
        iconSvgPath: ThemeMe.images.collectSvg));
    list.add(MeItem(
        route: SquareRouteNames.my_share,
        name: ThemeMe.strings.meItemShare,
        iconSvgPath: ThemeMe.images.shareSvg));
    list.add(MeItem(
        route: TodoRouteNames.todo,
        name: ThemeMe.strings.meItemTodo,
        iconSvgPath: ThemeMe.images.todoSvg));
    list.add(MeItem(
        route: MeRouteNames.settings,
        name: ThemeMe.strings.meItemSettings,
        iconSvgPath: ThemeMe.images.settingsSvg));
    return list;
  }
}
