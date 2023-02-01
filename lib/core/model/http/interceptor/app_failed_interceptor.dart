// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:playflutter/core/event/constants/event_constants.dart';
import 'package:playflutter/core/event/entity/navigation_login_event.dart';
import 'package:playflutter/core/event/events_bus.dart';
import 'package:playflutter/core/model/http/constants/api_constants.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';

/// @author jv.lee
/// @date 2022/8/23
/// @description app通用错误处理拦截器
class AppFailedInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final uri = response.realUri.toString();
    // 当前请求为baseUri
    if (uri.contains(ApiConstants.BASE_URI)) {
      try {
        var code = response.data["errorCode"] as int;
        //登陆失效,打开登陆页面
        if (code == ApiConstants.REQUEST_TOKEN_ERROR) {
          bool isLogin = await Preferences.get(ThemeCommon.constants.isLogin);
          //单独处理登陆状态 ， 已登陆状态发起重新登陆事件
          if (isLogin) {
            eventBus.send(
                EventConstants.EVENT_NAVIGATION_LOGIN, NavigationLoginEvent());
          }
        }
      } catch (e) {}
    }
    handler.next(response);
  }
}
