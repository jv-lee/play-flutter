// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description
class ThemeMe {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Images images = _Images();
}

class _Constants {
  String coinList = "local:coin-list";
  String collectList = "local:collect-list";
}

class _Dimens {
  double headerHeight = 160;
  double headerPictureSize = 56;
  double headerPictureMargin = 36;
  double headerContentMargin = 26;
  double coinHeaderHeight = 180;
  double coinHeaderBgHeight = 120;
}

class _Images {
  String accountSvg = "assets/images/me/ic_me_account.svg";
  String coinSvg = "assets/images/me/ic_me_coin.svg";
  String collectSvg = "assets/images/me/ic_me_collect.svg";
  String logoutSvg = "assets/images/me/ic_me_logout.svg";
  String shareSvg = "assets/images/me/ic_me_share.svg";
  String todoSvg = "assets/images/me/ic_me_todo.svg";
  String userCoinSvg = "assets/images/me/ic_me_user_coin.svg";
  String userLevelSvg = "assets/images/me/ic_me_user_level.svg";
  String rankNo1Svg = "assets/images/me/ic_me_rank_no1.svg";
  String rankNo2Svg = "assets/images/me/ic_me_rank_no2.svg";
  String rankNo3Svg = "assets/images/me/ic_me_rank_no3.svg";
  String settingsSvg = "assets/images/me/ic_me_settings.svg";
}
