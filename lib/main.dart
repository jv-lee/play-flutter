import 'package:flutter/material.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/details/details.dart';
import 'package:playflutter/view/home/viewmodel/home_viewmodel.dart';
import 'package:playflutter/view/main.dart';
import 'package:playflutter/view/me/settings.dart';
import 'package:playflutter/view/me/viewmodel/me_viewmodel.dart';
import 'package:playflutter/view/official/project.dart';
import 'package:playflutter/view/project/project.dart';
import 'package:playflutter/view/search/search.dart';
import 'package:playflutter/view/square/create_share.dart';
import 'package:playflutter/view/square/viewmodel/square_viewmodel.dart';
import 'package:playflutter/view/system/viewmodel/navigation_content_viewmodel.dart';
import 'package:playflutter/view/system/viewmodel/system_content_viewmodel.dart';
import 'package:playflutter/view/system/viewmodel/system_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PlayFlutterApp());
}

class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 监听深色模式主题变换 更改主题配置
    return MultiProvider(
        providers: [
          // 深色模式状态监听
          ChangeNotifierProvider.value(value: DarkModeProvider(context: context)),

          // 项目页面viewModel注册监听
          ChangeNotifierProvider(create: (context) => HomeViewModel()),
          ChangeNotifierProvider(create: (context) => SquareViewModel()),
          ChangeNotifierProvider(create: (context) => SystemViewModel()),
          ChangeNotifierProvider(create: (context) => SystemContentViewModel()),
          ChangeNotifierProvider(create: (context) => NavigationContentViewModel()),
          ChangeNotifierProvider(create: (context) => MeViewModel()),
        ],
        child: Consumer<DarkModeProvider>(builder: (context, provider, widget) {
          return MaterialApp(
            theme: provider.lightThemeData,
            darkTheme: provider.darkThemeData,
            onGenerateRoute: _onGenerateRoute,
            initialRoute: '/',
            home: const MainPage(),
          );
        }));
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.main:
      return MaterialPageRoute(builder: (_) => const MainPage());
    case RouteNames.search:
      return MaterialPageRoute(builder: (_) => const SearchPage());
    case RouteNames.official:
      return MaterialPageRoute(builder: (_) => const OfficialPage());
    case RouteNames.project:
      return MaterialPageRoute(builder: (_) => const ProjectPage());
    case RouteNames.create_share:
      return MaterialPageRoute(builder: (_) => const CreateSharePage());
    case RouteNames.settings:
      return MaterialPageRoute(builder: (_) => const SettingsPage());
    case RouteNames.details:
      return MaterialPageRoute(builder: (_) => DetailsPage(
        detailsData: settings.arguments as DetailsData,));

    default:
      return MaterialPageRoute(builder: (_) => const MainPage());
  }
}
