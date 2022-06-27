/// @author jv.lee
/// @date 2022/6/27
/// @description
class HomeCategory {
  late final String name;
  late final String iconRes;
  late final String link;

  HomeCategory({required this.name, required this.iconRes, required this.link});

  static List<HomeCategory> getHomeCategory() {
    var list = <HomeCategory>[];
    list.add(HomeCategory(
        name: "公众号", iconRes: "assets/svg/ic_official.svg", link: ""));
    list.add(HomeCategory(
        name: "项目", iconRes: "assets/svg/ic_project.svg", link: ""));
    return list;
  }
}
