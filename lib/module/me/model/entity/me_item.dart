import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/me/me_route_names.dart';
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
      this.arrowSvgPath = ThemeImages.commonArrowSvg});

  static List<MeItem> getMeItems() {
    var list = <MeItem>[];
    list.add(MeItem(
        route: MeRouteNames.coin,
        name: "me_item_coin".localized(),
        iconSvgPath: ThemeImages.meCoinSvg));
    list.add(MeItem(
        route: MeRouteNames.collect,
        name: "me_item_collect".localized(),
        iconSvgPath: ThemeImages.meCollectSvg));
    list.add(MeItem(
        route: SquareRouteNames.my_share,
        name: "me_item_share".localized(),
        iconSvgPath: ThemeImages.meShareSvg));
    list.add(MeItem(
        route: TodoRouteNames.todo,
        name: "me_item_todo".localized(),
        iconSvgPath: ThemeImages.meTodoSvg));
    list.add(MeItem(
        route: MeRouteNames.settings,
        name: "me_item_settings".localized(),
        iconSvgPath: ThemeImages.meSettingsSvg));
    return list;
  }
}
