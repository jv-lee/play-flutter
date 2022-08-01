import 'package:flutter/material.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/route/route_animator.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/account/login.dart';
import 'package:playflutter/view/account/register.dart';
import 'package:playflutter/view/details/details.dart';
import 'package:playflutter/view/main/main.dart';
import 'package:playflutter/view/me/coin.dart';
import 'package:playflutter/view/me/coin_rank.dart';
import 'package:playflutter/view/me/collect.dart';
import 'package:playflutter/view/me/settings.dart';
import 'package:playflutter/view/official/official.dart';
import 'package:playflutter/view/project/project.dart';
import 'package:playflutter/view/search/search.dart';
import 'package:playflutter/view/search/search_result.dart';
import 'package:playflutter/view/splash/splash.dart';
import 'package:playflutter/view/square/create_share.dart';
import 'package:playflutter/view/square/my_share.dart';
import 'package:playflutter/view/system/system_content_tab.dart';
import 'package:playflutter/view/todo/todo.dart';

// 项目页面路由注册
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.splash:
      return SplashPageRoute(
        settings: settings,
        widget: const SplashPage(),
      );
    case RouteNames.main:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const MainPage());
    case RouteNames.search:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const SearchPage());
    case RouteNames.search_result:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const SearchResultPage());
    case RouteNames.official:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const OfficialPage());
    case RouteNames.project:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ProjectPage());
    case RouteNames.my_share:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const MySharePage());
    case RouteNames.create_share:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const CreateSharePage());
    case RouteNames.system_content_tab:
      final arg = settings.arguments as ParentTab;
      return MaterialPageRoute(
          settings: settings, builder: (_) => SystemContentTabPage(item: arg));
    case RouteNames.coin:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const CoinPage());
    case RouteNames.coin_rank:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const CoinRankPage());
    case RouteNames.collect:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const CollectPage());
    case RouteNames.settings:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const SettingsPage());
    case RouteNames.todo:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const TodoPage());
    case RouteNames.details:
      final arg = settings.arguments as DetailsData;
      return MaterialPageRoute(
          settings: settings, builder: (_) => DetailsPage(detailsData: arg));
    case RouteNames.login:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const LoginPage());
    case RouteNames.register:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const RegisterPage());

    default:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const MainPage());
  }
}
