import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/model/db/database_manager.dart';
import 'package:playflutter/core/provider/dark_mode_provider.dart';
import 'package:playflutter/core/tools/cache/cache_manager.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/manifest.dart';
import 'package:playflutter/module/splash/splash.dart';
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
              // 设置主题颜色
              theme: provider.lightThemeData,
              darkTheme: provider.darkThemeData,
              // 全局路由监听
              navigatorObservers: [routeObserver],
              // 本地化字符串
              localizationsDelegates: [
                CommonLocalizationsDelegate.getInstance(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              // 本地化字符串根据当前语言类型设置初始化
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                return CommonLocalizationsDelegate.getInstance()
                    .initLocalizations(locale: deviceLocale);
              },
              // 设置路由
              onGenerateRoute: onGenerateRoute,
              // 闪屏页面
              home: const SplashPage());
        }));
  }
}
