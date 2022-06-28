import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/theme/theme_svg_paths.dart';

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
        iconRes: ThemeSvgPaths.svg_official,
        link: RouteNames.official));
    list.add(HomeCategory(
        name: ThemeStrings.project_category_name,
        iconRes: ThemeSvgPaths.svg_project,
        link: RouteNames.project));
    return list;
  }
}
