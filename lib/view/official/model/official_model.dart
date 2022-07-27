import 'dart:io';

import 'package:playflutter/entity/content.dart';
import 'package:playflutter/entity/tab.dart';
import 'package:playflutter/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class OfficialModel {

  Future<TabData> getOfficialTabDataAsync() async {
    var response =
        await HttpManager.getInstance().dio.get("/wxarticle/chapters/json");
    if (response.statusCode == 200) {
      TabData tabData = TabData.fromJson(response.data);
      if (tabData.errorCode == 0) {
        return tabData;
      } else {
        throw HttpException(tabData.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getOfficialTabDataAsync http exception.");
  }

  /// 获取公众号列表数据
  /// [id] 公众号TabId 由tab接口获取
  /// [page] 分页页面 取值[1-40]
  Future<ContentData> getOfficialListDataAsync(page, id) async {
    var response = await HttpManager.getInstance()
        .dio
        .get("/wxarticle/list/$id/$page/json");
    if (response.statusCode == 200) {
      ContentData listData = ContentData.fromJson(response.data);
      if (listData.errorCode == 0) {
        return listData;
      } else {
        throw HttpException(listData.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getOfficialListDataAsync http exception.");
  }

}
