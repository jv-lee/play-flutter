import 'package:flutter/material.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/account/login.dart';
import 'package:playflutter/view/account/register.dart';
import 'package:playflutter/view/account/viewmodel/login_viewmodel.dart';
import 'package:playflutter/view/account/viewmodel/register_viewmodel.dart';
import 'package:playflutter/view/details/details.dart';
import 'package:playflutter/view/home/viewmodel/home_viewmodel.dart';
import 'package:playflutter/view/main.dart';
import 'package:playflutter/view/me/coin.dart';
import 'package:playflutter/view/me/coin_rank.dart';
import 'package:playflutter/view/me/collect.dart';
import 'package:playflutter/view/me/settings.dart';
import 'package:playflutter/view/me/viewmodel/coin_rank_viewmodel.dart';
import 'package:playflutter/view/me/viewmodel/coin_viewmodel.dart';
import 'package:playflutter/view/me/viewmodel/collect_viewmodel.dart';
import 'package:playflutter/view/me/viewmodel/me_viewmodel.dart';
import 'package:playflutter/view/official/project.dart';
import 'package:playflutter/view/project/project.dart';
import 'package:playflutter/view/search/search.dart';
import 'package:playflutter/view/search/search_result.dart';
import 'package:playflutter/view/search/viewmodel/search_result_viewmodel.dart';
import 'package:playflutter/view/search/viewmodel/search_viewmodel.dart';
import 'package:playflutter/view/square/create_share.dart';
import 'package:playflutter/view/square/my_share.dart';
import 'package:playflutter/view/square/viewmodel/create_share_viewmodel.dart';
import 'package:playflutter/view/square/viewmodel/my_share_viewmodel.dart';
import 'package:playflutter/view/square/viewmodel/square_viewmodel.dart';
import 'package:playflutter/view/system/system_content_tab.dart';
import 'package:playflutter/view/system/viewmodel/navigation_content_viewmodel.dart';
import 'package:playflutter/view/system/viewmodel/system_content_tab_viewmodel.dart';
import 'package:playflutter/view/system/viewmodel/system_content_viewmodel.dart';
import 'package:playflutter/view/system/viewmodel/system_viewmodel.dart';
import 'package:playflutter/view/todo/todo.dart';
import 'package:playflutter/view/todo/viewmodel/todo_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 项目页面viewModel注册监听
List<SingleChildWidget> onGenerateViewModel(BuildContext context) => [
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => SquareViewModel()),
      ChangeNotifierProvider(create: (context) => SystemViewModel()),
      ChangeNotifierProvider(create: (context) => SystemContentViewModel()),
      ChangeNotifierProvider(create: (context) => SystemContentTabViewModel()),
      ChangeNotifierProvider(create: (context) => NavigationContentViewModel()),
      ChangeNotifierProvider(create: (context) => MeViewModel()),
      ChangeNotifierProvider(create: (context) => CoinViewModel()),
      ChangeNotifierProvider(create: (context) => CoinRankViewModel()),
      ChangeNotifierProvider(create: (context) => CollectViewModel()),
      ChangeNotifierProvider(create: (context) => CreateShareViewModel()),
      ChangeNotifierProvider(create: (context) => MyShareViewModel()),
      ChangeNotifierProvider(create: (context) => TodoViewModel()),
      ChangeNotifierProvider(create: (context) => SearchViewModel()),
      ChangeNotifierProvider(create: (context) => SearchResultViewModel()),
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ChangeNotifierProvider(create: (context) => RegisterViewModel())
    ];

// 项目页面路由注册
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.main:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const MainPage());
    case RouteNames.search:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const SearchPage());
    case RouteNames.search_result:
      final arguments = (settings.arguments as Map<String, dynamic>);
      final key = arguments[SearchPage.ARG_SEARCH_KEY];
      return MaterialPageRoute(
          settings: settings, builder: (_) => SearchResultPage(title: key));
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
      final arg = settings.arguments as List<Children>;
      return MaterialPageRoute(
          settings: settings, builder: (_) => SystemContentTabPage(tabs: arg));
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
