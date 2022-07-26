import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/7/21
/// @description
class SearchModel {
  Future<ContentData> getSearchDataAsync(int page, String searchKey) async {
    var response = await HttpManager.getInstance().dio.post(
        "/article/query/$page/json",
        data: FormData.fromMap({"k": searchKey}));
    if (response.statusCode == 200) {
      ContentData contentData = ContentData.fromJson(response.data);
      if (contentData.errorCode == 0) {
        return contentData;
      } else {
        throw HttpException(contentData.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getSearchDataAsync http exception.");
  }
}
