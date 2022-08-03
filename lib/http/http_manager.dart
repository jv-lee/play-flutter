// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:playflutter/tools/local_tools.dart';

/// @author jv.lee
/// @date 2020/5/8
/// @description 网络请求封装工具类
class HttpManager {
  static final HttpManager _instance = HttpManager._internal();
  static final _SAVE_USER_LOGIN_KEY = "user/login";
  static final _SAVE_USER_REGISTER_KEY = "user/register";
  static final _SAVE_TOKEN_KEY = "save_token_key";

  static HttpManager getInstance() {
    return _instance;
  }

  late Dio dio;

  HttpManager._internal() {
    dio = Dio(BaseOptions(
        baseUrl: "https://www.wanandroid.com",
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json));
    dio.interceptors.add(LogInterceptor(responseBody: true));

    // 设置登陆cookie设置
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final cookie = await LocalTools.get<String>(_SAVE_TOKEN_KEY);
      if (cookie != null) {
        options.headers["Cookie"] = cookie;
      }
      handler.next(options);
    }, onResponse: (response, handler) async {
      final uri = response.realUri.toString();
      if (uri.contains(RegExp(_SAVE_USER_LOGIN_KEY)) ||
          uri.contains(RegExp(_SAVE_USER_REGISTER_KEY))) {
        final cookie = response.headers.map["set-cookie"].toString();
        LocalTools.save<String>(_SAVE_TOKEN_KEY, cookie);
      }
      handler.next(response);
    }, onError: (error, handler) {
      handler.next(error);
    }));
  }
}
