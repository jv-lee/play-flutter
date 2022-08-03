/// @author jv.lee
/// @date 2022/7/29
/// @description 全局常量
// ignore_for_file: constant_identifier_names

class ThemeConstants {
  /// request
  static const REQUEST_OK = 0; // 站点api请求 成功码
  static const REQUEST_TOKEN_ERROR = -1001; // 未登陆 错误码
  static const REQUEST_TOKEN_ERROR_MESSAGE = "TOKEN-ERROR"; // 登陆token失效错误自负

  /// ui data
  static const String OFFICIAL_TAB_LOCAL_KEY = "official_tab_local_key";
  static const String PROJECT_TAB_LOCAL_KEY = "project_tab_local_key";
  static const String ACCOUNT_DATA_LOCAL_KEY = "account_data_local_key";
}
