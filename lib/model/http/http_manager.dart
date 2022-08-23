import 'package:dio/dio.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/model/http/interceptor/app_cookie_interceptor.dart';
import 'package:playflutter/model/http/interceptor/app_failed_interceptor.dart';

/// @author jv.lee
/// @date 2020/5/8
/// @description 网络请求封装工具类
class HttpManager {
  HttpManager._internal() {
    dio = createDio(ApiConstants.BASE_URI);
  }

  static final HttpManager _instance = HttpManager._internal();

  static HttpManager getInstance() => _instance;

  late Dio dio;

  static Dio createDio(String baseUri) {
    Dio dio = Dio(BaseOptions(
        baseUrl: baseUri,
        connectTimeout: 5000,
        receiveTimeout: 10000,
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.json));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(AppCookieInterceptor());
    dio.interceptors.add(AppFailedInterceptor());
    return dio;
  }
}

final httpManager = HttpManager.getInstance();
