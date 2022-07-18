import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';

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
      this.arrowSvgPath = ThemeImages.common_arrow_svg});

  static List<MeItem> getMeItems() {
    var list = <MeItem>[];
    list.add(MeItem(
        route: RouteNames.coin,
        name: ThemeStrings.me_item_coin,
        iconSvgPath: ThemeImages.me_coin_svg));
    list.add(MeItem(
        route: RouteNames.collect,
        name: ThemeStrings.me_item_collect,
        iconSvgPath: ThemeImages.me_collect_svg));
    list.add(MeItem(
        route: RouteNames.my_share,
        name: ThemeStrings.me_item_share,
        iconSvgPath: ThemeImages.me_share_svg));
    list.add(MeItem(
        route: RouteNames.todo,
        name: ThemeStrings.me_item_todo,
        iconSvgPath: ThemeImages.me_todo_svg));
    list.add(MeItem(
        route: RouteNames.settings,
        name: ThemeStrings.me_item_settings,
        iconSvgPath: ThemeImages.me_settings_svg));
    return list;
  }
}
