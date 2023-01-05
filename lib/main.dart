import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/app/app.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/model/db/database_manager.dart';
import 'package:playflutter/core/tools/cache/cache_manager.dart';

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

/// 全局路由观察者容器 [BasePageState] 中订阅路由事件
final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();
