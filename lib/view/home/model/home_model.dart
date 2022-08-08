import 'dart:io';

import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/banner.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面数据处理类
class HomeModel extends BaseModel {
  Future<BannerData> getBannerDataAsync() async {
    var response = await HttpManager.getInstance().dio.get("/banner/json");
    if (response.statusCode == 200) {
      BannerData bannerData = BannerData.fromJson(response.data);
      if (bannerData.errorCode == 0) {
        return bannerData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getBannerDataAsync http exception.");
  }

  Future<ContentData> getContentDataAsync(int page) async {
    var response =
        await HttpManager.getInstance().dio.get("/article/list/$page/json");
    if (response.statusCode == 200) {
      ContentData contentData = ContentData.fromJson(response.data);
      if (contentData.errorCode == 0) {
        return contentData;
      }
    }
    throw HttpException(
        response.statusMessage ?? "getContentDataAsync http exception.");
  }
}
