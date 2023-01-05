import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/account/page/login.dart';
import 'package:playflutter/module/account/page/register.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class AccountModule extends BaseModule {
  @override
  String localizationFileName() => "account";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        RouteNames.login: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const LoginPage()),
        RouteNames.register: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const RegisterPage())
      };
}
