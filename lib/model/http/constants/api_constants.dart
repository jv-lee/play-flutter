// ignore_for_file: constant_identifier_names
/// @author jv.lee
/// @date 2022/8/4
/// @description Api常量类
class ApiConstants {
  static const BASE_URI = "https://www.wanandroid.com";
  static const REQUEST_OK = 0; // 站点api请求 成功码
  static const REQUEST_TOKEN_ERROR = -1001; // 未登陆 错误码
  static const REQUEST_TOKEN_ERROR_MESSAGE = "TOKEN-ERROR"; // 登陆token失效错误自负

  // 积分规则地址
  static const URI_COIN_HELP = "https://www.wanandroid.com/blog/show/2653";
}
