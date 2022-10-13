import 'package:playflutter/core/extensions/json_extensions.dart';
import 'package:playflutter/core/model/entity/base/base_data.dart';

/// @author jv.lee
/// @date 2022/10/12
/// @description
class SearchHotData extends BaseData {
  SearchHotData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final List<SearchHot> data;
  late final int errorCode;
  late final String errorMsg;

  SearchHotData.fromJson(Map<String, dynamic> json) {
    data = json.formatList('data', (json) => SearchHot.fromJson(json));
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

class SearchHot {
  SearchHot({
    required this.id,
    required this.link,
    required this.name,
    required this.order,
    required this.visible,
  });

  late final int id;
  late final String link;
  late final String name;
  late final int order;
  late final int visible;

  SearchHot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['name'] = name;
    data['order'] = order;
    data['visible'] = visible;
    return data;
  }
}
