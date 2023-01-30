import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/me/me_route_names.dart';
import 'package:playflutter/module/me/page/coin.dart';
import 'package:playflutter/module/me/page/coin_rank.dart';
import 'package:playflutter/module/me/page/collect.dart';
import 'package:playflutter/module/me/page/settings.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class MeModule extends BaseModule {
  @override
  String localizationFileName() => "me";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        MeRouteNames.coin: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CoinPage()),
        MeRouteNames.coin_rank: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CoinRankPage()),
        MeRouteNames.collect: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CollectPage()),
        MeRouteNames.settings: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SettingsPage()),
      };
}