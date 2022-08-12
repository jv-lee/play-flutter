import 'package:playflutter/model/entity/account.dart';
import 'package:playflutter/model/entity/base/base_data.dart';
import 'package:playflutter/model/entity/content.dart';

/// @author jv.lee
/// @date 2022/8/12
/// @description
class ShareData extends BaseData {
  ShareData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final ShareDataItem data;
  late final int errorCode;
  late final String errorMsg;

  ShareData.fromJson(Map<String, dynamic> json) {
    data = ShareDataItem.fromJson(json['data']);
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;
}

class ShareDataItem {
  ShareDataItem({
    required this.coinInfo,
    required this.shareArticles,
  });

  late final CoinInfo coinInfo;
  late final ContentDataPage shareArticles;

  ShareDataItem.fromJson(Map<String, dynamic> json) {
    coinInfo = CoinInfo.fromJson(json['coinInfo']);
    shareArticles = ContentDataPage.fromJson(json['shareArticles']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coinInfo'] = coinInfo.toJson();
    _data['shareArticles'] = shareArticles.toJson();
    return _data;
  }
}
