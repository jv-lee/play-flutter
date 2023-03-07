import 'package:playflutter/core/model/entity/account.dart';
import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/model/entity/content.dart';

/// @author jv.lee
/// @date 2022/8/12
/// @description 分享数据实体类
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
    final data = <String, dynamic>{};
    data['data'] = this.data.toJson();
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    return data;
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
    final data = <String, dynamic>{};
    data['coinInfo'] = coinInfo.toJson();
    data['shareArticles'] = shareArticles.toJson();
    return data;
  }
}
