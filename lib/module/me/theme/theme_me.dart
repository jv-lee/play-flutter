// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 我的模块 资源引用类
class ThemeMe {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Images images = _Images();
  static _Strings strings = _Strings();
  static _Routes routes = _Routes();
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

class _Strings {
  String meAccountDefaultText = "me_account_default_text".localized();
  String meAccountInfoText = "me_account_info_text".localized();
  String meItemCoin = "me_item_coin".localized();
  String meItemCollect = "me_item_collect".localized();
  String meItemShare = "me_item_share".localized();
  String meItemTodo = "me_item_todo".localized();
  String meItemSettings = "me_item_settings".localized();

  String settingsDarkModeSystem = "settings_dark_mode_system".localized();
  String settingsDarkModeNight = "settings_dark_mode_night".localized();
  String settingsClearText = "settings_clear_text".localized();
  String settingsLogout = "settings_logout".localized();
  String settingsClearTitle = "settings_clear_title".localized();
  String settingsLogoutTitle = "settings_logout_title".localized();

  String coinTitleLabelText = "coin_title_label_text".localized();
  String coinTotalDescription = "coin_total_description".localized();
  String coinDefaultValue = "coin_default_value".localized();
  String coinToRankText = "coin_to_rank_text".localized();
  String coinRankTitle = "coin_rank_title".localized();
  String coinHelpTitle = "coin_help_title".localized();
}

class _Routes {
  String coin = "/coin";
  String coinRank = "/coinRank";
  String collect = "/collect";
  String settings = "/settings";
}
