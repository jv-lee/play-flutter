import 'package:playflutter/core/base/base_module.dart';
import 'package:playflutter/core/route/route_animation.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/module/main/page/main.dart';

/// @author jv.lee
/// @date 2023/1/5
/// @description
class MainModule extends BaseModule {
  @override
  String localizationFileName() => "";

  @override
  Map<String, PageBuilder> pageBuilders() => {
        RouteNames.main: (settings) => CupertinoMainPageRoute(
            settings: settings, builder: (_) => const MainPage()),
      };
}
