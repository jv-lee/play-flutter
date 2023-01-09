import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/me/me_route_names.dart';
import 'package:playflutter/module/me/theme/theme_images_me.dart';
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
        name: "me_item_coin".localized(),
        iconSvgPath: ThemeImagesMe.coinSvg));
    list.add(MeItem(
        route: MeRouteNames.collect,
        name: "me_item_collect".localized(),
        iconSvgPath: ThemeImagesMe.collectSvg));
    list.add(MeItem(
        route: SquareRouteNames.my_share,
        name: "me_item_share".localized(),
        iconSvgPath: ThemeImagesMe.shareSvg));
    list.add(MeItem(
        route: TodoRouteNames.todo,
        name: "me_item_todo".localized(),
        iconSvgPath: ThemeImagesMe.todoSvg));
    list.add(MeItem(
        route: MeRouteNames.settings,
        name: "me_item_settings".localized(),
        iconSvgPath: ThemeImagesMe.settingsSvg));
    return list;
  }
}
