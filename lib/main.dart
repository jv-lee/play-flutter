import 'package:flutter/material.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_colors.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/view/page/main/main.dart';
import 'package:playflutter/view/page/me/settings.dart';
import 'package:provider/provider.dart';
import 'package:night/night.dart';

void main() {
  runApp(const PlayFlutterApp());
}

class PlayFlutterApp extends StatelessWidget {
  const PlayFlutterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: DarkModeProvider())],
        child:
            Consumer<DarkModeProvider>(builder: (context, darkModeProvider, _) {
          ThemeData lightThemeData;
          ThemeData darkThemeData;
          switch (darkModeProvider.darkMode) {
            case DarkModeProvider.MODE_DARK:
              {
                lightThemeData = ThemeColors.darkThemeData;
                darkThemeData = ThemeColors.darkThemeData;
              }
              break;
            case DarkModeProvider.MODE_LIGHT:
              {
                lightThemeData = ThemeColors.lightThemeData;
                darkThemeData = ThemeColors.lightThemeData;
              }
              break;
            default:
              {
                lightThemeData = ThemeColors.lightThemeData;
                darkThemeData = ThemeColors.darkThemeData;
              }
          }

          return MaterialApp(
            theme: lightThemeData,
            darkTheme: darkThemeData,
            onGenerateRoute: _onGenerateRoute,
            initialRoute: '/',
            home: const MainPage(),
          );
        }));
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.SETTINGS:
      return MaterialPageRoute(builder: (_) => const SettingsPage());

    default:
      return MaterialPageRoute(builder: (_) => const MainPage());
  }
}