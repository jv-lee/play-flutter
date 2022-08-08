import 'dart:io';

import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/entity/tab.dart';
import 'package:playflutter/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class ProjectModel extends BaseModel {
  Future<TabData> getProjectTabDataAsync() async {
    var response =
        await HttpManager.getInstance().dio.get("/project/tree/json");
    if (response.statusCode == 200) {
      TabData tabData = TabData.fromJson(response.data);
      if (tabData.errorCode == 0) {
        return tabData;
      } else {
        throw HttpException(tabData.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getProjectTabDataAsync http exception.");
  }

  /// 获取项目列表数据
  /// [id] 项目TabId 由tab接口获取
  /// [page] 分页页面 取值[1-40]
  Future<ContentData> getProjectListDataAsync(page, id) async {
    var queryParams = <String, dynamic>{"cid": id};
    var response = await HttpManager.getInstance()
        .dio
        .get("/project/list/$page/json", queryParameters: queryParams);
    if (response.statusCode == 200) {
      ContentData listData = ContentData.fromJson(response.data);
      if (listData.errorCode == 0) {
        return listData;
      } else {
        throw HttpException(listData.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getProjectListDataAsync http exception.");
  }
}
