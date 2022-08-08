import 'package:dio/dio.dart';
import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/entity/data.dart';

/// @author jv.lee
/// @date 2022/8/5
/// @description
class CollectModel extends BaseModel {
  ///  收藏文章
  ///  [id] 文章id
  Future<Data> postCollectAsync(id) async {
    return requestPost(
        path: "/lg/collect/$id/json",
        create: (resource) => Data.fromJson(resource));
  }

  ///  取消收藏文章
  ///  [id] 文章id
  ///  [originId]
  Future<Data> postUnCollectAsync(id, originId) async {
    return requestPost(
        path: "/lg/uncollect/$id/json",
        create: (resource) => Data.fromJson(resource),
        data: FormData.fromMap({"originId": originId}));
  }

  /// 获取收藏记录
  /// [page] 0 - *
  Future<ContentData> getCollectListAsync(page) async {
    return requestGet(
        path: "/lg/collect/list/$page/json",
        create: (resource) => ContentData.fromJson(resource));
  }
}
