import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/core/theme/theme_strings.dart';
import 'package:playflutter/core/theme/theme_images.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 首页分类本地实体
class HomeCategory {
  late final String name;
  late final String iconRes;
  late final String link;

  HomeCategory({required this.name, required this.iconRes, required this.link});

  static List<HomeCategory> getHomeCategory() {
    var list = <HomeCategory>[];
    list.add(HomeCategory(
        name: ThemeStrings.homeOfficialCategoryName,
        iconRes: ThemeImages.homeOfficialSvg,
        link: RouteNames.official));
    list.add(HomeCategory(
        name: ThemeStrings.homeProjectCategoryName,
        iconRes: ThemeImages.homeProjectSvg,
        link: RouteNames.project));
    return list;
  }
}
