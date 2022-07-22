import 'package:flutter/material.dart';
import 'package:playflutter/db/database_manager.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/manifest.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/account/login.dart';
import 'package:playflutter/view/account/register.dart';
import 'package:playflutter/view/details/details.dart';
import 'package:playflutter/view/main.dart';
import 'package:playflutter/view/me/coin.dart';
import 'package:playflutter/view/me/coin_rank.dart';
import 'package:playflutter/view/me/collect.dart';
import 'package:playflutter/view/me/settings.dart';
import 'package:playflutter/view/official/project.dart';
import 'package:playflutter/view/project/project.dart';
import 'package:playflutter/view/search/search.dart';
import 'package:playflutter/view/search/search_result.dart';
import 'package:playflutter/view/square/create_share.dart';
import 'package:playflutter/view/square/my_share.dart';
import 'package:playflutter/view/todo/todo.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const PlayFlutterApp());
}

class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DatabaseManager.getInstance().init();
    final providers = <SingleChildWidget>[];
    // 深色模式状态监听
    providers.add(ChangeNotifierProvider.value(
        value: DarkModeProvider(context: context)));
    // 项目页面viewModel注册监听
    providers.addAll(viewModelProviders);
    return MultiProvider(
        providers: providers,
        // 监听深色模式主题变换 更改主题配置
        child: Consumer<DarkModeProvider>(builder: (context, provider, widget) {
          return MaterialApp(
            theme: provider.lightThemeData,
            darkTheme: provider.darkThemeData,
            onGenerateRoute: onGenerateRoute,
            initialRoute: '/',
            home: const MainPage(),
          );
        }));
  }
}
