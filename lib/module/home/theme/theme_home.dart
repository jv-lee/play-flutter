// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description
class ThemeHome {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Images images = _Images();
}

class _Constants {
  String homeList = "local:home-list";
  String homeBanner = "local:home-banner";
}

class _Dimens {
  double categoryLayoutHeight = 130;
  double categoryItemSize = 50;
}

class _Images {
  String officialSvg = "assets/images/home/ic_home_official.svg";
  String projectSvg = "assets/images/home/ic_home_project.svg";
}
