import 'package:flutter/material.dart';
import 'package:playflutter/manifest.dart';
import 'package:playflutter/model/db/database_manager.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/tools/cache/cache_manager.dart';
import 'package:playflutter/view/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() {
  runApp(const PlayFlutterApp());
}

class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    databaseManager.init();
    cacheManager.init();
    final providers = <SingleChildWidget>[];
    // 深色模式状态监听
    providers.add(ChangeNotifierProvider.value(
        value: DarkModeProvider(context: context)));
    // 全局服务依赖
    providers.addAll(onGenerateService(context));
    return MultiProvider(
        providers: providers,
        // 监听深色模式主题变换 更改主题配置
        child: Consumer<DarkModeProvider>(builder: (context, provider, widget) {
          return MaterialApp(
              theme: provider.lightThemeData,
              darkTheme: provider.darkThemeData,
              navigatorObservers: [routeObserver],
              onGenerateRoute: onGenerateRoute,
              home: const SplashPage());
        }));
  }
}
