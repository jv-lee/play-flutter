import 'package:playflutter/core/base/base_model.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/model/entity/tab.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class ProjectModel extends BaseModel {
  Future<TabData> getProjectTabDataAsync() async {
    return requestGet(
        path: "/project/tree/json",
        create: (resource) => TabData.fromJson(resource));
  }

  /// 获取项目列表数据
  /// [id] 项目TabId 由tab接口获取
  /// [page] 分页页面 取值[1-40]
  Future<ContentData> getProjectListDataAsync(page, id) async {
    var queryParams = <String, dynamic>{"cid": id};
    return requestGet(
        path: "/project/list/$page/json",
        create: (resource) => ContentData.fromJson(resource),
        queryParameters: queryParams);
  }
}
