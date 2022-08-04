// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:playflutter/tools/local_tools.dart';

/// @author jv.lee
/// @date 2022/8/4
/// @description
class AppInterceptor extends Interceptor {
  static final _SAVE_USER_LOGIN_KEY = "user/login";
  static final _SAVE_USER_REGISTER_KEY = "user/register";
  static final _REMOVE_USER_LOGOUT_KEY = "user/logout";
  static final _SAVE_TOKEN_KEY = "save_token_key";
  String? cookie;

  AppInterceptor() {
    LocalTools.get<String>(_SAVE_TOKEN_KEY).then((value) => cookie = value);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["Cookie"] = cookie;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final uri = response.realUri.toString();
    if (uri.contains(RegExp(_SAVE_USER_LOGIN_KEY)) ||
        uri.contains(RegExp(_SAVE_USER_REGISTER_KEY))) {
      final setCookie = response.headers.map["set-cookie"].toString();
      LocalTools.save<String>(_SAVE_TOKEN_KEY, setCookie);
      cookie = setCookie;
    } else if (uri.contains(RegExp(_REMOVE_USER_LOGOUT_KEY))) {
      LocalTools.remove(_SAVE_TOKEN_KEY);
      cookie = null;
    }
    handler.next(response);
  }
}
