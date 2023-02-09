import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/account/page/login.dart';
import 'package:playflutter/module/account/page/register.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class AccountModule extends BaseModule {
  @override
  String localizationFileName() => "account";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeAccount.routes.login: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const LoginPage()),
        ThemeAccount.routes.register: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const RegisterPage())
      };
}
