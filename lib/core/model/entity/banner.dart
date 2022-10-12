import 'package:playflutter/core/extensions/json_extensions.dart';
import 'package:playflutter/core/model/entity/base/base_data.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 首页banner数据实体
class BannerData extends BaseData {
  BannerData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final List<BannerItem> data;
  late final int errorCode;
  late final String errorMsg;

  BannerData.fromJson(Map<String, dynamic> json) {
    data = json.formatList('data', (json) => BannerItem.fromJson(json));
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data.map((e) => e.toJson()).toList();
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    return data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;
}

class BannerItem {
  BannerItem({
    required this.desc,
    required this.id,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  late final String desc;
  late final int id;
  late final String imagePath;
  late final int isVisible;
  late final int order;
  late final String title;
  late final int type;
  late final String url;

  BannerItem.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['desc'] = desc;
    data['id'] = id;
    data['imagePath'] = imagePath;
    data['isVisible'] = isVisible;
    data['order'] = order;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}
