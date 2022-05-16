import 'package:dio/dio.dart';

/// @author jv.lee
/// @date 2020/5/8
/// @description
class HttpManager {
  HttpManager._internal();

  static final HttpManager _instance = HttpManager._internal();

  static HttpManager getInstance() {
    return _instance;
  }

    final Dio dio = Dio(BaseOptions(
      baseUrl: "https://www.wanandroid.com",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
}
