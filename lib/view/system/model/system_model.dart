import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/entity/navigation_tab.dart';
import 'package:playflutter/model/entity/parent_tab.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class SystemModel extends BaseModel {
  Future<ParentTabData> getParentTabAsync() async {
    return requestGet(
        path: "/tree/json",
        create: (resource) => ParentTabData.fromJson(resource));
  }

  Future<NavigationTabData> getNavigationTabAsync() async {
    return requestGet(
        path: "/navi/json",
        create: (resource) => NavigationTabData.fromJson(resource));
  }

  Future<ContentData> getContentDataAsync(page, id) async {
    var queryParams = <String, dynamic>{"cid": id};
    return requestGet(
        path: "/article/list/$page/json",
        create: (resource) => ContentData.fromJson(resource),
        queryParameters: queryParams);
  }
}
