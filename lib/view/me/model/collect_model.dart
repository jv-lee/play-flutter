import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/entity/data.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/model/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/8/5
/// @description
class CollectModel extends BaseModel {
  ///  收藏文章
  ///  [id] 文章id
  Future<Data> postCollectAsync(id) async {
    var response =
        await HttpManager.getInstance().dio.post("/lg/collect/$id/json");
    if (response.statusCode == 200) {
      Data data = Data.fromJson(response.data);
      if (data.errorCode == ApiConstants.REQUEST_OK) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "postCollectAsync http exception.");
  }

  ///  取消收藏文章
  ///  [id] 文章id
  ///  [originId]
  Future<Data> postUnCollectAsync(id, originId) async {
    var response = await HttpManager.getInstance().dio.post(
        "/lg/uncollect/$id/json",
        data: FormData.fromMap({"originId": originId}));
    if (response.statusCode == 200) {
      Data data = Data.fromJson(response.data);
      if (data.errorCode == ApiConstants.REQUEST_OK) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "postUnCollectAsync http exception.");
  }

  /// 获取收藏记录
  /// [page] 0 - *
  Future<ContentData> getCollectListAsync(page) async {
    var response =
        await HttpManager.getInstance().dio.get("/lg/collect/list/$page/json");
    if (response.statusCode == 200) {
      ContentData contentData = ContentData.fromJson(response.data);
      if (contentData.errorCode == ApiConstants.REQUEST_OK) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getCollectListAsync http exception.");
  }
}
