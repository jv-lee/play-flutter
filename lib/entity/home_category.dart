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
        name: "公众号", iconRes: ThemeSvgPaths.svg_official, link: ""));
    list.add(HomeCategory(
        name: "项目", iconRes: ThemeSvgPaths.svg_project, link: ""));
    return list;
  }
}
