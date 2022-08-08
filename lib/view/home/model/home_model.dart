import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/banner.dart';
import 'package:playflutter/model/entity/content.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面数据处理类
class HomeModel extends BaseModel {
  Future<BannerData> getBannerDataAsync() async {
    return requestGet(
        path: "/banner/json",
        create: (resource) => BannerData.fromJson(resource));
  }

  Future<ContentData> getContentDataAsync(int page) async {
    return requestGet(
        path: "/article/list/$page/json",
        create: (resource) => ContentData.fromJson(resource));
  }
}
