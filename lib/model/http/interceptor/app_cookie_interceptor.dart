// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/tools/local_tools.dart';

/// @author jv.lee
/// @date 2022/8/4
/// @description app登陆cookie设置拦截器
class AppCookieInterceptor extends Interceptor {
  static final _HEADER_COOKIE_KEY = "Cookie"; // 请求头设置cookie键名
  static final _SET_COOKIE_KEY = "set-cookie"; // 包含cookie的response取值键名
  static final _CONTAINER_COOKIE_URI = "/lg/"; // 链接中包含lg则需要设置cookie
  static final _SAVE_TOKEN_KEY = "save-token"; // 保存cookie 键名

  static final _CONTAINER_LOGIN_URI = "user/login";
  static final _CONTAINER_REGISTER_URI = "user/register";
  static final _CONTAINER_LOGOUT_URI = "user/logout";

  String cookie = "";

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final uri = options.uri.toString();
    // 当前请求为baseUri
    if (uri.contains(ApiConstants.BASE_URI)) {
      // 包含校验cookie的链接时获取缓存cookie设置header
      if (uri.contains(_CONTAINER_COOKIE_URI)) {
        if (cookie.isEmpty) {
          cookie = await LocalTools.get<String>(_SAVE_TOKEN_KEY) ?? "";
        }
        options.headers[_HEADER_COOKIE_KEY] = cookie;
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final uri = response.realUri.toString();
    // 当前请求为baseUri
    if (uri.contains(ApiConstants.BASE_URI)) {
      // 登陆注册时保存登陆 cookie作为token校验接口header参数
      if (uri.contains(RegExp(_CONTAINER_LOGIN_URI)) ||
          uri.contains(RegExp(_CONTAINER_REGISTER_URI))) {
        final setCookie = response.headers.map[_SET_COOKIE_KEY].toString();
        saveCookie(setCookie);
        // 登出时清除登陆cookie等信息
      } else if (uri.contains(RegExp(_CONTAINER_LOGOUT_URI))) {
        clearCookie();
      }
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
