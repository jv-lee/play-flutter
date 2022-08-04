// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/8/4
/// @description app登陆cookie设置拦截器
class AppCookieInterceptor extends Interceptor {
  static final _SAVE_USER_LOGIN_KEY = "user/login";
  static final _SAVE_USER_REGISTER_KEY = "user/register";
  static final _REMOVE_USER_LOGOUT_KEY = "user/logout";
  static final _SAVE_TOKEN_KEY = "save_token_key";
  String cookie = "";

  AppCookieInterceptor() {
    LocalTools.get<String>(_SAVE_TOKEN_KEY)
        .then((value) => cookie = value ?? "");
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (cookie.isNotEmpty) {
      options.headers["Cookie"] = cookie;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final uri = response.realUri.toString();
    if (uri.contains(RegExp(_SAVE_USER_LOGIN_KEY)) ||
        uri.contains(RegExp(_SAVE_USER_REGISTER_KEY))) {
      final setCookie = response.headers.map["set-cookie"].toString();
      saveCookie(setCookie);
    } else if (uri.contains(RegExp(_REMOVE_USER_LOGOUT_KEY))) {
      clearCookie();
    }
    handler.next(response);
  }

  void saveCookie(cookie) {
    this.cookie = cookie;
    LocalTools.save<String>(_SAVE_TOKEN_KEY, cookie);
  }

  void clearCookie() {
    cookie = "";
    LocalTools.remove(_SAVE_TOKEN_KEY);
  }
}
