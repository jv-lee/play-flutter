import 'dart:io';

import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/entity/navigation_tab.dart';
import 'package:playflutter/model/entity/parent_tab.dart';
import 'package:playflutter/model/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class SystemModel extends BaseModel {
  Future<ParentTabData> getParentTabAsync() async {
    var response = await HttpManager.getInstance().dio.get("/tree/json");
    if (response.statusCode == 200) {
      ParentTabData contentData = ParentTabData.fromJson(response.data);
      if (contentData.errorCode == 0) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getParentTabAsync http exception.");
  }

  Future<NavigationTabData> getNavigationTabAsync() async {
    var response = await HttpManager.getInstance().dio.get("/navi/json");
    if (response.statusCode == 200) {
      NavigationTabData contentData = NavigationTabData.fromJson(response.data);
      if (contentData.errorCode == 0) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getNavigationTabAsync http exception.");
  }

  Future<ContentData> getContentDataAsync(page, id) async {
    var queryParams = <String, dynamic>{"cid": id};
    var response = await HttpManager.getInstance()
        .dio
        .get("/article/list/$page/json", queryParameters: queryParams);
    if (response.statusCode == 200) {
      ContentData contentData = ContentData.fromJson(response.data);
      if (contentData.errorCode == 0) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getNavigationTabAsync http exception.");
  }

}
