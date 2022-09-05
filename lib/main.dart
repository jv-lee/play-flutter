import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/extensions/function_extensions.dart';
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

class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final providers = <SingleChildWidget>[].also((self) {
      // 深色模式状态监听
      self.add(ChangeNotifierProvider.value(
          value: DarkModeProvider(context: context)));
      // 全局服务依赖
      self.addAll(onGenerateService(context));
    });
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
