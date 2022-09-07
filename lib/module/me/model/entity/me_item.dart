import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/theme/theme_strings.dart';

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
        route: RouteNames.coin,
        name: ThemeStrings.meItemCoin,
        iconSvgPath: ThemeImages.meCoinSvg));
    list.add(MeItem(
        route: RouteNames.collect,
        name: ThemeStrings.meItemCollect,
        iconSvgPath: ThemeImages.meCollectSvg));
    list.add(MeItem(
        route: RouteNames.my_share,
        name: ThemeStrings.meItemShare,
        iconSvgPath: ThemeImages.meShareSvg));
    list.add(MeItem(
        route: RouteNames.todo,
        name: ThemeStrings.meItemTodo,
        iconSvgPath: ThemeImages.meTodoSvg));
    list.add(MeItem(
        route: RouteNames.settings,
        name: ThemeStrings.meItemSettings,
        iconSvgPath: ThemeImages.meSettingsSvg));
    return list;
  }
}
