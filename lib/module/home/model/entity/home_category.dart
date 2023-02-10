import 'package:playflutter/module/home/theme/theme_home.dart';
import 'package:playflutter/module/official/theme/theme_official.dart';
import 'package:playflutter/module/project/theme/theme_project.dart';

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
        name: ThemeHome.strings.officialCategoryName,
        iconRes: ThemeHome.images.officialSvg,
        link: ThemeOfficial.routes.official));
    list.add(HomeCategory(
        name: ThemeHome.strings.projectCategoryName,
        iconRes: ThemeHome.images.projectSvg,
        link: ThemeProject.routes.project));
    return list;
  }
}
