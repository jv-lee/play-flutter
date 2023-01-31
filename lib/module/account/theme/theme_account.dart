// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description
class ThemeAccount {
  static _Constants constants = _Constants();
  static _Strings strings = _Strings();
  static _Images images = _Images();
}

class _Constants {
   String accountData = "local:account-data";
}

class _Strings {
  String loginTile = "account_login_title".localized();
  String registerTitle = "account_register_title".localized();
  String loginButton = "account_login_button".localized();
  String registerButton = "account_register_button".localized();
  String usernameText = "account_username_text".localized();
  String passwordText = "account_password_text".localized();
  String rePasswordText = "account_repassword_text".localized();
  String gotoRegisterText = "account_goto_register_text".localized();
  String gotoLoginText = "account_goto_login_text".localized();
  String logoutSuccess = "account_logout_success".localized();
}

class _Images {
  String usernameSvg = "assets/images/account/ic_account_username.svg";
  String passwordSvg = "assets/images/account/ic_account_password.svg";
}
