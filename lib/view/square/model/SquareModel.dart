import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/entity/data.dart';
import 'package:playflutter/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description 广场模块数据处理类
class SquareModel {
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
}
