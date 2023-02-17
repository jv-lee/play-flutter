import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/module/me/page/coin.dart';
import 'package:playflutter/module/me/page/coin_rank.dart';
import 'package:playflutter/module/me/page/collect.dart';
import 'package:playflutter/module/me/page/settings.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description 我的 模块类
class MeModule extends BaseModule {
  @override
  String localizationFileName() => "me";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        ThemeMe.routes.coin: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CoinPage()),
        ThemeMe.routes.coinRank: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CoinRankPage()),
        ThemeMe.routes.collect: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const CollectPage()),
        ThemeMe.routes.settings: (settings) => CupertinoPageRoute(
            settings: settings, builder: (_) => const SettingsPage()),
      };
}
