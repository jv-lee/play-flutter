import 'package:playflutter/core/model/entity/base/base_data.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 通用api返回data
class Data extends BaseData{
  Data({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final String data;
  late final int errorCode;
  late final String errorMsg;

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data;
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;
}
