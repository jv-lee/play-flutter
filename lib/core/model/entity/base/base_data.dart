import 'package:playflutter/core/model/http/constants/api_constants.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 网络json数据返回实体 提供公共参数
abstract class BaseData {
  int responseCode();

  String responseMessage();

  bool responseIsSuccess() {
    return responseCode() == ApiConstants.REQUEST_OK;
  }
}
