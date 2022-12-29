import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/model/entity/details.dart';
import 'package:playflutter/core/model/entity/parent_tab.dart';
import 'package:playflutter/core/provider/dark_mode_provider.dart';
import 'package:playflutter/core/route/route_animation.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/account/login.dart';
import 'package:playflutter/module/account/register.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/details/details.dart';
import 'package:playflutter/module/main/main.dart';
import 'package:playflutter/module/me/coin.dart';
import 'package:playflutter/module/me/coin_rank.dart';
import 'package:playflutter/module/me/collect.dart';
import 'package:playflutter/module/me/settings.dart';
import 'package:playflutter/module/official/official.dart';
import 'package:playflutter/module/project/project.dart';
import 'package:playflutter/module/search/search.dart';
import 'package:playflutter/module/search/search_result.dart';
import 'package:playflutter/module/splash/splash.dart';
import 'package:playflutter/module/square/create_share.dart';
import 'package:playflutter/module/square/my_share.dart';
import 'package:playflutter/module/system/system_content_tab.dart';
import 'package:playflutter/module/todo/create_todo.dart';
import 'package:playflutter/module/todo/todo.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// 全局路由观察者容器
/// [BasePageState] 中订阅路由事件
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

/// 项目全局服务注册监听
List<SingleChildWidget> onGenerateProviders(BuildContext context) => [
      // 深色模式状态监听
      ChangeNotifierProvider.value(value: DarkModeProvider(context: context)),
      // 账户服务
      ChangeNotifierProvider(create: (context) => AccountService(context)),
    ];

/// 项目页面路由注册
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.splash:
      return SplashPageRoute(
          settings: settings, builder: (_) => const SplashPage());
    case RouteNames.main:
      return CupertinoMainPageRoute(
          settings: settings, builder: (_) => const MainPage());
    case RouteNames.search:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const SearchPage());
    case RouteNames.search_result:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const SearchResultPage());
    case RouteNames.official:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const OfficialPage());
    case RouteNames.project:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const ProjectPage());
    case RouteNames.my_share:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const MySharePage());
    case RouteNames.create_share:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const CreateSharePage());
    case RouteNames.system_content_tab:
      final arg = settings.arguments as ParentTab;
      return CupertinoPageRoute(
          settings: settings, builder: (_) => SystemContentTabPage(item: arg));
    case RouteNames.coin:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const CoinPage());
    case RouteNames.coin_rank:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const CoinRankPage());
    case RouteNames.collect:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const CollectPage());
    case RouteNames.settings:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const SettingsPage());
    case RouteNames.todo:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const TodoPage());
    case RouteNames.create_todo:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const CreateTodoPage());
    case RouteNames.details:
      final arg = settings.arguments as DetailsData;
      return CupertinoPageRoute(
          settings: settings, builder: (_) => DetailsPage(detailsData: arg));
    case RouteNames.login:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const LoginPage());
    case RouteNames.register:
      return CupertinoPageRoute(
          settings: settings, builder: (_) => const RegisterPage());

    default:
      return CupertinoMainPageRoute(
          settings: settings, builder: (_) => const MainPage());
  }
}
