import 'dart:io';

import 'package:playflutter/entity/banner.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/http/http_manager.dart';

class HomeModel {
  Future<BannerData> getBannerDataAsync() async {
    var response = await HttpManager.getInstance().dio.get("/banner/json");
    if (response.statusCode == 200) {
      BannerData bannerData = BannerData.fromJson(response.data);
      if (bannerData.errorCode == 0) {
        return bannerData;
      }
    }
    throw HttpException(response.statusMessage);
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
    throw HttpException(response.statusMessage);
  }
}
