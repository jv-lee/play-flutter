import 'package:dio/dio.dart';
import 'package:playflutter/core/base/base_model.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/model/entity/search_hot.dart';

/// @author jv.lee
/// @date 2022/7/21
/// @description
class SearchModel extends BaseModel {
  Future<ContentData> getSearchDataAsync(int page, String searchKey) async {
    return requestPost(
        path: "/article/query/$page/json",
        create: (resource) => ContentData.fromJson(resource),
        data: FormData.fromMap({"k": searchKey}));
  }

  Future<SearchHotData> getSearchHotDataAsync() async {
    return requestGet(
        path: "/hotkey/json", create: (resource) => SearchHotData.fromJson(resource));
  }
}
