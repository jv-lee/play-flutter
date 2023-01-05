import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:playflutter/app/app_viewmodel.dart';
import 'package:playflutter/core/provider/dark_mode_provider.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/main.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description This widget is the root of your application.
class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appViewModel = AppViewModel();
    return Provider<AppViewModel>(
        create: (context) => appViewModel,
        builder: (context, child) {
          return MultiProvider(
              // 全局服务依赖
              providers: appViewModel.onGenerateProviders(context),
              // 监听深色模式主题变换 更改主题配置
              child: Consumer<DarkModeProvider>(
                  builder: (context, provider, widget) {
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
                          .initLocalizations(
                              appViewModel.moduleManager
                                  .getLocalizationFileNames(),
                              locale: deviceLocale);
                    },
                    // 设置路由
                    onGenerateRoute: (settings) =>
                        appViewModel.onGenerateRoute(settings),
                    // 闪屏页面
                    home: appViewModel.onHome());
              }));
        });
  }
}
