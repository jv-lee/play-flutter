import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/official/official_route_names.dart';
import 'package:playflutter/module/project/project_route_names.dart';

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
        name: "home_official_category_name".localized(),
        iconRes: ThemeImages.homeOfficialSvg,
        link: OfficialRouteNames.official));
    list.add(HomeCategory(
        name: "home_project_category_name".localized(),
        iconRes: ThemeImages.homeProjectSvg,
        link: ProjectRouteNames.project));
    return list;
  }
}
