import 'package:playflutter/core/model/entity/base/base_data.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class TabData extends BaseData {
  TabData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final List<Tab> data;
  late final int errorCode;
  late final String errorMsg;

  TabData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Tab.fromJson(e)).toList();
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;
}

class Tab {
  Tab({
    required this.author,
    required this.children,
    required this.courseId,
    required this.cover,
    required this.desc,
    required this.id,
    required this.lisense,
    required this.lisenseLink,
    required this.name,
    required this.order,
    required this.parentChapterId,
    required this.userControlSetTop,
    required this.visible,
  });

  late final String author;
  late final List<dynamic> children;
  late final int courseId;
  late final String cover;
  late final String desc;
  late final int id;
  late final String lisense;
  late final String lisenseLink;
  late final String name;
  late final int order;
  late final int parentChapterId;
  late final bool userControlSetTop;
  late final int visible;

  Tab.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    children = List.castFrom<dynamic, dynamic>(json['children']);
    courseId = json['courseId'];
    cover = json['cover'];
    desc = json['desc'];
    id = json['id'];
    lisense = json['lisense'];
    lisenseLink = json['lisenseLink'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['author'] = author;
    _data['children'] = children;
    _data['courseId'] = courseId;
    _data['cover'] = cover;
    _data['desc'] = desc;
    _data['id'] = id;
    _data['lisense'] = lisense;
    _data['lisenseLink'] = lisenseLink;
    _data['name'] = name;
    _data['order'] = order;
    _data['parentChapterId'] = parentChapterId;
    _data['userControlSetTop'] = userControlSetTop;
    _data['visible'] = visible;
    return _data;
  }
}
