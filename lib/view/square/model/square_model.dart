import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/entity/data.dart';
import 'package:playflutter/http/constants/api_constants.dart';
import 'package:playflutter/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description 广场模块数据处理类
class SquareModel extends BaseModel {
  Future<ContentData> getSquareDataAsync(int page) async {
    var response = await HttpManager.getInstance()
        .dio
        .get("/user_article/list/$page/json");
    if (response.statusCode == 200) {
      ContentData contentData = ContentData.fromJson(response.data);
      if (contentData.errorCode == 0) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getContentDataAsync http exception.");
  }

  /// 发布我分享的文章
  /// [title] 文章标题
  /// [link] 文章链接
  Future<Data> postShareDataSync(title, link) async {
    var response = await HttpManager.getInstance().dio.post(
        "/lg/user_article/add/json",
        data: FormData.fromMap({"title": title, "link": link}));
    if (response.statusCode == 200) {
      Data data = Data.fromJson(response.data);
      if (data.errorCode == 0) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "postShareDataSync http exception.");
  }

  ///  删除我的分享文章
  ///  [id] 文章id
  Future<Data> postDeleteShareAsync(id) async {
    var response = await HttpManager.getInstance()
        .dio
        .post("/lg/user_article/delete/$id/json");
    if (response.statusCode == 200) {
      Data data = Data.fromJson(response.data);
      if (data.errorCode == ApiConstants.REQUEST_OK) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "postDeleteShareAsync http exception.");
  }

  /// 我的分享列表
  /// [page] 分页页面 取值[1-40]
  Future<ContentData> getMyShareDataSync(page) async {
    var response = await HttpManager.getInstance()
        .dio
        .get("/user/lg/private_articles/$page/json");
    if (response.statusCode == 200) {
      ContentData contentData = ContentData.fromJson(response.data);
      if (contentData.errorCode == ApiConstants.REQUEST_OK) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getMyShareDataSync http exception.");
  }
}
