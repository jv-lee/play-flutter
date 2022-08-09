// ignore_for_file: constant_identifier_names
/// @author jv.lee
/// @date 2022/8/4
/// @description Api常量类
class ApiConstants {
  static const BASE_URI = "https://www.wanandroid.com";
  static const REQUEST_OK = 0; // 站点api请求 成功码
  static const REQUEST_TOKEN_ERROR = -1001; // 未登陆 错误码
  static const REQUEST_TOKEN_ERROR_MESSAGE = "TOKEN-ERROR"; // 登陆token失效错误自负

  // 简书页面,掘金页面,知乎
  static const WEB_SCHEME_LIST = ["jianshu://", "bytedance://", "zhihu://"];
}