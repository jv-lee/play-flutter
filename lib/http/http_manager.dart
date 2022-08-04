import 'package:dio/dio.dart';
import 'package:playflutter/http/constants/api_constants.dart';
import 'package:playflutter/http/interceptor/app_cookie_interceptor.dart';

/// @author jv.lee
/// @date 2020/5/8
/// @description 网络请求封装工具类
class HttpManager {
  static final HttpManager _instance = HttpManager._internal();

  static HttpManager getInstance() {
    return _instance;
  }

  late Dio dio;

  HttpManager._internal() {
    dio = Dio(BaseOptions(
        baseUrl: ApiConstants.BASE_URI,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(AppCookieInterceptor());
  }
}
