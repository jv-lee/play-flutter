import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/theme/theme_images.dart';

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
        name: ThemeStrings.official_category_name,
        iconRes: ThemeImages.home_official_svg,
        link: RouteNames.official));
    list.add(HomeCategory(
        name: ThemeStrings.project_category_name,
        iconRes: ThemeImages.home_project_svg,
        link: RouteNames.project));
    return list;
  }
}
