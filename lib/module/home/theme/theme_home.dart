// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 首页模块 资源引用类
class ThemeHome {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Images images = _Images();
  static _Strings strings = _Strings();
}

class _Constants {
  String homeList = "local:home-list"; // 首页列表缓存key
  String homeBanner = "local:home-banner"; // 首页banner 缓存key
}

class _Dimens {
  double categoryLayoutHeight = 130;
  double categoryItemSize = 50;
}

class _Images {
  String officialSvg = "assets/images/home/ic_home_official.svg";
  String projectSvg = "assets/images/home/ic_home_project.svg";
}

class _Strings {
  String headerText = "home_header_text".localized();
  String officialCategoryName = "home_official_category_name".localized();
  String projectCategoryName = "home_project_category_name".localized();
}
