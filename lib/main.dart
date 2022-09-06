import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/manifest.dart';
import 'package:playflutter/model/db/database_manager.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/tools/cache/cache_manager.dart';
import 'package:playflutter/view/splash/splash.dart';
import 'package:provider/provider.dart';

/// PlayFlutter程序主入口
void main() {
  // 在main中初始化处理需先调用binding初始化方法
  WidgetsFlutterBinding.ensureInitialized();
  // init code
  databaseManager.init();
  cacheManager.init();
  // flutter edgeToEdge navigationBar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.top])
      .then((value) => runApp(const PlayFlutterApp()));
}

/// This widget is the root of your application.
class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // 全局服务依赖
        providers: onGenerateProviders(context),
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

/// 全局路由观察者容器
/// [BasePageState] 中订阅路由事件
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
